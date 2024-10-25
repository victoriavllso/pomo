import 'package:flutter/material.dart';
import 'course.dart';

class CourseSquare extends StatelessWidget {
  final Course course;
  final double completedHours; // Horas completadas
  final double totalHours; // Total de horas a serem completadas
  final VoidCallback? onPressed;

  const CourseSquare({
    super.key,
    required this.course,
    required this.completedHours,
    required this.totalHours,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // cria um quadrado 150x150
    return GestureDetector(
      // print when tapped
      onTap: onPressed,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: 200,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFF65B2E),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      course.icon,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nome do curso
                Text(
                  course.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: Color(0xFFF65B2E),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFF65B2E),
                      ),
                    ),
                    Text(
                      '${totalHours.toStringAsFixed(0)}h',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFF65B2E),
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
    final double progress = (completedHours / totalHours)
        .clamp(0.0, 1.0); // Garante que esteja entre 0 e 1

    return Stack(
      children: [
        // Fundo da barra
        Container(
          width: double.infinity,
          height: 7,
          decoration: BoxDecoration(
            color: const Color(0xFFF66337).withOpacity(0.15),
            // Fundo suave da barra
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Progresso
        Container(
          width: progress * 130,
          // A largura da barra é proporcional ao progresso
          height: 7,
          decoration: BoxDecoration(
            color: const Color(0xFFF66337), // Cor do progresso
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
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
