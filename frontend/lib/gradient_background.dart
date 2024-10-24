import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'utils.dart';

class GradientBackground extends StatelessWidget {
  final bool gradientInverted;
  final String? title;
  final bool backButton;
  final String? step; // colocar no formato "1/4" = step 1 de 4
  final Widget? child;

  const GradientBackground({
    super.key,
    this.gradientInverted = false,
    this.title,
    this.backButton = true,
    this.step,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientInverted
                  ? [
                      const Color(0xFFFF9A7D),
                      const Color(0xFFFF6B3C)
                    ] // Invertido
                  : [const Color(0xFFF55A2D), const Color(0xFFFFDABF)],
              // Normal
              begin:
                  gradientInverted ? Alignment.bottomLeft : Alignment.topRight,
              end: gradientInverted ? Alignment.topRight : Alignment.bottomLeft,
            ),
          ),
        ),
        Positioned(
          top: 120,
          left: 34,
          child: SvgPicture.asset(
            'assets/images/tomato.svg',
            width: 1000,
            height: 1000,
            fit: BoxFit.cover,
          ),
        ),

        if (backButton)
          Positioned(
              top: 60,
              left: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/images/back_button.svg',
                    width: 50),
              )),

        if (title != null)
          formattedText(
            text: title!,
            fontSize: 42,
            top: 200,
            horizontalMargin: 60,
          ),

        if (child != null) child!, // Renderiza o widget filho se houver
      ],
    ));
  }
}
