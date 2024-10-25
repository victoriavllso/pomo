import 'package:flutter/material.dart';
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
              CourseSquare(
                  course: Course(
                      name: 'Matematica', id: 1212, icon: 'M', priority: 3),
              completedHours: 1.2,
              totalHours: 4,),
              // SizedBox(width: 20),
              CourseSquare(
                  course: Course(
                      name: 'Portugues', id: 1212, icon: 'P', priority: 3),
              completedHours: 3,
              totalHours: 4,),
            ],
          ),
        ),
      ),
    ),);
  }
}
