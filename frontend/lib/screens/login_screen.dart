import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/auth_service.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.signInWithGoogle();
          },
          child: const Text("Login com Google"),
        ),
      ),
    );
  }
}
