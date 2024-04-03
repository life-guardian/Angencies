import 'package:agencies_app/providers/event_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildEventHistoryListView extends StatelessWidget {
  const BuildEventHistoryListView({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final eventList = ref.watch(eventHistoryProvider);

    return eventList.isEmpty
        ? const Center(
            child: Text(
              "Sorry No Data found!",
            ),
          )
        : ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final event = eventList.elementAt(index);
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
                        Color.fromARGB(88, 67, 92, 112),
                        Color.fromARGB(178, 33, 149, 243),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.eventName.toString(),
                                style: GoogleFonts.plusJakartaSans().copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                event.description.toString(),
                                style: GoogleFonts.plusJakartaSans().copyWith(
                                  color: const Color.fromARGB(255, 0, 58, 112),
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
                          DateFormat('dd/MM/yy').format(
                              DateTime.parse(event.eventDate.toString())),
                          style: GoogleFonts.plusJakartaSans().copyWith(
                            fontWeight: FontWeight.bold,
                            color: (themeData.brightness == Brightness.light)
                                ? const Color.fromARGB(255, 0, 58, 112)
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
