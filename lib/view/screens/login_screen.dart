// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:agencies_app/helper/constants/sizes.dart';
import 'package:agencies_app/view_model/functions/validate_textfield.dart';
import 'package:agencies_app/view/screens/tabs.dart';
import 'package:agencies_app/widget/dialogs/custom_show_dialog.dart';
import 'package:agencies_app/view/screens/register_screen.dart';
import 'package:agencies_app/view/animations/transitions_animations/page_transition_animation.dart';
import 'package:agencies_app/widget/textfields/login_register_textformfield.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController agencyLoginEmail = TextEditingController();
  TextEditingController agencyPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool buttonPressed = false;
  Widget activeButtonWidget = const Text('Login');
  bool buttonEnabled = true;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  @override
  void dispose() {
    super.dispose();
    agencyLoginEmail.dispose();
    agencyPassword.dispose();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _goToRegisterPage() {
    Navigator.of(context).pushReplacement(
      SlideTransitionAnimation(
        direction: AxisDirection.up,
        child: const RegisterScreen(),
      ),
    );
  }

  void _navigateToHomeScreen(final myToken) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => TabsBottom(myToken: myToken),
      ),
    );
  }

  void _submitButton() {
    if (_formKey.currentState!.validate()) {
      if (!buttonPressed) {
        buttonPressed = true;
        _loginUser();
      }
    }
  }

  void _loginUser() async {
    setState(() {
      buttonEnabled = false;
      activeButtonWidget = const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        ),
      );
    });

    var reqBody = {
      "username": agencyLoginEmail.text,
      "password": agencyPassword.text,
    };

    String serverMessage;

    var baseUrl = dotenv.get("BASE_URL");

    try {
      var response = await http.post(
        Uri.parse('$baseUrl/api/agency/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      // print(response.statusCode);
      // var jsonResponse = jsonDecode(response.body);
      var jsonResponse = jsonDecode(response.body);
      serverMessage = jsonResponse['message'];

      if (response.statusCode == 200) {
        //storin user login data in local variable
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);

        // Navigator.of(context).pop();
        _navigateToHomeScreen(myToken);
        //success
      } else {
        // something went wrong
        setState(() {
          activeButtonWidget = const Text('Login');
        });

        buttonPressed = await customShowDialog(
          context: context,
          titleText: 'Ooops!',
          contentText: serverMessage.toString(),
        );
      }
    } catch (error) {
      debugPrint("Error occured while logging in: ${error.toString()}");
    }

    setState(() {
      buttonEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool kIsMobile = (screenWidth <= mobileScreenWidth);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset('assets/images/disasterImage2.jpg'),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'Life Guardian',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        shadows: const [
                          Shadow(
                            offset: Offset(0.0, 7.0),
                            blurRadius: 15.0,
                            color: Color.fromARGB(57, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'For Agencies',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        shadows: const [
                          Shadow(
                            offset: Offset(0.0, 7.0),
                            blurRadius: 15.0,
                            color: Color.fromARGB(57, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'Welcome back! Glad to see you, team!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 700),
                    child: SizedBox(
                      width: !kIsMobile ? screenWidth / 2 : null,
                      child: LoginRegisterTextFormField(
                        labelText: 'Email / Phone',
                        controllerText: agencyLoginEmail,
                        checkValidation: (value) =>
                            validateTextField(value, 'Email / Phone'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 700),
                    child: SizedBox(
                      width: !kIsMobile ? screenWidth / 2 : null,
                      child: LoginRegisterTextFormField(
                        labelText: 'Password',
                        controllerText: agencyPassword,
                        checkValidation: (value) =>
                            validateTextField(value, 'Password'),
                        obsecureIcon: true,
                        hideText: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: SizedBox(
                      width: !kIsMobile ? screenWidth / 4 : double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: buttonEnabled ? _submitButton : () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: activeButtonWidget,
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: _goToRegisterPage,
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
