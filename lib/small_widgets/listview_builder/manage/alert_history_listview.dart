import 'package:agencies_app/providers/alert_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildAlertHistoryListView extends StatelessWidget {
  const BuildAlertHistoryListView({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final alertList = ref.watch(alertHistoryProvider);

    return alertList.isEmpty
        ? const Center(
            child: Text(
              "Sorry No Data found!",
            ),
          )
        : ListView.builder(
            itemCount: alertList.length,
            itemBuilder: (context, index) {
              final alert = alertList.elementAt(index);
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert.alertName.toString(),
                            style: GoogleFonts.plusJakartaSans().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            alert.alertSeverity.toString(),
                            style: GoogleFonts.plusJakartaSans().copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('dd/MM/yy').format(
                            DateTime.parse(alert.alertForDate.toString())),
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          fontWeight: FontWeight.bold,
                          color: (themeData.brightness == Brightness.light)
                              ? const Color.fromARGB(255, 224, 28, 14)
                              : Theme.of(context).colorScheme.onBackground,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
