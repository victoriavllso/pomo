import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'name_screen.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleSignIn() {
    // Validação básica
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Mostra um alerta se os campos estiverem vazios
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }
    // Simula um login bem-sucedido e navega para a próxima tela
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        title: 'Coloque **seus dados** para iniciar!',
        backButton: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, top: 400),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.w300,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'Insira seu e-mail',
                    hintStyle: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, width: 2.0), // Linha branca
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, top: 30),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.w300,
                    fontSize: 36,
                    letterSpacing: 4,
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua senha',
                    hintStyle: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, width: 2.0), // Linha branca
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 80, right: 80),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF558AF6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
