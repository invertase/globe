import 'package:globe_auth/src/default_client.dart';
import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';

class GlobeAuth {
  GlobeAuth._({
    required String projectId,
    required String publicKey,
    GlobeAuthRestClient? client,
    String? baseUrl,
  }) : client =
           client ??
           getDefaultRestClient(
             projectId,
             publicKey: publicKey,
             baseUrl: baseUrl,
           );

  factory GlobeAuth.project(String projectId, {required String publicKey, String? baseUrl}) {
    return GlobeAuth._(projectId: projectId, publicKey: publicKey, baseUrl: baseUrl);
  }

  final GlobeAuthRestClient client;

  Stream<GlobeAuthState> get state => client.state;
}
