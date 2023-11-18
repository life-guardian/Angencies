import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageCard extends StatelessWidget {
  const ManageCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.showModal,
  });

  final void Function() showModal;

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: showModal,
        child: Container(
          // height: 100,
          // width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
