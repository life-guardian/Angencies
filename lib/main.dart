// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:agencies_app/view/screens/splash_screen.dart';
import 'package:agencies_app/view/screens/tabs.dart';
import 'package:agencies_app/view/screens/welcome_screen.dart';
import 'package:agencies_app/view/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? myToken = prefs.getString('token');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ProviderScope(
        child: MyApp(
          token: myToken,
        ),
      ),
    );
  });
}

Future initialization(BuildContext? context) async {
  await Future.delayed(
    const Duration(seconds: 3),
  );
}

class MyApp extends StatefulWidget {
  final String? token;

  const MyApp({super.key, this.token});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget activeWidget;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      activeWidget = const SplashScreen();
      assignAppScreen();
    } else {
      activeWidget = const WelcomeScreen();
    }
  }

  Widget assignAppScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        activeWidget = TabsBottom(
          myToken: widget.token,
        );
        setState(() {});
      },
    );

    return activeWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Angencies',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: activeWidget,
      ),
    );
  }
}
