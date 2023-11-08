// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:agencies_app/screens/tabs.dart';
import 'package:agencies_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final myToken = prefs.getString('token');
  runApp(
    MyApp2(
      token: myToken,
      prefs: myToken,
    ),
  );
}

class MyApp2 extends StatelessWidget {
  final token;
  final String? prefs;

  const MyApp2({super.key, required this.token, required this.prefs});

  Widget startScreen() {
    Widget activeScreen = const WelcomeScreen();

    if (prefs != null) {
      activeScreen = ((JwtDecoder.isExpired(token))
          ? const WelcomeScreen()
          : TabsBottom(
              token: token,
            ));
    }
    return activeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angencies',
      home: startScreen(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.token,
  });
  final token;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget activeScreen;
  @override
  void initState() {
    super.initState();
    navigateFirstScreen();
  }

  // final token;
  void navigateFirstScreen() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget.token != null) {
      activeScreen = (JwtDecoder.isExpired(widget.token))
          ? const WelcomeScreen()
          : TabsBottom(
              token: widget.token,
            );
    } else {
      activeScreen = const WelcomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angencies',
      home: activeScreen,
    );
  }
}
