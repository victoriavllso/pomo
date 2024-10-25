import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'course.dart';
import 'course_square.dart';

class SelectCourseScreen extends StatelessWidget {
  const SelectCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GradientBackground(
        title: 'Selecione uma **disciplina**',
        child: ListView(
          // scrollDirection: Axis.horizontal,
          children: [
            CourseSquare(
                course: Course(
                    name: 'Matematica', id: 1212, icon: 'M', priority: 3),
            completedHours: 1.2,
            totalHours: 4,)
          ],
        ),
      ),
    );
  }
}
