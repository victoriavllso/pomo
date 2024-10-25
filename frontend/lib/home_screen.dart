// home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'course_square.dart';
import 'course.dart';
import 'user_model.dart';
import 'select_course_screen.dart';
import 'pomo_session_screen.dart';
import 'course_creator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToSelectCourse() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectCourseScreen()),
    );
  }

  void _navigateToPomodoroSession(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PomoSessionScreen(course: course)),
    );
  }

  void _navigateToCreateCourse() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseCreatorScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final courses = userModel.courses;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF2EE),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Oi, ${userModel.name}! 👋',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cera Pro',
                      color: Color(0xFFF55A2D),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _navigateToSelectCourse,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/play_button.svg',
                    width: 350,
                    height: 350,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'disciplinas',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cera Pro',
                      color: Color(0xFFF55A2D),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Lista de disciplinas
            SizedBox(
              height: 250,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: FadingEdgeScrollView.fromScrollView(
                  gradientFractionOnStart: 0.05,
                  gradientFractionOnEnd: 0.4,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: courses.length + 1, // +1 para o botão de nova disciplina
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Primeiro item é o botão de adicionar nova disciplina
                        return NewDisciplineButton(
                          onPressed: _navigateToCreateCourse,
                        );
                      } else {
                        final course = courses[index - 1];
                        return CourseSquare(
                          course: course,
                          completedHours: 1.2 * index, // Substitua pelos dados reais
                          totalHours: 4.0 * index, // Substitua pelos dados reais
                          colored: index,
                          onPressed: () => _navigateToPomodoroSession(course),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}