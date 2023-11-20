// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/modal_bottom_sheets/history.dart';
import 'package:agencies_app/modal_bottom_sheets/organize_event.dart';
import 'package:agencies_app/modal_bottom_sheets/rescue_operation.dart';
import 'package:agencies_app/modal_bottom_sheets/send_alert.dart';
import 'package:agencies_app/widgets/event_card.dart';
import 'package:agencies_app/widgets/manage_card.dart';
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
  late String events;
  late String rescueOps;

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
      events = jsonResponse['eventsCount'].toString();
      rescueOps = jsonResponse['rescueOperationsCount'].toString();
      activeScreen = homeScreenWidget();
    });
  }

  void _openModal(BuildContext context, Widget widget) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
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
                        'NDRF Team REX78',
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
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.green,
                        size: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Events',
                            style: GoogleFonts.inter().copyWith(
                                color: const Color.fromARGB(255, 220, 217, 217),
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(events,
                              style: GoogleFonts.inter().copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: VerticalDivider(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.green,
                        size: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rescue Ops',
                            style: GoogleFonts.inter().copyWith(
                                color: const Color.fromARGB(255, 220, 217, 217),
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            rescueOps,
                            style: GoogleFonts.inter().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
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
                        const History(),
                      );
                    },
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EventCard(
                  text1: 'E',
                  text2: 'Manage',
                  text3: 'Events',
                  color1: Color.fromARGB(232, 224, 144, 131),
                  color2: Color.fromARGB(232, 224, 83, 61),
                ),
                SizedBox(
                  width: 25,
                ),
                EventCard(
                  text1: 'M',
                  text2: 'Rescue',
                  text3: 'Map',
                  color1: Color.fromARGB(225, 226, 167, 178),
                  color2: Color.fromARGB(228, 231, 140, 157),
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
