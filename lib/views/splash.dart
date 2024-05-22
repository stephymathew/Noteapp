import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_note_app/controller/auth_services.dart';
import 'package:my_note_app/views/SignUp.dart';
import 'package:my_note_app/views/home.dart';
import 'package:my_note_app/views/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.islogin});
  final bool islogin;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
    if (widget.islogin) {
      AuthServices.getuid();
    }

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                widget.islogin ? HomeScreen() : WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 182, 141, 192),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: 800,
                height: 800,
                child: Image.asset(
                  "assets/image/Untitled design.png",
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
