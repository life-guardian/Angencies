// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:agencies_app/helper/constants/sizes.dart';
import 'package:agencies_app/helper/functions/validate_textfield.dart';
import 'package:agencies_app/view/screens/tabs.dart';
import 'package:agencies_app/widget/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:agencies_app/widget/dialogs/custom_show_dialog.dart';
import 'package:agencies_app/view/screens/register_screen.dart';
import 'package:agencies_app/view/animations/transitions_animations/page_transition_animation.dart';
import 'package:agencies_app/widget/textfields/login_register_textformfield.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      activeButtonWidget = const CustomCircularProgressIndicator();
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size_5.w),
          child: Column(
            children: [
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Image(
                  image: const AssetImage('assets/images/disasterImage2.jpg'),
                  height: 80.sp,
                ),
              ),
              SizedBox(
                height: size_6.h,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Life Guardian',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: size_8.sp,
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
                    fontSize: size_11.sp,
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
              SizedBox(
                height: size_16.h,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Welcome back! Glad to see you, team!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: size_11.sp,
                  ),
                ),
              ),
              SizedBox(
                height: size_16.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 700),
                      child: SizedBox(
                        width: !kIsMobile ? screenWidth / 2 : null,
                        height: 70.h,
                        child: LoginRegisterTextFormField(
                          labelText: 'Email / Phone',
                          controllerText: agencyLoginEmail,
                          checkValidation: (value) =>
                              validateTextField(value, 'Email / Phone'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size_3.h,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 700),
                      child: SizedBox(
                        width: !kIsMobile ? screenWidth / 2 : null,
                        height: 70.h,
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
                  ],
                ),
              ),
              SizedBox(
                height: size_20.h,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: SizedBox(
                  width: !kIsMobile ? screenWidth / 4 : double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: buttonEnabled ? _submitButton : () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: activeButtonWidget,
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    TextButton(
                      onPressed: _goToRegisterPage,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.sp,
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
