import 'dart:convert';
import 'package:agencies_app/backend_url/config.dart';
import 'package:agencies_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:agencies_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController agencyName = TextEditingController();
    TextEditingController agencyEmail = TextEditingController();
    TextEditingController agencyPhone = TextEditingController();
    TextEditingController agencyAddress = TextEditingController();
    TextEditingController representativeName = TextEditingController();
    TextEditingController agencyPassword = TextEditingController();
    TextEditingController agencyConfirmPassword = TextEditingController();

    void _popScreen() {
      Navigator.of(context).pop();
    }

    void _goToLoginPage() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );
    }

    void _registerUser() async {
      //check validation of texts
      var regBody = {
        "agencyName": agencyName.text.toString(),
        "agencyPhNo": agencyPhone.text.toString(),
        "agencyEmail": agencyEmail.text.toString(),
        "password": agencyPassword.text.toString(),
        "address": agencyPassword.text.toString(),
        "representativeName": representativeName.text.toString(),
      };

      var response = await http.post(
        Uri.parse(registerurl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(regBody),
      );

      print(response);
    }

    return Scaffold(
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
            onPressed: _popScreen,
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          child: Column(
            children: [
              const Text(
                'Hello! Register agency to get started',
                style: TextStyle(
                  color: Color(0xff1E232C),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFieldWidget(
                          labelText: 'Agency Name',
                          dynamicControllerText: agencyName),
                      const SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(
                        labelText: 'Agency Email',
                        dynamicControllerText: agencyEmail,
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(
                        labelText: 'Agency Ph No',
                        dynamicControllerText: agencyPhone,
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(
                        labelText: 'Agency Address',
                        dynamicControllerText: agencyAddress,
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(
                        labelText: 'Representative Name',
                        dynamicControllerText: representativeName,
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(
                          labelText: 'Password',
                          dynamicControllerText: agencyPassword),
                      const SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(
                          labelText: 'Confirm Password',
                          dynamicControllerText: agencyConfirmPassword),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xff1E232C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Register'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: _goToLoginPage,
                      child: const Text(
                        'Login Now',
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
