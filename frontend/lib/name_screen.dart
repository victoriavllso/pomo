import 'package:flutter/material.dart';
import 'gradient_background.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GradientBackground(
        gradientInverted: false,
        title: 'Como podemos\n**te chamar?**',
      ),
    );
  }
}