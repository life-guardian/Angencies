import 'package:agencies_app/screens/load_home_screen.dart';
import 'package:agencies_app/screens/login_screen.dart';
import 'package:agencies_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
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

    void _registeredSuccessfully() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const LoadHomeScreen(),
        ),
      );
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
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFieldWidget(labelText: 'Agency Name'),
                      SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(labelText: 'Agency Email'),
                      SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(labelText: 'Agency Ph No'),
                      SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(labelText: 'Agency Address'),
                      SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(labelText: 'Representative Name'),
                      SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(labelText: 'Password'),
                      SizedBox(
                        height: 21,
                      ),
                      TextFieldWidget(labelText: 'Confirm Password'),
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
                  onPressed: _registeredSuccessfully,
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
