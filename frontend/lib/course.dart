class Course {
  String name;
  int id;
  late List<String> sessions;
  String icon;
  int priority;
  int hoursWeek;

  Course({
    required this.id,
    required this.name,
    required this.icon,
    required this.priority,
    required this.hoursWeek
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: int.parse(json['id']),
        name: json['name'].substring(0, json['name'].length - 1),
        icon: json['name'][json['name'].length - 1],
        priority: int.parse(json['priority']),
        hoursWeek: int.parse(json['hours_week'])
    );
  }
}