import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticator_provider.dart';
import 'gradient_background.dart';
import 'course.dart';
import 'course_square.dart';

class SelectCourseScreen extends StatelessWidget {
  const SelectCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final user = authProvider.user;
    final userCourses = user?.courses;
    return MaterialApp(
      home: GradientBackground(
        title: 'Selecione uma **disciplina**',
        child: ListView(
          // scrollDirection: Axis.horizontal,
          children: [
            ...?userCourses?.map((course) => CourseSquare(course: course, completedHours: user!.history.completedHours(course.id), totalHours: course.hoursWeek))
          ],
        ),
      ),
    );
  }
}
