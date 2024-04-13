import 'package:agencies_app/helper/services/custom_delete_eventsapi.dart';
import 'package:agencies_app/model/event_history.dart';
import 'package:agencies_app/view_model/providers/event_history_provider.dart';
import 'package:agencies_app/widget/errors/search_error_image.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class BuildEventHistoryListView extends StatefulWidget {
  const BuildEventHistoryListView(
      {super.key, required this.ref, required this.token});

  final WidgetRef ref;
  final String token;

  @override
  State<BuildEventHistoryListView> createState() =>
      _BuildEventHistoryListViewState();
}

class _BuildEventHistoryListViewState extends State<BuildEventHistoryListView> {
  void deleteEvent({
    required WidgetRef ref,
    required int indx,
    required String eventId,
    required EventHistory event,
  }) {
    setState(() {
      ref.read(eventHistoryProvider.notifier).removeAt(index: indx);
    });

    bool isUndo = false;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomTextWidget(
          text: "Event Delete Succefully",
          color: Theme.of(context).colorScheme.background,
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                isUndo = true;
                ref
                    .read(eventHistoryProvider.notifier)
                    .insertAt(index: indx, event: event);
              },
            );
          },
        ),
      ),
    );

    String baseUrl = dotenv.get("BASE_URL");

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        customDeleteEventsApi(
          apiUrl: '$baseUrl/api/event/agency/cancel/$eventId',
          context: mounted ? context : null,
          mounted: mounted,
          token: widget.token,
          isUndo: isUndo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final eventList = widget.ref.watch(eventHistoryProvider);

    return eventList.isEmpty
        ? const SearchErrorImage(
            headingText: "No Events Found!",
            imagePath: "assets/images/animated_images/nothingfound.png",
          )
        : SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                final event = eventList.elementAt(index);
                return Slidable(
                  key: Key(event.sId!),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () => deleteEvent(
                        ref: widget.ref,
                        indx: index,
                        eventId: event.sId!,
                        event: event,
                      ),
                    ),
                    children: [
                      SlidableAction(
                        label: "Delete",
                        icon: Icons.delete,
                        onPressed: (context) {
                          deleteEvent(
                            ref: widget.ref,
                            indx: index,
                            eventId: event.sId!,
                            event: event,
                          );
                        },
                        backgroundColor: const Color.fromARGB(216, 195, 29, 17),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                  child: Card(
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
                                  CustomTextWidget(
                                    text: event.eventName.toString(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextWidget(
                                    text: event.description.toString(),
                                    color: (themeData.brightness ==
                                            Brightness.light)
                                        ? const Color.fromARGB(255, 0, 58, 112)
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                    fontSize: 12,
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTextWidget(
                              text: DateFormat('dd/MM/yy').format(
                                  DateTime.parse(event.eventDate.toString())),
                              fontWeight: FontWeight.bold,
                              color: (themeData.brightness == Brightness.light)
                                  ? const Color.fromARGB(255, 0, 58, 112)
                                  : Theme.of(context).colorScheme.onBackground,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
