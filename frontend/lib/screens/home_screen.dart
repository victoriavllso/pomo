import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-vindo, ${user?.displayName}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text("Usuário logado: ${user?.email}"),
      ),
    );
  }
}
