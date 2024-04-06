import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageCard extends StatelessWidget {
  const ManageCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.showModal,
    required this.lineColor1,
    required this.lineColor2,
    this.stop1 = 0.5,
    this.width,
    this.height,
  });

  final void Function() showModal;

  final String text1;
  final String text2;
  final Color lineColor1;
  final Color lineColor2;
  final double stop1;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: showModal,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(30, 0, 0, 0),
                offset: Offset(0, 3),
                blurRadius: 50,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text1,
                            style: GoogleFonts.inter().copyWith(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 185, 182, 182),
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Text(
                            text2,
                            style: GoogleFonts.inter().copyWith(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                // the color line if possible see in figma
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const [0.5, 0.5],
                        colors: [
                          lineColor1,
                          lineColor2,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
