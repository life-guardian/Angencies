// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:agencies_app/screens/home_screen.dart';
import 'package:agencies_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(
      token: prefs.getString('token'),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token});
  final token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angencies',
      home: (JwtDecoder.isExpired(token))
          ? const WelcomeScreen()
          : HomeScreen(token: token),
    );
  }
}
