class ProjectSettings {
  ProjectSettings({
    required this.rootDirectory,
    required this.preset,
    required this.buildCommand,
    required this.entrypoint,
    required this.environmentVariables,
  });

  final String? rootDirectory;
  final String? preset;
  final String? buildCommand;
  final String? entrypoint;
  final Map<String, String>? environmentVariables;

  Map<String, dynamic> toJson() {
    return {
      'rootDirectory': rootDirectory,
      'preset': preset,
      'buildCommand': buildCommand,
      'entrypoint': entrypoint,
      'environmentVariables': environmentVariables,
    };
  }
}
