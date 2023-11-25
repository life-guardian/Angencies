// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, no_logic_in_create_state

import 'dart:convert';

import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/screens/home_screen.dart';
import 'package:agencies_app/screens/login_screen.dart';
import 'package:agencies_app/screens/user_account_details.dart';
import 'package:agencies_app/screens/welcome_screen.dart';
import 'package:agencies_app/small_widgets/custom_dialogs/custom_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TabsBottom extends StatefulWidget {
  const TabsBottom({super.key, this.myToken});
  final myToken;

  @override
  State<TabsBottom> createState() => _TabsBottomState();
}

class _TabsBottomState extends State<TabsBottom> {
  late Widget activePage;
  int _currentIndx = 0;

  @override
  void initState() {
    super.initState();
    activePage = HomeScreen(token: widget.myToken);
  }

  void onSelectedTab(int index) {
    setState(
      () {
        _currentIndx = index;
      },
    );
  }

  void _logoutUser() async {
    showDialog(
      context: context,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${widget.myToken}'
    };

    var response = await http.delete(
      Uri.parse(logoutUserUrl),
      headers: headers,
    );

    var jsonResponse = jsonDecode(response.body);

    String message = jsonResponse['message'];

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');

      while (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const WelcomeScreen(),
        ),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } else {
      customShowDialog(
          context: context, titleText: 'Ooops!', contentText: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndx == 1) {
      activePage = UserAccountDetails(
        logoutUser: _logoutUser,
      );
    } else if (_currentIndx == 0) {
      activePage = HomeScreen(token: widget.myToken);
    }

    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: activePage),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color.fromARGB(175, 158, 158, 158),
        currentIndex: _currentIndx,
        iconSize: 25,
        onTap: onSelectedTab,
        selectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
