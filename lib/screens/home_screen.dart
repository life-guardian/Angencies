// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/large_widgets/card_widgets/event_rescue_count.dart';
import 'package:agencies_app/large_widgets/modal_widgets/organize_event.dart';
import 'package:agencies_app/large_widgets/modal_widgets/rescue_operation.dart';
import 'package:agencies_app/large_widgets/modal_widgets/send_alert.dart';

import 'package:agencies_app/screens/managae_events_screen.dart';
import 'package:agencies_app/screens/rescue_map_screen.dart';
import 'package:agencies_app/large_widgets/card_widgets/event_card.dart';
import 'package:agencies_app/large_widgets/card_widgets/manage_card.dart';

import 'package:agencies_app/large_widgets/modal_widgets/history.dart';
import 'package:agencies_app/transitions_animations/custom_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.token});
  final token;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userId;
  late String eventsCount;
  late String rescueCount;
  late String agencyname;

  Widget activeScreen = const Center(
    child: CircularProgressIndicator(
      color: Colors.grey,
    ),
  );

  @override
  void initState() {
    super.initState();
    Map jwtDecoded = JwtDecoder.decode(widget.token);
    // userId = jwtDecoded['id'];
    getAgencyDataFromServer();

    // code to decode data from server
  }

  Future<void> getAgencyDataFromServer() async {
    final jwtToken = widget.token;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $jwtToken'
    };

    var response = await http.get(
      Uri.parse(getAgencyHomeScreenUrl),
      headers: headers,
    );

    var jsonResponse = jsonDecode(response.body);
    setState(() {
      eventsCount = jsonResponse['eventsCount'].toString();
      rescueCount = jsonResponse['rescueOperationsCount'].toString();
      agencyname = jsonResponse['agencyName'].toString();
      agencyname = agencyname[0].toUpperCase() + agencyname.substring(1);
      activeScreen = homeScreenWidget();
    });
  }

  void _openModal(BuildContext context, Widget widget) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (ctx) => widget,
    );
  }

  Widget homeScreenWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        'NDRF Team $agencyname',
                        // email,
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            EventRescueCountCard(
                eventCount: eventsCount, rescueCount: rescueCount),
            const SizedBox(
              height: 21,
            ),
            Text(
              'Manage',
              style: GoogleFonts.plusJakartaSans().copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  ManageCard(
                    text1: 'Alert for disaster',
                    text2: 'Send Alert',
                    showModal: () {
                      _openModal(
                        context,
                        SendAlert(
                          token: widget.token,
                        ),
                      );
                    },
                    lineColor1: Colors.red.shade400,
                    lineColor2: Colors.red.shade50,
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  ManageCard(
                    text1: 'Rescue Operation',
                    text2: 'Start',
                    showModal: () {
                      _openModal(
                        context,
                        const RescueOperation(),
                      );
                    },
                    lineColor1: Colors.green.shade400,
                    lineColor2: Colors.green.shade50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  ManageCard(
                    text1: 'Awareness Event',
                    text2: 'Organize Event',
                    showModal: () {
                      _openModal(
                        context,
                        OrganizeEvent(token: widget.token),
                      );
                    },
                    lineColor1: Colors.yellow.shade400,
                    lineColor2: Colors.yellow.shade50,
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  ManageCard(
                    text1: 'History',
                    text2: 'History',
                    showModal: () {
                      _openModal(
                        context,
                        History(
                          token: widget.token,
                          agencyName: agencyname,
                        ),
                      );
                    },
                    lineColor1: Colors.blue.shade400,
                    lineColor2: Colors.blue.shade50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Text(
              'Events',
              style: GoogleFonts.plusJakartaSans().copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EventCard(
                  text1: 'E',
                  text2: 'Manage',
                  text3: 'Events',
                  color1: const Color.fromARGB(232, 224, 144, 131),
                  color2: const Color.fromARGB(232, 224, 83, 61),
                  onTap: () => Navigator.of(context).push(
                    CustomSlideTransition(
                      direction: AxisDirection.left,
                      child: ManageEventsScreen(agencyName: agencyname),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                EventCard(
                  text1: 'M',
                  text2: 'Rescue',
                  text3: 'Map',
                  color1: const Color.fromARGB(225, 226, 167, 178),
                  color2: const Color.fromARGB(228, 231, 140, 157),
                  onTap: () => Navigator.of(context).push(
                    CustomSlideTransition(
                      direction: AxisDirection.left,
                      child: const RescueMapScreen(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 21,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return activeScreen;
  }
}
