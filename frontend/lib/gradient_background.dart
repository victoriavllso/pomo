import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'utils.dart';

class GradientBackground extends StatelessWidget {
  final bool gradientInverted;
  final String? title;
  final double titleSize;
  final String? subTitle;
  final bool backButton;
  final int? step;
  final int? totalSteps;
  final String? buttonName;
  final void Function()? buttonAction;
  final Widget? child;

  const GradientBackground({
    super.key,
    this.gradientInverted = false,
    this.title,
    this.titleSize = 36,
    this.subTitle,
    this.backButton = true,
    this.step,
    this.totalSteps,
    this.buttonName,
    this.buttonAction,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double topPaddingTitle = subTitle != null ? 150 : 200;

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

        // renderizando a barra de progresso
        if (step != null && totalSteps != null)
          (renderProgressBar(totalSteps: totalSteps!, currentStep: step!)),

        // renderizando o titulo da pagina

        if (title != null)
          Column(
            children: [
              formattedText(
                text: title!,
                fontSize: titleSize,
                top: topPaddingTitle,
                horizontalMargin: 60,
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60, top: 10),
                  child: (Text(
                    subTitle!,
                    style: const TextStyle(
                      fontFamily: 'Cera Pro',
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  )),
                ),
            ],
          ),

        if (buttonName != null)
          Padding(
            padding: const EdgeInsets.only(top: 600),
            child: Center(
              child: ElevatedButton(
                onPressed: buttonAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3C00),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                child: Text(
                  buttonName!,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

        if (child != null) child!, // Renderiza o widget filho se houver
      ],
    ));
  }
}
