// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:agencies_app/screens/home_screen.dart';
import 'package:agencies_app/screens/login_screen.dart';
import 'package:agencies_app/screens/user_account_details.dart';
import 'package:agencies_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabsBottom extends StatefulWidget {
  const TabsBottom({super.key, this.myToken});
  final myToken;

  @override
  State<TabsBottom> createState() => _TabsBottomState();
}

class _TabsBottomState extends State<TabsBottom> {
  int _currentIndx = 0;
  void onSelectedTab(int index) {
    setState(
      () {
        _currentIndx = index;
      },
    );
  }

  void _logoutUser() async {
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
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreen(token: widget.myToken);

    if (_currentIndx == 1) {
      activePage = UserAccountDetails(
        logoutUser: _logoutUser,
      );
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
