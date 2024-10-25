class Course {
  String name;
  int id;
  List<String> sessions;
  String icon;
  int priority;

  Course({
    required this.name,
    required this.id,
    required this.icon,
    required this.priority,
  }) : sessions = [];


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'icon': icon,
      'priority': priority,
      'sessions': sessions,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    Course course = Course(
      name: json['name'],
      id: json['id'],
      icon: json['icon'],
      priority: json['priority'],
    );
    course.sessions = List<String>.from(json['sessions']);
    return course;
  }
}