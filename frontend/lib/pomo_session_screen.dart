// pomo_session_screen.dart

import 'package:flutter/material.dart';
import 'gradient_background.dart';
import 'dart:async';
import 'course.dart';

class PomoSessionScreen extends StatefulWidget {
  final Course course;

  const PomoSessionScreen({super.key, required this.course});

  @override
  State<PomoSessionScreen> createState() => _PomoSessionScreenState();
}

class _PomoSessionScreenState extends State<PomoSessionScreen> {
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        gradientInverted: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 200, left: 60, right: 60),
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: 550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  TimerCircle(isPaused: isPaused),
                  // Ícone de pausa/play
                  Padding(
                    padding: const EdgeInsets.only(top: 420),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPaused = !isPaused;
                        });
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF66337),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          isPaused ? Icons.play_arrow : Icons.pause,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Cartão com informações do curso
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF66337),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Ícone do curso
                          Text(
                            widget.course.icon,
                            style: const TextStyle(fontSize: 40),
                          ),
                          Text(
                            widget.course.name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'Cera Pro',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerCircle extends StatefulWidget {
  final bool isPaused;

  const TimerCircle({super.key, required this.isPaused});

  @override
  TimerCircleState createState() => TimerCircleState();
}

class TimerCircleState extends State<TimerCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Duration totalDuration = const Duration(minutes: 25);
  Duration breakDuration = const Duration(minutes: 5);
  Duration remainingDuration = const Duration(minutes: 25);
  bool onBreak = false;
  int sessionCount = 0; // Contador de sessões
  final int maxSessions = 4; // Número máximo de sessões

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: totalDuration,
    );

    _controller.addListener(() {
      setState(() {
        remainingDuration = totalDuration * (1 - _controller.value);
      });

      if (_controller.status == AnimationStatus.completed) {
        if (onBreak) {
          // Se o intervalo terminou, incrementar o contador de sessões
          sessionCount++;
          if (sessionCount >= maxSessions) {
            // Retornar à tela anterior
            Navigator.pop(context);
          } else {
            // Reiniciar para uma nova sessão de foco
            _startFocus();
          }
        } else {
          // Se a sessão de foco terminou, iniciar o intervalo
          _startBreak();
        }
      }
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(TimerCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPaused != widget.isPaused) {
      if (widget.isPaused) {
        _controller.stop(canceled: false);
      } else {
        _controller.forward();
      }
    }
  }

  void _startFocus() {
    setState(() {
      onBreak = false;
      totalDuration = const Duration(minutes: 25);
      remainingDuration = totalDuration;
      _controller.duration = totalDuration;
      _controller.reset();
    });
    _controller.forward();
  }

  void _startBreak() {
    setState(() {
      onBreak = true;
      totalDuration = breakDuration;
      remainingDuration = breakDuration;
      _controller.duration = breakDuration;
      _controller.reset();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String minutes =
    duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
    duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CircularProgressIndicator(
            value: 1 - _controller.value,
            strokeWidth: 15,
            valueColor: AlwaysStoppedAnimation<Color>(
              onBreak ? Colors.blue : const Color(0xFFF66337),
            ),
            backgroundColor: const Color(0xFFF66337).withOpacity(0.2),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              onBreak ? 'Intervalo' : 'Foco',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cera Pro',
                color: Color(0xFFF66337),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${sessionCount + 1}/$maxSessions sessões',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Cera Pro',
                color: const Color(0xFFF66337).withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _formatTime(remainingDuration),
              style: const TextStyle(
                fontSize: 50,
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.w400,
                color: Color(0xFFF66337),
              ),
            ),
          ],
        ),
      ],
    );
  }
}