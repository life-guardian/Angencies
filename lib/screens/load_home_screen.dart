import 'dart:async';

import 'package:agencies_app/widgets/register_succesful.dart';
import 'package:flutter/material.dart';

class LoadHomeScreen extends StatefulWidget {
  const LoadHomeScreen({super.key});

  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Delay the next page navigation for 3 seconds.
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/next_page');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = RegisterSuccessfullWidget();
    return Scaffold(
      body: content,
    );
  }
}
