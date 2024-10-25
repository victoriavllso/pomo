import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'package:flutter_svg/svg.dart';
import 'utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GradientBackground(
          gradientInverted: true,
          backButton: false,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                children: [
                  SizedBox(height: 200),
                  SvgPicture.asset('assets/images/logo.svg'),
                  formattedText(
                    text: 'você está a um passo do seu **eu mais organizado.**',
                    fontSize: 25,
                    top: 10,
                    horizontalMargin: 0,
                    thin: true,
                  ),
                  const SizedBox(height: 80),

                  ElevatedButton(
                    onPressed: () {
                      // Ação para o botão
                    },
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.white60,
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.5),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/google.svg',
                            width: 40),
                        const SizedBox(width: 15),
                        const Text(
                          'Continue com Google',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Cera Pro',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF3C3C3C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
