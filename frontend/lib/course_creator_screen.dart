// course_creator_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'user_model.dart';
import 'course.dart';
import 'gradient_background.dart';

class CourseCreatorScreen extends StatefulWidget {
  const CourseCreatorScreen({super.key});

  @override
  _CourseCreatorScreenState createState() => _CourseCreatorScreenState();
}

class _CourseCreatorScreenState extends State<CourseCreatorScreen> {
  final TextEditingController _iconController =
      TextEditingController(text: '😃');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priorityController =
      TextEditingController(text: '5');

  void _handleCreate() {
    if (_nameController.text.isEmpty ||
        _iconController.text.isEmpty ||
        _priorityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    int priority = int.tryParse(_priorityController.text) ?? 1;

    Course newCourse = Course(
      name: _nameController.text,
      id: DateTime.now().millisecondsSinceEpoch,
      icon: _iconController.text,
      priority: priority,
    );

    Provider.of<UserModel>(context, listen: false).addCourse(newCourse);

    Navigator.pop(context); // Retorna para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        title: 'Nova **disciplina**',
        titleSize: 42,
        step: 1,
        totalSteps: 4,
        buttonName: "Criar",
        buttonAction: _handleCreate,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 280,
            left: 60,
            right: 60,
            bottom: 240,
          ),
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
                        controller: _iconController,
                        style: const TextStyle(fontSize: 50),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          // Open the emoji keyboard
                          SystemChannels.textInput
                              .invokeMethod('TextInput.show');
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _nameController,
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
                          borderSide:
                              BorderSide(color: Color(0xFFF66337), width: 2.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF66337), width: 2.0),
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
                              controller: _priorityController,
                              keyboardType: TextInputType.number,
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
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
          ),
        ),
      ),
    );
  }
}
