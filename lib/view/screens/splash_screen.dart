import 'package:agencies_app/widget/text/custom_lifeguardian_tag.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: Image.asset(
                  'assets/images/disasterImage2.jpg',
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLifeGuardianTag(
                  showLogo: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
