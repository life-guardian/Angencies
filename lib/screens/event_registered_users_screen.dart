// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/animations/shimmer_animations/listview_shimmer_effect.dart';
import 'package:agencies_app/constants/sizes.dart';
import 'package:agencies_app/classes/modal_bottom_sheet.dart';
import 'package:agencies_app/models/registered_users.dart';
import 'package:agencies_app/widgets/app_bars/custom_events_appbar.dart';
import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:agencies_app/widgets/listview_builder/events/registered_users_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EventRegisteredUsersScreen extends StatefulWidget {
  const EventRegisteredUsersScreen({
    super.key,
    required this.token,
    required this.agencyName,
    required this.eventId,
  });

  final String agencyName;
  final token;
  final String eventId;

  @override
  State<EventRegisteredUsersScreen> createState() =>
      _EventRegisteredListState();
}

class _EventRegisteredListState extends State<EventRegisteredUsersScreen> {
  late final jwtToken;
  late Map<String, String> headers;
  // List<EventList> eventList = [];
  ModalBottomSheet modalBottomSheet = ModalBottomSheet();
  List<RegisteredUsers> registeredUsersList = [];

  Widget activeWidget = const ListviewShimmerEffect();

  @override
  void initState() {
    super.initState();
    initializeTokenHeader();
    getEventRegisteredUsersList(id: widget.eventId).then(
      (value) {
        registeredUsersList.addAll(value);
        setState(() {
          activeWidget = BuildRegisteredUsersListView(
            registeredUsersList: registeredUsersList,
          );
        });
      },
    );
  }

  void initializeTokenHeader() {
    jwtToken = widget.token;
    headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $jwtToken'
    };
  }

  Future<List<RegisteredUsers>> getEventRegisteredUsersList(
      {required String id}) async {
    String baseUrl = dotenv.get("BASE_URL");

    var response = await http.get(
      Uri.parse('$baseUrl/api/event/agency/registrations/$id'),
      headers: headers,
    );

    List<RegisteredUsers> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(RegisteredUsers.fromJson(jsonData));
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomEventsAppBar(agencyName: widget.agencyName),
            const SizedBox(
              height: 21,
            ),
            Expanded(
              child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 5, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: 'Registered Users',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: screenWidth > mobileScreenWidth
                              ? screenWidth / 1.5
                              : double.infinity,
                          child: activeWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
