// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:agencies_app/screens/tabs.dart';
import 'package:agencies_app/screens/welcome_screen.dart';
import 'package:agencies_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final myToken = prefs.getString('token');
  await dotenv.load(fileName: ".env");

  runApp(
    ProviderScope(
      child: MyApp(
        token: myToken,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final token;

  const MyApp({super.key, required this.token});

  Widget activeScreen() {
    Widget activeWidget = const WelcomeScreen();

    if (token != null) {
      activeWidget = (token == ''
          ? const WelcomeScreen()
          : TabsBottom(
              myToken: token,
            ));
    }
    return activeWidget;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angencies',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: activeScreen(),
    );
  }
}
