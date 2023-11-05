import 'package:agencies_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendAlert extends StatelessWidget {
  const SendAlert({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController alertNameController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Emergency Alert',
            style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            'ALERTING AREA',
            style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                // width: 2,
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Icon(Icons.near_me_outlined),
                  const SizedBox(
                    width: 11,
                  ),
                  Flexible(
                    child: Text(
                      'Area will be in radius of 2km from the locating point',
                      style: GoogleFonts.mulish(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Text(
            'ALERT NAME',
            style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
