import 'dart:async';
import 'package:agencies_app/screens/home_screen.dart';
import 'package:agencies_app/transitions_animations/custom_fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterSuccessfullScreen extends StatefulWidget {
  const RegisterSuccessfullScreen({super.key});

  @override
  State<RegisterSuccessfullScreen> createState() =>
      _RegisterSuccessfullScreenState();
}

class _RegisterSuccessfullScreenState extends State<RegisterSuccessfullScreen> {
  Timer? _timer;

  @override
  initState() {
    super.initState();

    // Create a Timer object and pass in a callback function that will be
    // executed after the timer expires.
    _timer = Timer(
      const Duration(seconds: 3),
      () {
        // Push the navigator to the next screen.
        Navigator.of(context).pushReplacement(
          CustomFadeTransition(
            child: const HomeScreen(),
            durationMiliseconds: 1500,
          ),
        );
      },
    );
  }

  @override
  dispose() {
    // Cancel the timer if it is still running.
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/Successmark.png'),
              const SizedBox(
                height: 21,
              ),
              Text(
                'Registration Done!',
                style: GoogleFonts.urbanist().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              const Text(
                'Your Agency has been registered successfully.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
