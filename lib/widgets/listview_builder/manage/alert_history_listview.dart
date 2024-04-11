// ignore_for_file: use_build_context_synchronously

import 'package:agencies_app/apis/custom_delete_eventsapi.dart';
import 'package:agencies_app/models/alert_history.dart';
import 'package:agencies_app/providers/alert_history_provider.dart';
import 'package:agencies_app/widgets/custom_images/custom_error_image.dart';
import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuildAlertHistoryListView extends StatefulWidget {
  const BuildAlertHistoryListView({
    super.key,
    required this.ref,
    required this.token,
  });

  final WidgetRef ref;
  final String token;

  @override
  State<BuildAlertHistoryListView> createState() =>
      _BuildAlertHistoryListViewState();
}

class _BuildAlertHistoryListViewState extends State<BuildAlertHistoryListView> {
  void deleteAlert({
    required WidgetRef ref,
    required int indx,
    required String alertId,
    required AlertHistory alert,
  }) {
    setState(() {
      ref.read(alertHistoryProvider.notifier).removeAt(index: indx);
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
                    .read(alertHistoryProvider.notifier)
                    .insertAt(index: indx, alert: alert);
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
          apiUrl: '$baseUrl/api/alert/agency/delete/$alertId',
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
    final alertList = widget.ref.watch(alertHistoryProvider);

    return alertList.isEmpty
        ? const CustomErrorImage(
            headingText: "No Alerts Found!",
            imagePath: "assets/images/animated_images/nothingfound.png",
          )
        : SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: ListView.builder(
              itemCount: alertList.length,
              itemBuilder: (context, index) {
                final alert = alertList.elementAt(index);
                return Slidable(
                  key: Key(alert.alertId!),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () => deleteAlert(
                        ref: widget.ref,
                        indx: index,
                        alertId: alert.alertId!,
                        alert: alert,
                      ),
                    ),
                    children: [
                      SlidableAction(
                        label: "Delete",
                        icon: Icons.delete,
                        onPressed: (context) {
                          deleteAlert(
                            ref: widget.ref,
                            indx: index,
                            alertId: alert.alertId!,
                            alert: alert,
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
                                CustomTextWidget(
                                  text: alert.alertName.toString(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomTextWidget(
                                  text: alert.alertSeverity.toString(),
                                  color: const Color.fromARGB(255, 158, 18, 8),
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            CustomTextWidget(
                              text: DateFormat('dd/MM/yy').format(
                                  DateTime.parse(
                                      alert.alertForDate.toString())),
                              fontWeight: FontWeight.bold,
                              color: (themeData.brightness == Brightness.light)
                                  ? const Color.fromARGB(255, 158, 18, 8)
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
