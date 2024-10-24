import 'package:flutter/material.dart';

// Função que formata o texto (se tiver dentro de **, fica em negrito)
Widget formattedText({
  required String text,
  required double fontSize,
  required double top,
  required double horizontalMargin,
}) {

  List<TextSpan> processText(String text) {
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
              fontWeight: FontWeight.normal, // Regular
              fontSize: fontSize,
              fontFamily: 'Cera Pro',
            ),
          ),
        );
      }
    }

    return spans;
  }

  return Positioned(
    top: top,
    left: horizontalMargin,
    right: horizontalMargin,
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
