import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterHistory extends StatelessWidget {
  const FilterHistory({
    super.key,
    required this.getFilterValue,
  });

  final void Function(String filterValue) getFilterValue;

  void popScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              getFilterValue('Alert History');
              popScreen(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                child: Text(
                  'Alert History',
                  style: GoogleFonts.plusJakartaSans().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              getFilterValue('Event History');
              popScreen(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                child: Text(
                  'Event History',
                  style: GoogleFonts.plusJakartaSans().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              getFilterValue('Rescue Operations History');
              popScreen(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                child: Text(
                  'Rescue Operations History',
                  style: GoogleFonts.plusJakartaSans().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
