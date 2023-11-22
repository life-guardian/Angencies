import 'package:agencies_app/models/alert_history.dart';
import 'package:agencies_app/models/event_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildAlertHistoryListView extends StatelessWidget {
  const BuildAlertHistoryListView({super.key, required this.list});

  final List<AlertHistory> list;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final alertData = list.elementAt(index);
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
                      alertData.alertName.toString(),
                      style: GoogleFonts.plusJakartaSans().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      alertData.alertSeverity.toString(),
                      style: GoogleFonts.plusJakartaSans().copyWith(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('dd/MM/yy').format(
                      DateTime.parse(alertData.alertForDate.toString())),
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

class BuildEventHistoryListView extends StatelessWidget {
  const BuildEventHistoryListView({super.key, required this.list});

  final List<EventHistory> list;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final eventData = list.elementAt(index);
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventData.eventName.toString(),
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        eventData.description.toString(),
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('dd/MM/yy')
                      .format(DateTime.parse(eventData.eventDate.toString())),
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
