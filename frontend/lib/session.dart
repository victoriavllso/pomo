import 'course.dart';

class Session {
  int id;
  Course course;
  DateTime startDatetime;
  DateTime endDatetime;

  Duration get duration => endDatetime.difference(startDatetime);

  Session({
    required this.id,
    required this.course,
    required this.startDatetime,
    required this.endDatetime
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
        id: int.parse(json['id']),
        course: Course.fromJson(json),
        startDatetime: DateTime.parse("${json['start_date']}T${json['start_time']}"),
        endDatetime: DateTime.parse("${json['end_date']}T${json['end_time']}")
    );
  }

}