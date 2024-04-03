import 'package:agencies_app/providers/rescue_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildRescueHistoryListView extends StatelessWidget {
  const BuildRescueHistoryListView({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final rescueList = ref.watch(rescueHistoryProvider);

    ThemeData themeData = Theme.of(context);
    return rescueList.isEmpty
        ? const Center(
            child: Text(
              "Sorry No Data found!",
            ),
          )
        : ListView.builder(
            itemCount: rescueList.length,
            itemBuilder: (context, index) {
              final rescueOperation = rescueList.elementAt(index);
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
                        Color.fromARGB(69, 57, 111, 59),
                        Color.fromARGB(169, 20, 191, 26),
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
                                rescueOperation.name.toString(),
                                style: GoogleFonts.plusJakartaSans().copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                rescueOperation.description.toString(),
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
                          DateFormat('dd/MM/yy').format(DateTime.parse(
                              rescueOperation.createdAt.toString())),
                          style: GoogleFonts.plusJakartaSans().copyWith(
                            fontWeight: FontWeight.bold,
                            color: (themeData.brightness == Brightness.light)
                                ? Color.fromARGB(255, 8, 72, 20)
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
