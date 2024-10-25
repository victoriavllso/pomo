import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_model.dart';
import 'icon_screen.dart';
import 'gradient_background.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();

    void _handleContinue() {
      if (_nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira seu nome')),
        );
        return;
      }
      // Atualiza o nome no UserModel
      Provider.of<UserModel>(context, listen: false)
          .setName(_nameController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IconScreen()),
      );
    }

    return Scaffold(
      body: GradientBackground(
        gradientInverted: true,
        title: 'Como podemos **te chamar?**',
        titleSize: 42,
        step: 1,
        totalSteps: 4,
        buttonName: "Continuar",
        buttonAction: _handleContinue,
        child: Padding(
          padding: const EdgeInsets.only(left: 60, right: 60, top: 450),
          child: TextField(
            controller: _nameController,
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
                borderSide:
                    BorderSide(color: Colors.white, width: 2.0), // Linha branca
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
