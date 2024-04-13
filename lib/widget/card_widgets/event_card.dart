import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.color1,
    required this.color2,
    required this.onTap,
    required this.circleColor,
  });
  final String text1;

  final String text2;
  final String text3;
  final Color color1;
  final Color color2;
  final Color circleColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 3,
          child: Container(
            // height: 120,
            // width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (themeData.brightness == Brightness.dark)
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              gradient: (themeData.brightness == Brightness.light)
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color1,
                        color2,
                      ],
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleColor,
                  ),
                  child: Center(
                    child: Text(
                      text1,
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CustomTextWidget(
                      text: text2,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(206, 255, 255, 255),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextWidget(
                      text: text3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(206, 255, 255, 255),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
