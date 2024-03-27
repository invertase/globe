class {{primary_endpoint.pascalCase()}} {
  final String id;
  final String description;

  {{primary_endpoint.pascalCase()}}({
    required this.id, 
    required this.description,
  });
}
