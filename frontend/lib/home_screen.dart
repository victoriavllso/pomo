import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'course_square.dart';
import 'course.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    // Descarta o ScrollController
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lista de cursos de exemplo
    List<Course> courses = [
      Course(name: 'Matemática', id: 1212, icon: '📐', priority: 3),
      Course(name: 'Português', id: 1213, icon: '📖', priority: 2),
      Course(name: 'História', id: 1214, icon: '📜', priority: 1),
      // Adicione mais cursos conforme necessário
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF2EE),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Oi, Pedro! 👋',
                    style: TextStyle(
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
              onTap: () {
                // Adicione a funcionalidade para o botão de play
              },
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
            // Ajuste da ListView para altura de 100 pixels e margens laterais de 60 pixels
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
                    itemCount: courses.length + 1,
                    // +1 para o NewDisciplineButton
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Primeiro item é o NewDisciplineButton
                        return const NewDisciplineButton();
                      } else {
                        // Incrementa 'colored' para cada item
                        int coloredValue = index; // Começa em 1
                        return CourseSquare(
                          course: courses[index - 1],
                          completedHours: 1.2 * index, // Dados de exemplo
                          totalHours: 4.0 * index, // Dados de exemplo
                          colored: coloredValue,
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
