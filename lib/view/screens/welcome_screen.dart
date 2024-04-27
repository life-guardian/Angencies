// import 'package:agencies_app/constants/sizes.dart';
import 'package:agencies_app/helper/constants/sizes.dart';
import 'package:agencies_app/view/screens/login_screen.dart';
import 'package:agencies_app/view/screens/register_screen.dart';
import 'package:agencies_app/view/animations/transitions_animations/page_transition_animation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/foundation.dart' show Platform;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _login(BuildContext context) {
    Navigator.of(context).push(
      SlideTransitionAnimation(
        direction: AxisDirection.left,
        child: const LoginScreen(),
      ),
    );
  }

  void _register(BuildContext context) {
    Navigator.of(context).push(
      SlideTransitionAnimation(
        direction: AxisDirection.left,
        child: const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    bool kIsMobile = (screenWidth <= mobileScreenWidth);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: kIsMobile
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: EdgeInsets.only(top: 40.h),
                      width: double.infinity,
                      child: Image(
                        image: const AssetImage(
                            'assets/images/disasterImage1.png'),
                        height: 300.h,
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Image(
                      image:
                          const AssetImage('assets/images/disasterImage2.jpg'),
                      height: 100.h,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Column(
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          'Life Guardian',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
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
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          'For Agencies',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
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
                    ],
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: OutlinedButton(
                        onPressed: () {
                          _register(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor:
                              (themeData.brightness == Brightness.light)
                                  ? const Color(0xff1E232C)
                                  : Colors.white,
                          side: BorderSide(
                            color: (themeData.brightness == Brightness.light)
                                ? const Color(0xff1E232C)
                                : Colors.white,
                          ),
                        ),
                        child: const Text("Register"),
                      ),
                    ),
                  ),
                  const Spacer(),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.w),
                      child: Text(
                        'Jai Hind !',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : welcomScreenWeb(
              context: context, themeData: themeData, screenWidth: screenWidth),
    );
  }

  Widget welcomScreenWeb(
      {required BuildContext context,
      required ThemeData themeData,
      required double screenWidth}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth / 4,
                  margin: const EdgeInsets.only(top: 40),
                  child: Image.asset('assets/images/disasterImage1.png'),
                ),
                Image.asset(
                  'assets/images/disasterImage2.jpg',
                ),
                Text(
                  'Life Guardian',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: const [
                      Shadow(
                        offset: Offset(0.0, 7.0),
                        blurRadius: 15.0,
                        color: Color.fromARGB(57, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                Text(
                  'For Agencies',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    shadows: const [
                      Shadow(
                        offset: Offset(0.0, 7.0),
                        blurRadius: 15.0,
                        color: Color.fromARGB(57, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    'Jai Hind !',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth / 7,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth / 3,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      _login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: screenWidth / 3,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      _register(context);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor:
                          (themeData.brightness == Brightness.light)
                              ? const Color(0xff1E232C)
                              : Colors.white,
                      side: BorderSide(
                        color: (themeData.brightness == Brightness.light)
                            ? const Color(0xff1E232C)
                            : Colors.white,
                      ),
                    ),
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
