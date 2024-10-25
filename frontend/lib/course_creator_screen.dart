import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gradient_background.dart';

class CourseCreatorScreen extends StatelessWidget {
  const CourseCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GradientBackground(
        title: 'Nova **disciplina**',
        titleSize: 42,
        step: 1,
        totalSteps: 4,
        buttonName: "Criar",
        child: Padding(
          padding: const EdgeInsets.only(
              top: 280, left: 60, right: 60, bottom: 240),
          child: Stack(
            children: [
            Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Column(
              children: [
              const SizedBox(height: 40),
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFF65B2E),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: TextField(
                textAlign: TextAlign.center,
                controller: TextEditingController(text: '😃'),
                style: const TextStyle(fontSize: 50),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onTap: () {
                  // Open the emoji keyboard
                  SystemChannels.textInput.invokeMethod('TextInput.show');
                },
                inputFormatters: [LengthLimitingTextInputFormatter(1)],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 40, vertical: 20),
          child: TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: 'Matemática'),
            style: const TextStyle(
              fontFamily: 'Cera Pro',
              fontWeight: FontWeight.w300,
              fontSize: 30,
              color: Color(0xFFF66337),
            ),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: 'Disciplina',
              hintStyle: TextStyle(
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Color(0xFFF66337),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFF66337), width: 2.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFF66337), width: 2.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 60, vertical: 20),
          child: Row(
            children: [
              Container(
                width: 62,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFF65D31),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: TextEditingController(text: '5'),
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Cera Pro',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              const Text(
                'Prioridade',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFF65B2E),
                ),
              ),
            ],
          ),
        )
        ],
      ),
      ],
    ),)
    )
    ,
    );
  }
}
