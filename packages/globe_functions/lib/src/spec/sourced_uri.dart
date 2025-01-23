class SourcedUri {
  final Uri uri;

  SourcedUri(this.uri);

  Uri call() => uri;

  Map<String, dynamic> toJson() => {
    'uri': uri.toString(),
  };

  factory SourcedUri.fromJson(Map<String, dynamic> json) {
    return SourcedUri(Uri.parse(json['uri'] as String));
  }
}
