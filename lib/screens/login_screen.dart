import 'package:agencies_app/screens/register_screen.dart';
import 'package:agencies_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _selectedObscure = false;

  void _obscurePassoword() {
    setState(() {
      _selectedObscure = _selectedObscure ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _popScreen() {
      Navigator.of(context).pop();
    }

    void _goToRegisterPage() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const RegisterScreen(),
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
                    const TextFieldWidget(labelText: 'Agency Email'),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      obscureText: _selectedObscure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _obscurePassoword,
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(162, 232, 236, 244),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(156, 158, 158, 158)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        label: const Text(
                          'Password',
                          style: TextStyle(color: Colors.grey),
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
                        onPressed: () {},
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
