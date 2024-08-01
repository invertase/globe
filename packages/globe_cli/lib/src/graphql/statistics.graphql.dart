// ignore_for_file: type=lint
enum Enum$Interval {
  Day,
  Week,
  Month,
  $unknown;

  factory Enum$Interval.fromJson(String value) => fromJson$Enum$Interval(value);

  String toJson() => toJson$Enum$Interval(this);
}

String toJson$Enum$Interval(Enum$Interval e) {
  switch (e) {
    case Enum$Interval.Day:
      return r'Day';
    case Enum$Interval.Week:
      return r'Week';
    case Enum$Interval.Month:
      return r'Month';
    case Enum$Interval.$unknown:
      return r'$unknown';
  }
}

Enum$Interval fromJson$Enum$Interval(String value) {
  switch (value) {
    case r'Day':
      return Enum$Interval.Day;
    case r'Week':
      return Enum$Interval.Week;
    case r'Month':
      return Enum$Interval.Month;
    default:
      return Enum$Interval.$unknown;
  }
}
