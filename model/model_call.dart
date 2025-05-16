class AgeDetailes {
  int count;
  String name;
  int age;

  AgeDetailes({required this.count, required this.name, required this.age});

  factory AgeDetailes.fromJson(Map map) {
    return AgeDetailes(count: map['count'], name: map['name'], age: map['age']);
  }

}
