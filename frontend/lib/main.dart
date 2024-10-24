import 'package:flutter/material.dart';
import 'name_screen.dart';

void main() {
  runApp(const PomoApp());
}

class PomoApp extends StatelessWidget {
  const PomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const NameScreen();
  }
}
