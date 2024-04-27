// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:agencies_app/helper/constants/sizes.dart';
import 'package:agencies_app/helper/services/history_api.dart';
import 'package:agencies_app/view/animations/shimmer_animations/listview_shimmer_animation.dart';
import 'package:agencies_app/view_model/providers/alert_history_provider.dart';
import 'package:agencies_app/view_model/providers/event_history_provider.dart';
import 'package:agencies_app/view_model/providers/rescue_history_provider.dart';
import 'package:agencies_app/widget/app_bar/custom_events_appbar.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:agencies_app/widget/listview/history/alert_history_listview.dart';
import 'package:agencies_app/widget/listview/history/event_history_listview.dart';
import 'package:agencies_app/widget/listview/history/rescue_operation_history_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class History extends ConsumerStatefulWidget {
  const History({
    super.key,
    required this.token,
    required this.agencyName,
  });

  final token;
  final String agencyName;

  @override
  ConsumerState<History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
  int _currentIndx = 0;
  String filterValue = 'Alert';
  late Widget activeWidget;
  bool isAlertListEmpty = true;

  @override
  void initState() {
    super.initState();

    assignActiveWidget();
    // Get list of data from server
    apiCall();
  }

  void assignActiveWidget() {
    isAlertListEmpty = ref.read(alertHistoryProvider).isEmpty;

    activeWidget = !isAlertListEmpty
        ? activeWidget = BuildAlertHistoryListView(
            ref: ref,
            token: widget.token,
          )
        : const ListviewShimmerAnimation();
  }

  Future<void> apiCall() async {
    HistoryApi historyApi = HistoryApi();
    // alert History api call
    historyApi.getAlertHistoryData(token: widget.token).then((alertHistories) {
      ref.read(alertHistoryProvider.notifier).addList(alertHistories);
      setState(() {
        isAlertListEmpty = false;
        activeWidget = BuildAlertHistoryListView(
          ref: ref,
          token: widget.token,
        );
      });
    });
    // event History api call
    historyApi.getEventHistoryData(token: widget.token).then((eventHistories) =>
        ref.read(eventHistoryProvider.notifier).addList(eventHistories));
    // operation History api call
    historyApi.getOperationHistoryData(token: widget.token).then(
        (operationHistories) => ref
            .read(rescueOperationHistoryProvider.notifier)
            .addList(operationHistories));
  }

  @override
  Widget build(BuildContext context) {
    if (!isAlertListEmpty) {
      if (_currentIndx == 0) {
        filterValue = 'Alert';
        activeWidget = BuildAlertHistoryListView(
          ref: ref,
          token: widget.token,
        );
      } else if (_currentIndx == 1) {
        filterValue = 'Event';
        activeWidget = BuildEventHistoryListView(
          ref: ref,
          token: widget.token,
        );
      } else {
        filterValue = 'Rescue Operation';
        activeWidget = BuildRescueHistoryListView(
          ref: ref,
          token: widget.token,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomEventsAppBar(agencyName: widget.agencyName),
            SizedBox(
              height: 21.h,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: "$filterValue History",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTextWidget(
                              text: "Slide left to delete $filterValue",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: activeWidget,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            unselectedItemColor: const Color.fromARGB(175, 158, 158, 158),
            currentIndex: _currentIndx,
            iconSize: 25,
            onTap: (value) {
              setState(() {
                _currentIndx = value;
              });
            },
            elevation: 5,
            selectedItemColor: activeIconColor(),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_alert_rounded,
                  size: 25.h,
                ),
                activeIcon: Icon(
                  Icons.add_alert_rounded,
                  size: 30.h,
                ),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event_rounded,
                  size: 25.h,
                ),
                activeIcon: Icon(
                  Icons.event_rounded,
                  size: 30.h,
                ),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_border_rounded,
                  size: 25.h,
                ),
                activeIcon: Icon(
                  Icons.star_border_rounded,
                  size: 30.h,
                ),
                label: 'Rescues',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBar({required double screenWidth}) {
    return screenWidth < mobileScreenWidth
        ? Row(
            children: bottomNavigationBarItem(),
          )
        : const Column(
            children: [],
          );
  }

  List<Widget> bottomNavigationBarItem() {
    return [
      // Icon
    ];
  }

  Color activeIconColor() {
    if (_currentIndx == 0) {
      return Colors.red;
    } else if (_currentIndx == 1) {
      return Colors.blue;
    }
    return Colors.green;
  }
}
