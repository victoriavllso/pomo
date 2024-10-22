import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'authentication/auth_service.dart'; // Serviço de autenticação
import 'authentication/auth_wraper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const PomoApp());
}

class PomoApp extends StatelessWidget {
  const PomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(), // Provider de autenticação
      child: MaterialApp(
        home: AuthWrapper(), // Verifica se o usuário está logado
      ),
    );
  }
}