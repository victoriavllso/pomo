import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Função que formata o texto (se tiver dentro de **, fica em negrito)
Widget formattedText({
  required String text,
  required double fontSize,
  required double top,
  required double horizontalMargin,
  bool thin = false,
}) {
  List<TextSpan> processText(String text) {

    FontWeight fontWeight = thin ? FontWeight.w300 : FontWeight.normal;
    final spans = <TextSpan>[];
    final parts = text.split('**');

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 1) {
        spans.add(
          TextSpan(
            text: parts[i],
            style: TextStyle(
                fontWeight: FontWeight.bold, // Negrito
                fontSize: fontSize,
                fontFamily: 'Cera Pro'),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: parts[i],
            style: TextStyle(
              fontWeight: fontWeight, // Regular
              fontSize: fontSize,
              fontFamily: 'Cera Pro',
            ),
          ),
        );
      }
    }

    return spans;
  }

  return Padding(
    padding: EdgeInsets.only(
      top: top, // Margem superior
      left: horizontalMargin, // Margem lateral esquerda
      right: horizontalMargin, // Margem lateral direita
    ),
    child: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        children: processText(text),
        style: const TextStyle(
          height: 1.2,
          fontFamily: 'Cera Pro',
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget renderProgressBar({
  required int totalSteps,
  required int currentStep,

  // posicoes de inicio e fim da barra de progresso
  double start = 91,
  double end = 330,
  double? position,
}) {

  // Calcula a posicao da barra de progresso
  currentStep -= 1;
  totalSteps -= 1;
  position = start + (end - start) * (currentStep / totalSteps);

  return Stack(
    children: [
      Positioned(
        top: 80,
        left: 65,
        height: 9,
        child: SvgPicture.asset('assets/images/load_bar_full.svg'),
      ),
      Positioned(
        top: 72,
        left: position,
        height: 25,

        child: SvgPicture.asset('assets/images/load_bar_part.svg'),
      ),
    ],
  );
}
