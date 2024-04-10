// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:agencies_app/animations/shimmer_animations/listview_shimmer_effect.dart';
import 'package:agencies_app/models/alert_history.dart';
import 'package:agencies_app/models/event_history.dart';
import 'package:agencies_app/classes/modal_bottom_sheet.dart';
import 'package:agencies_app/models/operation_history.dart';
import 'package:agencies_app/providers/alert_history_provider.dart';
import 'package:agencies_app/providers/event_history_provider.dart';
import 'package:agencies_app/providers/rescue_history_provider.dart';
import 'package:agencies_app/widgets/app_bars/custom_events_appbar.dart';
import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:agencies_app/widgets/listview_builder/manage/alert_history_listview.dart';
import 'package:agencies_app/widgets/listview_builder/manage/event_history_listview.dart';
import 'package:agencies_app/widgets/listview_builder/manage/rescue_operation_history_listview.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
  late final jwtToken;
  late Map<String, String> headers;
  int _currentIndx = 0;

  ModalBottomSheet modalBottomSheet = ModalBottomSheet();

  String filterValue = 'Alert';

  List<RescueOperationHistory> operationHistoryData = [];
  late Widget activeWidget;
  bool isAlertListEmpty = true;

  @override
  void initState() {
    super.initState();

    assignActiveWidget();
    initializeTokenHeader();
    // Get list of data from server
    getAlertHistoryData();
    getEventHistoryData();
    getOperationHistoryData();
  }

  void assignActiveWidget() {
    isAlertListEmpty = ref.read(alertHistoryProvider).isEmpty;

    activeWidget = !isAlertListEmpty
        ? activeWidget = BuildAlertHistoryListView(
            ref: ref,
            token: widget.token,
          )
        : const ListviewShimmerEffect();
  }

  void initializeTokenHeader() {
    jwtToken = widget.token;
    headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $jwtToken'
    };
  }

  String baseUrl = dotenv.get("BASE_URL");

  Future<void> getAlertHistoryData() async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/history/agency/alerts'),
      headers: headers,
    );

    List<AlertHistory> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(AlertHistory.fromJson(jsonData));
      }
    }

    ref.read(alertHistoryProvider.notifier).addList(data);

    setState(() {
      isAlertListEmpty = false;
      activeWidget = BuildAlertHistoryListView(
        ref: ref,
        token: widget.token,
      );
    });
  }

  Future<void> getEventHistoryData() async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/history/agency/events'),
      headers: headers,
    );

    List<EventHistory> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(EventHistory.fromJson(jsonData));
      }
    }
    ref.read(eventHistoryProvider.notifier).addList(data);
  }

  Future<void> getOperationHistoryData() async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/history/agency/operations'),
      headers: headers,
    );

    List<RescueOperationHistory> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(RescueOperationHistory.fromJson(jsonData));
      }
    }

    ref.read(rescueOperationHistoryProvider.notifier).addList(data);
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
            const SizedBox(
              height: 21,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: "$filterValue History",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomTextWidget(
                                text: "Slide left to delete $filterValue",
                                fontSize: 12,
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add_alert_rounded),
                activeIcon: Icon(Icons.add_alert_rounded),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_rounded),
                activeIcon: Icon(Icons.event_rounded),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border_rounded),
                activeIcon: Icon(Icons.star_border_rounded),
                label: 'Rescues',
              ),
            ],
          ),
        ),
      ),
    );
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
