import 'package:flutter/material.dart';
import 'gradient_background.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GradientBackground(
        gradientInverted: true,
        title: 'Como podemos **te chamar?**',
        titleSize: 42,
        step: 1,
        totalSteps: 4,
        buttonName: "Continuar",

        child: Padding(
          padding: const EdgeInsets.only(left: 60, right: 60, top: 450),
          child: TextField(
            controller: TextEditingController(text: 'Pedro Gimenez'),
            style: const TextStyle(
              fontFamily: 'Cera Pro',
              fontWeight: FontWeight.w300,
              fontSize: 40,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Digite seu nome',
              hintStyle: TextStyle(
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.w300,
                fontSize: 40,
                color: Colors.white,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0), // Linha branca
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}