import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'courses_screen.dart';
import 'package:provider/provider.dart';
import 'user_model.dart';

class StudyHoursScreen extends StatefulWidget {
  const StudyHoursScreen({super.key});

  @override
  StudyHoursScreenState createState() => StudyHoursScreenState();
}

class StudyHoursScreenState extends State<StudyHoursScreen> {
  int _selectedValue = 0;

  void _handleContinue() {
    Provider.of<UserModel>(context, listen: false)
        .setStudyHours(_selectedValue + 1);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CoursesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        title: "Quantas **horas** você **quer estudar** por dia?",
        step: 3,
        totalSteps: 4,
        buttonName: "Continuar",
        buttonAction: _handleContinue,
        child: StudyHoursContent(
          onValueChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}

class StudyHoursContent extends StatefulWidget {
  final Function(int) onValueChanged;

  const StudyHoursContent({super.key, required this.onValueChanged});

  @override
  StudyHoursContentState createState() => StudyHoursContentState();
}

class StudyHoursContentState extends State<StudyHoursContent> {
  int _selectedValue = 0;
  final List<int> _hours = [for (int i = 1; i <= 18; i++) i];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          SizedBox(
            height: 300, // Altura do dial de numerous
            child: ListWheelScrollView.useDelegate(
              itemExtent: 60,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedValue = index;
                });
              },
              perspective: 0.005,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 1.2,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final isSelected = _selectedValue == index;
                  final scale = isSelected ? 2.4 : 1.0;
                  final opacity = isSelected ? 1.0 : 0.3;

                  return Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: Text(
                        _hours[index].toString(),
                        style: const TextStyle(
                          fontFamily: 'Cera Pro',
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                childCount: _hours.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
