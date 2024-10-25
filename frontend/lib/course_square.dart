import 'package:flutter/material.dart';
import 'course.dart';

class CourseSquare extends StatelessWidget {
  final Course course;
  final double completedHours; // Horas completadas
  final double totalHours; // Total de horas a serem completadas

  const CourseSquare({
    super.key,
    required this.course,
    required this.completedHours,
    required this.totalHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Largura fixa do quadrado
      height: 150, // Altura fixa do quadrado
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Fundo branco
        borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Sombra leve
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ícone do curso dentro do círculo
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.orange, // Fundo laranja
            child: Text(
              course.icon, // Ícone do curso
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(height: 10),

          // Nome do curso
          Text(
            course.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.orange, // Cor do título
            ),
          ),
          const SizedBox(height: 10),

          // Barra de progresso
          _buildProgressBar(),
        ],
      ),
    );
  }

  // Função que cria a barra de progresso
  Widget _buildProgressBar() {
    // Cálculo da porcentagem da barra
    final double progress = (completedHours / totalHours).clamp(0.0, 1.0); // Garante que esteja entre 0 e 1

    return Stack(
      children: [
        // Fundo da barra
        Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2), // Fundo suave da barra
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Progresso
        Container(
          width: progress * 130, // A largura da barra é proporcional ao progresso
          height: 10,
          decoration: BoxDecoration(
            color: Colors.orange, // Cor do progresso
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}