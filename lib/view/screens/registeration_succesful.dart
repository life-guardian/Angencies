// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:agencies_app/view/screens/tabs.dart';
import 'package:agencies_app/view/animations/transitions_animations/fade_transition_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterationSuccessfullScreen extends StatefulWidget {
  const RegisterationSuccessfullScreen({
    super.key,
    required this.token,
  });

  final token;

  @override
  State<RegisterationSuccessfullScreen> createState() =>
      _RegisterationSuccessfullScreenState();
}

class _RegisterationSuccessfullScreenState
    extends State<RegisterationSuccessfullScreen> {
  Timer? _timer;

  @override
  initState() {
    super.initState();

    // Create a Timer object and pass in a callback function that will be
    // executed after the timer expires.
    _timer = Timer(
      const Duration(seconds: 3),
      () {
        // Push the navigator to the login screen.
        Navigator.of(context).pushReplacement(
          FadeTransitionAnimation(
            child: TabsBottom(myToken: widget.token),
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
