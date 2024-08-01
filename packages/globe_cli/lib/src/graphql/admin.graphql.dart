// ignore_for_file: type=lint
enum Enum$EntityType {
  Organization,
  Deployment,
  Project,
  UserId,
  BuildId,
  $unknown;

  factory Enum$EntityType.fromJson(String value) =>
      fromJson$Enum$EntityType(value);

  String toJson() => toJson$Enum$EntityType(this);
}

String toJson$Enum$EntityType(Enum$EntityType e) {
  switch (e) {
    case Enum$EntityType.Organization:
      return r'Organization';
    case Enum$EntityType.Deployment:
      return r'Deployment';
    case Enum$EntityType.Project:
      return r'Project';
    case Enum$EntityType.UserId:
      return r'UserId';
    case Enum$EntityType.BuildId:
      return r'BuildId';
    case Enum$EntityType.$unknown:
      return r'$unknown';
  }
}

Enum$EntityType fromJson$Enum$EntityType(String value) {
  switch (value) {
    case r'Organization':
      return Enum$EntityType.Organization;
    case r'Deployment':
      return Enum$EntityType.Deployment;
    case r'Project':
      return Enum$EntityType.Project;
    case r'UserId':
      return Enum$EntityType.UserId;
    case r'BuildId':
      return Enum$EntityType.BuildId;
    default:
      return Enum$EntityType.$unknown;
  }
}
