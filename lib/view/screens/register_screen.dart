// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:agencies_app/helper/constants/sizes.dart';
import 'package:agencies_app/view/screens/login_screen.dart';
import 'package:agencies_app/view/screens/registeration_succesful.dart';
import 'package:agencies_app/widget/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:agencies_app/widget/dialogs/custom_show_dialog.dart';
import 'package:agencies_app/view/animations/transitions_animations/page_transition_animation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:agencies_app/widget/textfields/login_register_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  TextEditingController agencyName = TextEditingController();
  TextEditingController agencyEmail = TextEditingController();
  TextEditingController agencyPhone = TextEditingController();
  TextEditingController agencyAddress = TextEditingController();
  TextEditingController representativeName = TextEditingController();
  TextEditingController agencyPassword = TextEditingController();
  TextEditingController agencyConfirmPassword = TextEditingController();
  bool registeredButtonPressed = false;
  bool buttonEnabled = true;
  Widget activeButtonWidget = const Text('Register');

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  @override
  void dispose() {
    super.dispose();
    agencyName.dispose();
    agencyEmail.dispose();
    agencyPhone.dispose();
    agencyAddress.dispose();
    representativeName.dispose();
    agencyPassword.dispose();
    agencyConfirmPassword.dispose();
  }

  void popScreen() {
    Navigator.of(context).pop();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void goToLoginPage() {
    Navigator.of(context).pushReplacement(
      SlideTransitionAnimation(
        direction: AxisDirection.up,
        child: const LoginScreen(),
      ),
    );
  }

  String? validateEmail(value, String? label) {
    if (value.isEmpty) {
      return 'Please enter an $label';
    }
    RegExp emailRegx = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$');
    if (!emailRegx.hasMatch(value)) {
      return 'Please enter a valid $label';
    }
    return null;
  }

  String? validatePhoneNo(value, String? label) {
    var no = int.tryParse(value);
    if (no == null) {
      return 'Please enter a valid $label';
    }
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit $label';
    }
    return null;
  }

  String? validateTextField(value, String? label) {
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    return null;
  }

  String? validatePassword(value, String? label) {
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    if (value.length < 8 || value.length > 16) {
      return 'Please enter $label between 8 to 16 digits';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*$').hasMatch(value)) {
      return 'Password must contains at least one upper case, lower case, number & special symbol';
    }

    return null;
  }

  String? validateConfirmPassword(value, String? label) {
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    String agPass = agencyPassword.text.toString();
    if (agPass != value.toString()) {
      return 'Password and confirm password did\'t match';
    }

    return null;
  }

  String? validateName(value, String? label) {
    var no = int.tryParse(value);
    if (no != null) {
      return 'Please enter a valid $label';
    }
    if (value.isEmpty) {
      return 'Please enter a $label';
    }
    return null;
  }

  void registerUser() async {
    setState(() {
      buttonEnabled = false;
      activeButtonWidget = const CustomCircularProgressIndicator();
    });

    String serverMessage;

    var regBody = {
      "agencyName": agencyName.text.toString(),
      "agencyPhNo": agencyPhone.text.toString(),
      "agencyEmail": agencyEmail.text.toString(),
      "password": agencyPassword.text.toString(),
      "address": agencyAddress.text.toString(),
      "representativeName": representativeName.text.toString(),
    };

    String baseUrl = dotenv.get("BASE_URL");

    var response = await http.post(
      Uri.parse('$baseUrl/api/agency/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(regBody),
    );

    var jsonResponse = jsonDecode(response.body);
    serverMessage = jsonResponse['message'];

    if (response.statusCode == 200) {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      Navigator.of(context).pushReplacement(
        SlideTransitionAnimation(
          direction: AxisDirection.left,
          child: RegisterationSuccessfullScreen(token: myToken),
        ),
      );
    } else {
      setState(() {
        activeButtonWidget = const Text('Register');
      });

      registeredButtonPressed = await customShowDialog(
        context: context,
        titleText: 'Something went wrong!',
        contentText: serverMessage.toString(),
      );
      registeredButtonPressed = false;
    }
    buttonEnabled = true;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      if (!registeredButtonPressed) {
        registeredButtonPressed = true;
        registerUser();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool kIsMobile = (screenWidth <= mobileScreenWidth);

    return Scaffold(
      resizeToAvoidBottomInset: kIsMobile ? true : false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: registerScreenWidget(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        kIsMobile: kIsMobile,
      ),
    );
  }

  Widget registerScreenWidget(
      {required double screenHeight,
      required double screenWidth,
      required bool kIsMobile}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    'Hello! Register agency to get started',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 500),
                  child: registerScreenFormWidget(
                    screenWidth: screenWidth,
                    kIsMobile: kIsMobile,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff35C2C1), // Set shadow color
                  blurRadius: 20.0, // Adjust blur for softness
                  spreadRadius: 2.0, // Adjust based on container size
                  offset: Offset(0.0, 0.5), // Slight offset for depth
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.h, top: 10.h),
              child: Wrap(
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: !kIsMobile
                          ? screenWidth / 4
                          : MediaQuery.of(context).size.width,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: buttonEnabled ? submitForm : () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: activeButtonWidget,
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        TextButton(
                          onPressed: goToLoginPage,
                          child: Text(
                            'Login Now',
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
        ],
      ),
    );
  }

  Widget registerScreenFormWidget(
      {required double screenWidth, required bool kIsMobile}) {
    return SizedBox(
      width: !kIsMobile ? (screenWidth / 2).w : null,
      height: 510.h,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Agency Name',
                controllerText: agencyName,
                checkValidation: (value) => validateName(value, 'Name'),
              ),
              SizedBox(
                height: size_3.h,
              ),
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Agency Email',
                controllerText: agencyEmail,
                checkValidation: (value) => validateEmail(value, 'Email'),
              ),
              SizedBox(
                height: size_3.h,
              ),
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Agency Ph No',
                controllerText: agencyPhone,
                checkValidation: (value) =>
                    validatePhoneNo(value, 'Phone Number'),
              ),
              SizedBox(
                height: size_3.h,
              ),
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Agency Address',
                controllerText: agencyAddress,
                checkValidation: (value) => validateTextField(value, 'Address'),
              ),
              SizedBox(
                height: size_3.h,
              ),
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Representative Name',
                controllerText: representativeName,
                checkValidation: (value) =>
                    validateName(value, 'Representative name'),
              ),
              SizedBox(
                height: size_3.h,
              ),
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Password',
                controllerText: agencyPassword,
                checkValidation: (value) => validatePassword(value, 'Password'),
                hideText: true,
              ),
              SizedBox(
                height: size_3.h,
              ),
              LoginRegisterTextFormField(
                height: 70.h,
                labelText: 'Confirm Password',
                controllerText: agencyConfirmPassword,
                checkValidation: (value) =>
                    validateConfirmPassword(value, 'Confirm Password'),
                hideText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}