// courses_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gradient_background.dart';
import 'course_white.dart';
import 'user_model.dart';
import 'course_creator_screen.dart';
import 'home_screen.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final _scrollController = ScrollController();

  void _navigateToCreateCourse() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseCreatorScreen()),
    );
    setState(() {}); // Atualiza a tela ao retornar
  }

  void _handleFinalize() {
    // Verifica se há pelo menos uma disciplina
    if (Provider.of<UserModel>(context, listen: false).courses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, adicione pelo menos uma disciplina')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
      body: GradientBackground(
        title: "Quais são **suas disciplinas?**",
        subTitle:
        "Indique também o nível de prioridade que ela tem: 1 é pouco, 5 é muito.",
        step: 4,
        totalSteps: 4,
        buttonName: "Finalizar",
        buttonAction: _handleFinalize,
        child: Padding(
          padding: const EdgeInsets.only(top: 360, bottom: 220),
          child: FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.05,
            gradientFractionOnEnd: 0.4,
            child: ListView(
              controller: _scrollController,
              children: [
                NewDisciplineButton(
                  onPressed: _navigateToCreateCourse,
                ),
                ...userModel.courses.map((course) {
                  return CourseWhite(course: course);
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}