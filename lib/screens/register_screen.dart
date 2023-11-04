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
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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

    String? _validateEmail(value, String? label) {
      if (value.isEmpty) {
        return 'Please enter an $label';
      }
      RegExp emailRegx = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$');
      if (!emailRegx.hasMatch(value)) {
        return 'Please enter a valid $label';
      }
      return null;
    }

    String? _validatePhoneNo(value, String? label) {
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

    String? _validateTextField(value, String? label) {
      if (value.isEmpty) {
        return 'Please enter a $label';
      }
      return null;
    }

    String? _validatePassword(value, String? label) {
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

    String? _validateConfirmPassword(value, String? label) {
      if (value.isEmpty) {
        return 'Please enter a $label';
      }
      String agPass = agencyPassword.text.toString();
      if (agPass != value.toString()) {
        return 'Password and confirm password did\'t match';
      }

      return null;
    }

    String? _validateName(value, String? label) {
      var no = int.tryParse(value);
      if (no != null) {
        return 'Please enter a valid $label';
      }
      if (value.isEmpty) {
        return 'Please enter a $label';
      }
      return null;
    }

    void _registerUser() async {
      //check validation of texts
      var regBody = {
        "agencyName": agencyName.text.toString(),
        "agencyPhNo": agencyPhone.text.toString(),
        "agencyEmail": agencyEmail.text.toString(),
        "password": agencyPassword.text.toString(),
        "address": agencyAddress.text.toString(),
        "representativeName": representativeName.text.toString(),
      };

      var response = await http.post(
        Uri.parse(registerurl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(regBody),
      );

      print(response);
    }

    void _submitForm() {
      if (_formkey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Register Successfully')));
        _registerUser();
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          labelText: 'Agency Name',
                          controllerText: agencyName,
                          checkValidation: (value) =>
                              _validateName(value, 'Name'),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        TextFieldWidget(
                          labelText: 'Agency Email',
                          controllerText: agencyEmail,
                          checkValidation: (value) =>
                              _validateEmail(value, 'Email'),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        TextFieldWidget(
                          labelText: 'Agency Ph No',
                          controllerText: agencyPhone,
                          checkValidation: (value) =>
                              _validatePhoneNo(value, 'Phone Number'),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        TextFieldWidget(
                          labelText: 'Agency Address',
                          controllerText: agencyAddress,
                          checkValidation: (value) =>
                              _validateTextField(value, 'Address'),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        TextFieldWidget(
                          labelText: 'Representative Name',
                          controllerText: representativeName,
                          checkValidation: (value) =>
                              _validateName(value, 'Representative name'),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        TextFieldWidget(
                          labelText: 'Password',
                          controllerText: agencyPassword,
                          checkValidation: (value) =>
                              _validatePassword(value, 'Password'),
                          hideText: true,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        TextFieldWidget(
                          labelText: 'Confirm Password',
                          controllerText: agencyConfirmPassword,
                          checkValidation: (value) => _validateConfirmPassword(
                              value, 'Confirm Password'),
                          hideText: true,
                        ),
                      ],
                    ),
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
                  onPressed: _submitForm,
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
