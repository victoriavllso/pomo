import 'package:flutter/material.dart';
import 'authenticator_provider.dart';
import 'package:provider/provider.dart';
import 'gradient_background.dart';
import 'icon_screen.dart';

void main() {
  runApp(const PomoApp());
}

class PomoApp extends StatelessWidget {
  const PomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(baseUrl: 'https://127.0.0.1'),
      child: const MaterialApp(
        home: GradientBackground(
        gradientInverted: true,
        backButton: false,
        child: IconScreen()),
      ),
    );
  }
}
