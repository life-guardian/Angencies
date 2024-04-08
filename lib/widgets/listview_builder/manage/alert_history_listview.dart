import 'package:agencies_app/providers/alert_history_provider.dart';
import 'package:agencies_app/widgets/custom_images/no_data_found.dart';
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
        ? const NoDataFoundImage(
            headingText: "No Alerts Found!",
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(41, 106, 51, 47),
                        Color.fromARGB(157, 177, 12, 0),
                      ],
                      stops: [
                        0.1,
                        0.9,
                      ],
                    ),
                  ),
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
                                color: const Color.fromARGB(255, 158, 18, 8),
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
                                ? const Color.fromARGB(255, 158, 18, 8)
                                : Theme.of(context).colorScheme.onBackground,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
