import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticator_provider.dart';
import 'gradient_background.dart';
import 'course.dart';
import 'course_square.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class SelectCourseScreen extends StatefulWidget {
  const SelectCourseScreen({super.key});

  @override
  State<SelectCourseScreen> createState() => _SelectCourseScreenState();
}

class _SelectCourseScreenState extends State<SelectCourseScreen> {
  final _scrollController = ScrollController();
 // Adicionando o ScrollController
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final user = authProvider.user;
    final userCourses = user?.courses;
    return MaterialApp(
      home: GradientBackground(
        title: 'Selecione uma **disciplina**',
        child: Padding(
          padding: const EdgeInsets.only(top: 350, bottom: 320, left: 60, right: 60),
          child: FadingEdgeScrollView.fromScrollView(
              gradientFractionOnStart: 0.05, // Fração do desvanecimento no início
              gradientFractionOnEnd: 0.4,
          child:
          ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: [
              NewDisciplineButton(),
              ...?userCourses?.map((course) => CourseSquare(course: course, completedHours: user!.history.completedHours(course.id), totalHours: course.hoursWeek))
            ],
          ),
        ),
      ),
    ),);
  }
}
