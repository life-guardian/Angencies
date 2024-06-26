import 'package:agencies_app/helper/services/custom_delete_eventsapi.dart';
import 'package:agencies_app/model/operation_history.dart';
import 'package:agencies_app/view_model/providers/rescue_history_provider.dart';
import 'package:agencies_app/widget/errors/search_error_image.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        ? FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: const SearchErrorImage(
              headingText: "No Rescues Found!",
              imagePath: "assets/images/animated_images/nothingfound.png",
            ),
          )
        : FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: SlidableAutoCloseBehavior(
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
                          backgroundColor:
                              const Color.fromARGB(216, 195, 29, 17),
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
                                    CustomTextWidget(
                                      text: rescueOperation.name.toString(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextWidget(
                                      text: rescueOperation.locality.toString(),
                                      color: (themeData.brightness ==
                                              Brightness.light)
                                          ? const Color.fromARGB(178, 4, 59, 14)
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                      fontSize: 12,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextWidget(
                                      text: rescueOperation.description
                                          .toString(),
                                      color: (themeData.brightness ==
                                              Brightness.light)
                                          ? const Color.fromARGB(255, 8, 72, 20)
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                      fontSize: 12,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomTextWidget(
                                text: DateFormat('dd/MM/yy').format(
                                    DateTime.parse(
                                        rescueOperation.createdAt.toString())),
                                fontWeight: FontWeight.bold,
                                color:
                                    (themeData.brightness == Brightness.light)
                                        ? const Color.fromARGB(255, 8, 72, 20)
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
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
            ),
          );
  }
}
