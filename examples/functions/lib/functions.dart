class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      json['name'] as String,
      json['age'] as int,
    );
  }
}
