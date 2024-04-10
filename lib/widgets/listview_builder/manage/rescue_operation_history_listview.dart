import 'package:agencies_app/apis/custom_delete_eventsapi.dart';
import 'package:agencies_app/models/operation_history.dart';
import 'package:agencies_app/providers/rescue_history_provider.dart';
import 'package:agencies_app/widgets/custom_images/custom_error_image.dart';
import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildRescueHistoryListView extends StatefulWidget {
  const BuildRescueHistoryListView(
      {super.key, required this.ref, required this.token});

  final WidgetRef ref;
  final String token;

  @override
  State<BuildRescueHistoryListView> createState() =>
      _BuildRescueHistoryListViewState();
}

class _BuildRescueHistoryListViewState
    extends State<BuildRescueHistoryListView> {
  void deleteRescueOperation({
    required WidgetRef ref,
    required int indx,
    required String rescueId,
    required RescueOperationHistory rescueOperation,
  }) {
    setState(() {
      ref.read(rescueOperationHistoryProvider.notifier).removeAt(index: indx);
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
                    .read(rescueOperationHistoryProvider.notifier)
                    .insertAt(index: indx, rescueOperation: rescueOperation);
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
          apiUrl: '$baseUrl/api/rescueops/agency/delete/$rescueId',
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
    final rescueList = widget.ref.watch(rescueOperationHistoryProvider);

    ThemeData themeData = Theme.of(context);
    return rescueList.isEmpty
        ? const CustomErrorImage(
            headingText: "No Alerts Found!",
            imagePath: "assets/images/animated_images/nothingfound.png",
          )
        : SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: ListView.builder(
              itemCount: rescueList.length,
              itemBuilder: (context, index) {
                final rescueOperation = rescueList.elementAt(index);
                return Slidable(
                  key: Key(rescueOperation.sId!),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(
                        onDismissed: () => deleteRescueOperation(
                              ref: widget.ref,
                              indx: index,
                              rescueId: rescueOperation.sId!,
                              rescueOperation: rescueOperation,
                            )),
                    children: [
                      SlidableAction(
                        label: "Delete",
                        icon: Icons.delete,
                        onPressed: (context) {
                          deleteRescueOperation(
                            ref: widget.ref,
                            indx: index,
                            rescueId: rescueOperation.sId!,
                            rescueOperation: rescueOperation,
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
                                    style:
                                        GoogleFonts.plusJakartaSans().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    rescueOperation.description.toString(),
                                    style:
                                        GoogleFonts.plusJakartaSans().copyWith(
                                      color: (themeData.brightness ==
                                              Brightness.light)
                                          ? const Color.fromARGB(255, 8, 72, 20)
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
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
                                color:
                                    (themeData.brightness == Brightness.light)
                                        ? const Color.fromARGB(255, 8, 72, 20)
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                fontSize: 14,
                              ),
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
