typedef NullableType<T> = T?;

final class DartTypeRef<T> {
  const DartTypeRef([this.customName]);

  final String? customName;

  String get name => customName ?? T.toString();

  @override
  Type get runtimeType => T;

  DartTypeRef<Object?> asNullable() => DartTypeRef<NullableType<T>>(customName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartTypeRef &&
          other.customName == customName &&
          other.runtimeType == runtimeType;

  @override
  int get hashCode => Object.hash(customName, runtimeType);

  @override
  String toString() => name;
}
