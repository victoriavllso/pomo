import 'course.dart';
import 'history.dart';

class User {
  String name;
  int id;
  late List<Course> courses;
  String email;
  late String profileImage;
  int hoursDay;
  History history;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.hoursDay,
    required this.history
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      name: json['name'],
      email: json['email'],
      hoursDay: int.parse(json['hours_day']),
      history: History.fromJson(json['history'])
    );
  }

}