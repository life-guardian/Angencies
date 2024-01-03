// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/models/event_list.dart';
import 'package:agencies_app/models/modal_bottom_sheet.dart';
import 'package:agencies_app/small_widgets/listview_builder/events/manage_event_listview.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ManageEventsScreen extends StatefulWidget {
  const ManageEventsScreen({
    super.key,
    required this.agencyName,
    required this.token,
  });

  final String agencyName;
  final token;

  @override
  State<ManageEventsScreen> createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends State<ManageEventsScreen> {
  late final jwtToken;
  late Map<String, String> headers;
  List<EventList> eventList = [];
  List<String> eventsLocality = [];

  ModalBottomSheet modalBottomSheet = ModalBottomSheet();
  String filterValue = 'Events';

  Widget activeWidget = const Center(
    child: CircularProgressIndicator(
      color: Colors.grey,
    ),
  );

  @override
  void initState() {
    super.initState();
    initializeTokenHeader();
    getEventList().then(
      (value) {
        eventList.addAll(value);
        // active widget
        setState(() {
          activeWidget = BuildManageEventListView(
            eventList: eventList,
            token: widget.token,
            agencyName: widget.agencyName,
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

  Future<List<EventList>> getEventList() async {
    var response = await http.get(
      Uri.parse(manageEventHistoryUrl),
      headers: headers,
    );

    List<EventList> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(EventList.fromJson(jsonData));
      }
    }

    return getEventsLocality(data: data);
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
        print("Error fetching locality for coordinates: $coordinate");
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
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/logos/indiaflaglogo.png'),
                  const SizedBox(
                    width: 21,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jai Hind!',
                        style: GoogleFonts.inter().copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.agencyName,
                        // email,
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      foregroundColor:
                          (themeData.brightness == Brightness.light)
                              ? const Color.fromARGB(185, 30, 35, 44)
                              : const Color(0xffe1dcd3),
                      side: BorderSide(
                        color: (themeData.brightness == Brightness.light)
                            ? const Color.fromARGB(32, 30, 35, 44)
                            : const Color(0xffE1DCD3),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                        Text('back')
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 5, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                filterValue,
                                style: GoogleFonts.plusJakartaSans().copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 22,
                              height: 22,
                              margin: const EdgeInsets.only(top: 4),
                              child: Image.asset(
                                'assets/logos/settings-sliders.png',
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
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
    );
  }
}
