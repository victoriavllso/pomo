// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_model.dart';
import 'login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: const PomoApp(),
    ),
  );
}

class PomoApp extends StatelessWidget {
  const PomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PomoApp',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}