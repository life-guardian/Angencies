import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterSuccessfullWidget extends StatelessWidget {
  const RegisterSuccessfullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
