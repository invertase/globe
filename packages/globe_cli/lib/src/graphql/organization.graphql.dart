// ignore_for_file: type=lint
enum Enum$OrganizationType {
  personal,
  organization,
  $unknown;

  factory Enum$OrganizationType.fromJson(String value) =>
      fromJson$Enum$OrganizationType(value);

  String toJson() => toJson$Enum$OrganizationType(this);
}

String toJson$Enum$OrganizationType(Enum$OrganizationType e) {
  switch (e) {
    case Enum$OrganizationType.personal:
      return r'personal';
    case Enum$OrganizationType.organization:
      return r'organization';
    case Enum$OrganizationType.$unknown:
      return r'$unknown';
  }
}

Enum$OrganizationType fromJson$Enum$OrganizationType(String value) {
  switch (value) {
    case r'personal':
      return Enum$OrganizationType.personal;
    case r'organization':
      return Enum$OrganizationType.organization;
    default:
      return Enum$OrganizationType.$unknown;
  }
}
