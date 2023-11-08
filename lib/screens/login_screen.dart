// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:agencies_app/screens/tabs.dart';
import 'package:agencies_app/small_widgets/custom_show_dialog.dart';
import 'package:agencies_app/backend_url/config.dart';
import 'package:agencies_app/screens/home_screen.dart';
import 'package:agencies_app/screens/register_screen.dart';
import 'package:agencies_app/transitions_animations/custom_page_transition.dart';
import 'package:agencies_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
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

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? _validateTextField(value, String? label) {
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    return null;
  }

  void _goToRegisterPage() {
    Navigator.of(context).pushReplacement(
      CustomSlideTransition(
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
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );

    var reqBody = {
      "username": agencyLoginEmail.text,
      "password": agencyPassword.text,
    };

    var response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    // print(response.statusCode);
    // var jsonResponse = jsonDecode(response.body);
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //storin user login data in local variable
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);

      // Navigator.of(context).pop();
      _navigateToHomeScreen(myToken);
      //success
      print('login successful');
    } else if (response.statusCode == 404) {
      // wrong username

      buttonPressed = await customShowDialog(
        context: context,
        titleText: 'Cant\' find account',
        contentText:
            'We can\'t find a account with ${agencyLoginEmail.text.toString()}. try another phone number or email address, or if you dont\' have an account, you can sign up.',
      );
      buttonPressed = false;
      Navigator.of(context).pop();
    } else if (response.statusCode == 403) {
      // password or username not found
      buttonPressed = await customShowDialog(
        context: context,
        titleText: 'username or password didn\' match',
        contentText:
            'The password or username that you have entered is incorrect. please try again.',
      );
      buttonPressed = false;
      Navigator.of(context).pop();
    } else if (response.statusCode == 400) {
      // wrong  password
      buttonPressed = await customShowDialog(
        context: context,
        titleText: 'Incorrect password',
        contentText:
            'The password that you have entered is incorrect. please try again.',
      );
      buttonPressed = false;
      Navigator.of(context).pop();
    } else {
      // something went wrong
      buttonPressed = await customShowDialog(
        context: context,
        titleText: 'Server Error',
        contentText: 'Something went wrong! please try again later.',
      );
      buttonPressed = false;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              foregroundColor: const Color.fromARGB(185, 30, 35, 44),
              side: const BorderSide(
                color: Color.fromARGB(32, 30, 35, 44),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/disasterImage2.jpg'),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Life Guardian',
                style: TextStyle(
                  color: Color(0xff1E232C),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 7.0),
                      blurRadius: 15.0,
                      color: Color.fromARGB(57, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const Text(
                'For Agencies',
                style: TextStyle(
                  color: Color(0xff1E232C),
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 7.0),
                      blurRadius: 15.0,
                      color: Color.fromARGB(57, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Welcome back! Glad to see you, team!',
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      TextFieldWidget(
                        labelText: 'Email / Phone',
                        controllerText: agencyLoginEmail,
                        checkValidation: (value) =>
                            _validateTextField(value, 'Email / Phone'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldWidget(
                        labelText: 'Password',
                        controllerText: agencyPassword,
                        checkValidation: (value) =>
                            _validateTextField(value, 'Password'),
                        obsecureIcon: true,
                        hideText: true,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _submitButton,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xff1E232C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
