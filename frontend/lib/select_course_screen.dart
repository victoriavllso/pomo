import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'course.dart';
import 'course_square.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:provider/provider.dart';
import 'user_model.dart';
import 'course_creator_screen.dart';
import 'pomo_session_screen.dart';

class SelectCourseScreen extends StatefulWidget {
  const SelectCourseScreen({super.key});

  @override
  State<SelectCourseScreen> createState() => _SelectCourseScreenState();
}

class _SelectCourseScreenState extends State<SelectCourseScreen> {
  final _scrollController = ScrollController();

  void _navigateToCreateCourse() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseCreatorScreen()),
    );
  }

  void _navigateToPomodoroSession(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PomoSessionScreen(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<UserModel>(context).courses;

    return Scaffold(
      body: GradientBackground(
        title: 'Selecione uma **disciplina**',
        child: Padding(
          padding:
          const EdgeInsets.only(top: 350, bottom: 320, left: 60, right: 60),
          child: FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.05,
            gradientFractionOnEnd: 0.4,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: [
                NewDisciplineButton(
                  onPressed: _navigateToCreateCourse,
                ),
                ...courses.map((course) {
                  return CourseSquare(
                    course: course,
                    completedHours: 1.2, // Dados de exemplo
                    totalHours: 4.0, // Dados de exemplo
                    onPressed: () => _navigateToPomodoroSession(course),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}