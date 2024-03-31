import 'dart:convert';

import 'package:note_taking_app/presentation/pages/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkFirstVisit();
  }

  Future<void> checkFirstVisit() async {

    Future.delayed(
      const Duration(seconds: 3),
      () {
        // If first visit, navigate to OnBoardingScreen()
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white70),
        child: Center(
          child: Container(
            width: 450,
            height: 200,
            margin: const EdgeInsets.only(bottom: 50),
            child: Image.asset('assets/images/Frame 1.png'),
          ),
        ),
      ),
    );
  }
}
