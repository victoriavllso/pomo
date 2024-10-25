// course_white.dart

import 'package:flutter/material.dart';
import 'course.dart';

class CourseWhite extends StatelessWidget {
  final Course course;

  const CourseWhite({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 60),
      padding: const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
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
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
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
          const SizedBox(width: 20),

          // Nome do curso
          Expanded(
            child: Text(
              course.name,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.w400,
                height: 1.2,
                color: Color(0xFFF65B2E),
              ),
            ),
          ),

          Container(
            width: 62,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFF65D31),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                course.priority.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewDisciplineButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const NewDisciplineButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(vertical: 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 40,
                color: Color(0xFFF65D31),
              ),
              SizedBox(width: 10),
              Text(
                'Nova disciplina',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFF65D31),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}