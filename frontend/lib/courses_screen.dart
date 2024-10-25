import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'course_white.dart';
import 'course.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final _scrollController = ScrollController(); // Adicionando o ScrollController

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GradientBackground(
        title: "Quais são **suas disciplinas?**",
        subTitle: "Indique também o nível de prioridade que ela tem: 1 é pouco, 5 é muito.",
        step: 4,
        totalSteps: 4,
        buttonName: "Finalizar",
        child: Padding(
          padding: const EdgeInsets.only(top: 360, bottom: 220),
          child: FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.05, // Fração do desvanecimento no início
            gradientFractionOnEnd: 0.4, // Fração do desvanecimento no fim
            child: ListView(
              controller: _scrollController, // Controlador da lista
              children: [
                const NewDisciplineButton(), // Botão para adicionar nova disciplina
                CourseWhite(course: Course(name: 'Matemática', id: 8394, icon: "🧮", priority: 2)),
                CourseWhite(course: Course(name: 'Ciências', id: 2398, icon: "🔬", priority: 3)),
                CourseWhite(course: Course(name: 'História', id: 4839, icon: "📜", priority: 4)),
                CourseWhite(course: Course(name: 'História', id: 4839, icon: "📜", priority: 4)),
                CourseWhite(course: Course(name: 'História', id: 4839, icon: "📜", priority: 4)),
                CourseWhite(course: Course(name: 'História', id: 4839, icon: "📜", priority: 4)),
                CourseWhite(course: Course(name: 'História', id: 4839, icon: "📜", priority: 4)),
                // Adicione mais cursos aqui
              ],
            ),
          ),
        ),
      ),
    );
  }
}