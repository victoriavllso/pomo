import 'package:flutter/material.dart';
import 'course.dart';

class CourseSquare extends StatelessWidget {
  final Course course;
  final double completedHours; // Horas completadas
  final double totalHours; // Total de horas a serem completadas
  final VoidCallback? onPressed;
  final int? colored; // Pode ser nulo

  const CourseSquare({
    super.key,
    required this.course,
    required this.completedHours,
    required this.totalHours,
    this.onPressed,
    this.colored,
  });

  @override
  Widget build(BuildContext context) {
    // cria um quadrado 150x150
    return GestureDetector(
      onTap: onPressed,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: 200,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícone do curso
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _getIconBackgroundColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      course.icon,
                      style: TextStyle(
                        fontSize: 30,
                        color: _getIconTextColor(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nome do curso
                Text(
                  course.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: _getTextColor(),
                  ),
                ),
                const SizedBox(height: 10),
                // Barra de progresso
                _buildProgressBar(),
                const SizedBox(height: 8),
                // Texto com as horas completadas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${completedHours.toStringAsFixed(0)}h',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.w300,
                        color: _getTextColor(),
                      ),
                    ),
                    Text(
                      '${totalHours.toStringAsFixed(0)}h',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.w300,
                        color: _getTextColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função que cria a barra de progresso
  Widget _buildProgressBar() {
    // Cálculo da porcentagem da barra
    final double progress = (completedHours / totalHours).clamp(0.0, 1.0);

    return Stack(
      children: [
        // Fundo da barra
        Container(
          width: double.infinity,
          height: 7,
          decoration: BoxDecoration(
            color: _getProgressBarBackgroundColor(),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Progresso
        Container(
          width: progress * 130,
          height: 7,
          decoration: BoxDecoration(
            color: _getProgressBarColor(),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // Métodos auxiliares para obter as cores

  Color _getBackgroundColor() {
    if (colored == null) {
      return Colors.white;
    } else {
      // Interpolar entre as cores F55A2D e FBA783
      int maxColored = 10; // Valor máximo para 'colored'
      double t = (colored! / maxColored).clamp(0.0, 1.0);
      return Color.lerp(const Color(0xFFF55A2D), const Color(0xFFFBA783), t)!;
    }
  }

  Color _getTextColor() {
    return colored == null ? const Color(0xFFF65B2E) : Colors.white;
  }

  Color _getIconBackgroundColor() {
    return colored == null
        ? const Color(0xFFF65B2E)
        : Colors.white.withOpacity(0.2);
  }

  Color _getIconTextColor() {
    return Colors.white;
  }

  Color _getProgressBarBackgroundColor() {
    return colored == null
        ? const Color(0xFFF66337).withOpacity(0.15)
        : Colors.white.withOpacity(0.3);
  }

  Color _getProgressBarColor() {
    return colored == null ? const Color(0xFFF66337) : Colors.white;
  }
}

class NewDisciplineButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const NewDisciplineButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ElevatedButton(
        onPressed: () {
          // Ação para o botão
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Color(0xFFF65D31),
        ),
      ),
    );
  }
}
