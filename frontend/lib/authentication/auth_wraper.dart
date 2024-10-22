import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'package:pomo/screens/home_screen.dart';
import 'package:pomo/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    if (authService.user == null) {
      return LoginScreen(); // Tela de login
    } else {
      return HomeScreen(); // Tela principal após o login
    }
  }
}