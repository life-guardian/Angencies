// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/view/animations/shimmer_animations/listview_shimmer_animation.dart';
import 'package:agencies_app/helper/constants/sizes.dart';
import 'package:agencies_app/model/event_list.dart';
import 'package:agencies_app/helper/classes/modal_bottom_sheet.dart';
import 'package:agencies_app/view_model/providers/manage_events_provider.dart';
import 'package:agencies_app/widget/app_bar/custom_events_appbar.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:agencies_app/widget/listview/events/manage_event_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class ManageEventsScreen extends ConsumerStatefulWidget {
  const ManageEventsScreen({
    super.key,
    required this.agencyName,
    required this.token,
  });

  final String agencyName;
  final token;

  @override
  ConsumerState<ManageEventsScreen> createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends ConsumerState<ManageEventsScreen> {
  late final jwtToken;
  late Map<String, String> headers;
  List<EventList> eventList = [];
  List<String> eventsLocality = [];

  ModalBottomSheet modalBottomSheet = ModalBottomSheet();

  late Widget activeWidget;

  @override
  void initState() {
    super.initState();
    assignActiveWidget();
    initializeTokenHeader();
    getEventList();
  }

  void assignActiveWidget() {
    activeWidget = ref.read(manageEventsProvider).isNotEmpty
        ? ManageEventListView(
            ref: ref,
            token: widget.token,
            agencyName: widget.agencyName,
          )
        : const ListviewShimmerAnimation();
  }

  void initializeTokenHeader() {
    jwtToken = widget.token;
    headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $jwtToken'
    };
  }

  String baseUrl = dotenv.get("BASE_URL");

  Future<void> getEventList() async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/event/agency/list'),
      headers: headers,
    );

    List<EventList> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(EventList.fromJson(jsonData));
      }
    }

    await getEventsLocality(data: data).then((eventListWithLocalities) {
      data = eventListWithLocalities;
    });

    ref.read(manageEventsProvider.notifier).addList(data);

    setState(() {
      activeWidget = ManageEventListView(
        ref: ref,
        token: widget.token,
        agencyName: widget.agencyName,
      );
    });
  }

  Future<List<EventList>> getEventsLocality(
      {required List<EventList> data}) async {
    List<List<double>> coordinates = [];

    for (var event in data) {
      coordinates.add(event.eventPlace!);
    }

    // print(coordinates.toList());

    List<String> localities = [];

    for (List<double> coordinate in coordinates) {
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(coordinate[1], coordinate[0]);
        Placemark placemark = placemarks[0];
        String? locality = placemark.locality;
        localities.add(locality!);
      } catch (error) {
        localities.add("Unknown"); // Add a placeholder for unknown localities
      }
    }

    // eventList.ad

    for (int i = 0; i < data.length; i++) {
      data[i].locality = localities[i];
    }

    // print(data);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                      Container(
                        margin: screenWidth > mobileScreenWidth
                            ? EdgeInsets.only(left: screenWidth / 6.5)
                            : null,
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 5, bottom: 15),
                        child: const Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: "Events",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTextWidget(
                                  text:
                                      "Tap on the event to see registered users",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
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
