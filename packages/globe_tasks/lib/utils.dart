import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:pub_semver/pub_semver.dart';

final _globeBuildImagesUri =
    Uri(scheme: 'https', host: 'globe.dev', path: 'api/build-images');

final _dotRegex = RegExp(r'(.*\..*){2,}');

class _DockerImage {
  final Version version;
  final DateTime lastUpdated;

  _DockerImage({
    required this.version,
    required this.lastUpdated,
  });

  factory _DockerImage.fromJson(Map<String, dynamic> json) {
    return _DockerImage(
      version: Version.parse(json['name']),
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }

  String get channel {
    if (isMajorRelease) {
      return 'stable';
    } else if (isBetaRelease) {
      return 'beta';
    }
    return 'dev';
  }

  bool get isMajorRelease => version.preRelease.isEmpty;

  bool get isBetaRelease =>
      version.isPreRelease && version.preRelease.contains('beta');

  bool get isDevRelease =>
      version.isPreRelease && version.preRelease.contains('sdk');
}

final class SdkRelease {
  final DateTime date;
  final String version;
  final String channel;

  const SdkRelease({
    required this.date,
    required this.version,
    required this.channel,
  });

  factory SdkRelease.fromJson(String channel, Map<String, dynamic> json) {
    return SdkRelease(
      channel: channel,
      version: json['version'],
      date: DateTime.parse(json['date']),
    );
  }

  @override
  String toString() => version;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is! SdkRelease) return false;

    return other.version == version && other.channel == channel;
  }

  @override
  int get hashCode => Object.hash(version, channel);
}

typedef LatestSdkRelease = ({
  SdkRelease stable,
  SdkRelease beta,
  SdkRelease? dev,
});

typedef LatestGlobeImages = ({
  SdkRelease? stable,
  SdkRelease? beta,
  SdkRelease? dev,
});

Future<LatestGlobeImages> getLatestSdkFromGlobe(
  String apiToken,
  String image,
) async {
  final result = await http.get(
    _globeBuildImagesUri.replace(queryParameters: {'image': image}),
    headers: {'x-api-token': apiToken},
  );

  final buildImages =
      (Map<String, dynamic>.from(jsonDecode(result.body))['data'] as Iterable);

  final dartVersions = buildImages
      .map((data) => SdkRelease(
          date: DateTime.parse(data['releaseDate']),
          version: data['version'],
          channel: data['channel']))
      .sorted((a, b) => b.date.compareTo(a.date));

  return (
    stable: dartVersions.firstWhereOrNull((e) => e.channel == 'stable'),
    beta: dartVersions.firstWhereOrNull((e) => e.channel == 'beta'),
    dev: dartVersions.firstWhereOrNull((e) => e.channel == 'dev'),
  );
}

Future<LatestSdkRelease> getLatestFlutterRelease() async {
  final url = Uri.parse(
    'https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json',
  );
  final result = await http.get(url);
  final resultJson = Map<String, dynamic>.from(jsonDecode(result.body));
  final releases = resultJson['releases'] as Iterable;

  final stable = releases.firstWhere((e) => e['channel'] == 'stable');
  final beta = releases.firstWhere((e) => e['channel'] == 'beta');
  final dev = releases.firstWhere((e) => e['channel'] == 'dev');

  SdkRelease parseData(Map<String, dynamic> data) => SdkRelease(
        date: DateTime.parse(data['release_date']),
        version: data['version'],
        channel: data['channel'],
      );

  return (
    stable: parseData(stable),
    beta: parseData(beta),
    dev: parseData(dev),
  );
}

Future<List<_DockerImage>> _getDockerDartImageTags() async {
  final url = Uri.parse(
    'https://hub.docker.com/v2/repositories/library/dart/tags?name=&ordering=last_updated&page=1&page_size=100',
  );
  final result = await http.get(url);
  return (json.decode(result.body)['results'] as Iterable)
      .where((e) {
        final hasLinuxRelease =
            (e['images'] as Iterable).any((e) => e['os'] == 'linux');

        final name = e['name'].toString();
        return hasLinuxRelease && _dotRegex.hasMatch(name);
      })
      .map(((e) => _DockerImage.fromJson(e)))
      .toList(growable: false);
}

Future<LatestSdkRelease> getLatestDartReleases() async {
  final dartImageTags = await _getDockerDartImageTags();
  final stableRelease = dartImageTags.firstWhere((e) => e.isMajorRelease);
  final betaRelease = dartImageTags.firstWhere((e) => e.isBetaRelease);
  final devRelease = dartImageTags.firstWhere((e) => e.isDevRelease);

  sdkReleaseFromDockerImage(_DockerImage image) => SdkRelease(
        channel: image.channel,
        date: image.lastUpdated,
        version: image.version.toString(),
      );

  return (
    stable: sdkReleaseFromDockerImage(stableRelease),
    beta: sdkReleaseFromDockerImage(betaRelease),
    dev: sdkReleaseFromDockerImage(devRelease),
  );
}

enum Workflow {
  dart(),
  flutter();

  const Workflow();

  String get yaml => switch (this) {
        Workflow.dart => 'add_dart_image.yaml',
        Workflow.flutter => 'add_flutter_image.yaml',
      };

  Map<String, dynamic> input(SdkRelease release) => {
        '${name}_version': release.version,
        '${name}_channel': release.channel,
        'release_date': release.date.toIso8601String(),
        'is_latest': release.channel == 'stable',
      };
}

Future<void> triggerWorkflow(
  String token,
  Workflow flow,
  SdkRelease release,
) async {
  final apiUrl = Uri.parse(
    'https://api.github.com/repos/invertase/dart_globe/actions/workflows/${flow.yaml}/dispatches',
  );

  final result = await http.post(
    apiUrl,
    headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28',
    },
    body: json.encode({
      'ref': 'chore/add-scripts-for-provisioning-dart-flutter-images',
      'inputs': flow.input(release),
    }),
  );

  print(result.body);
}
