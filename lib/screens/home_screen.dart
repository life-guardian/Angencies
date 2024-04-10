// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:agencies_app/animations/shimmer_animations/homescreen_shimmer_effect.dart';
import 'package:agencies_app/widgets/card_widgets/event_rescue_count_card.dart';
import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:agencies_app/widgets/modal_widgets/organize_event.dart';
import 'package:agencies_app/widgets/modal_widgets/rescue_operation.dart';
import 'package:agencies_app/widgets/modal_widgets/send_alert.dart';
import 'package:agencies_app/classes/modal_bottom_sheet.dart';
import 'package:agencies_app/providers/agencydetails_providers.dart';

import 'package:agencies_app/screens/managae_events_screen.dart';
import 'package:agencies_app/screens/rescue_map_screen.dart';
import 'package:agencies_app/widgets/card_widgets/event_card.dart';
import 'package:agencies_app/widgets/card_widgets/manage_card.dart';

import 'package:agencies_app/widgets/screen_widgets/history.dart';
import 'package:agencies_app/animations/transitions_animations/custom_page_transition.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.token,
  });
  final token;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late String userId;
  String? eventsCount;
  String? rescueCount;
  XFile? _pickedImage;
  String? agencyname;
  late bool isRescueOnGoing;

  bool? isadded;

  ModalBottomSheet modalBottomSheet = ModalBottomSheet();

  @override
  void initState() {
    super.initState();

    getAgencyDataFromServer();
  }

  Future<void> getAgencyDataFromServer() async {
    final jwtToken = widget.token;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $jwtToken'
    };

    String baseUrl = dotenv.get("BASE_URL");

    var response = await http.get(
      Uri.parse('$baseUrl/api/agency/eventroperationcount'),
      headers: headers,
    );

    var jsonResponse = jsonDecode(response.body);
    setState(() {
      ref.read(isLoadingHomeScreen.notifier).state = false;
      eventsCount = jsonResponse['eventsCount'].toString();
      rescueCount = jsonResponse['rescueOperationsCount'].toString();
      agencyname = jsonResponse['agencyName'].toString();
      agencyname = agencyname![0].toUpperCase() + agencyname!.substring(1);
      ref
          .read(agencyNameProvider.notifier)
          .update((state) => agencyname ?? 'Unknown');

      ref
          .read(eventsCountProvider.notifier)
          .update((state) => [eventsCount ?? '0', rescueCount ?? '0']);
    });
  }

  void navigateToRescueMaps() {
    Navigator.of(context).push(
      CustomSlideTransition(
        direction: AxisDirection.left,
        child: const RescueMapScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingHomeScreen);
    isRescueOnGoing = ref.watch(isRescueOperationOnGoingProvider);
    _pickedImage = ref.watch(profileImageProvider);

    ThemeData themeData = Theme.of(context);
    agencyname = ref.watch(agencyNameProvider);
    String grettingMessage = ref.watch(greetingProvider);
    eventsCount = ref.watch(eventsCountProvider.notifier).state[0];
    rescueCount = ref.watch(eventsCountProvider.notifier).state[1];

    return isLoading
        ? const HomeScreenShimmerEffect()
        : Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_pickedImage != null)
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: AlertDialog(
                                        content: Image(
                                          image: FileImage(
                                            File(_pickedImage!.path),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    FileImage(File(_pickedImage!.path)),
                              ),
                            ),
                          const SizedBox(
                            width: 21,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: grettingMessage,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                // color: const Color.fromARGB(255, 220, 217, 217),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              CustomTextWidget(
                                text: agencyname ?? 'Loading...',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                // color: const Color.fromARGB(255, 220, 217, 217),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: EventRescueCountCard(
                        eventCount: eventsCount ?? '0',
                        rescueCount: rescueCount ?? '0'),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'Manage',
                      style: GoogleFonts.plusJakartaSans().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 140,
                      child: Row(
                        mainAxisAlignment: kIsWeb
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.center,
                        children: [
                          ManageCard(
                            text1: 'Rescue Operation',
                            text2: 'Start',
                            showModal: isRescueOnGoing
                                ? () {
                                    navigateToRescueMaps();
                                  }
                                : () async {
                                    await modalBottomSheet.openModal(
                                      context: context,
                                      widget:
                                          RescueOperation(token: widget.token),
                                    );
                                    getAgencyDataFromServer();
                                  },
                            lineColor1: Colors.yellow.shade400,
                            lineColor2: Colors.yellow.shade50,
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          ManageCard(
                            text1: 'Awareness Event',
                            text2: 'Organize Event',
                            showModal: () async {
                              await modalBottomSheet.openModal(
                                context: context,
                                widget: OrganizeEvent(token: widget.token),
                              );
                              getAgencyDataFromServer();
                            },
                            lineColor1: Colors.green.shade400,
                            lineColor2: Colors.green.shade50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 140,
                      child: Row(
                        mainAxisAlignment: kIsWeb
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.center,
                        children: [
                          ManageCard(
                            text1: 'Alert for disaster',
                            text2: 'Send Alert',
                            showModal: () {
                              modalBottomSheet.openModal(
                                context: context,
                                widget: SendAlert(token: widget.token),
                              );
                            },
                            lineColor1: Colors.red.shade400,
                            lineColor2: Colors.red.shade50,
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          ManageCard(
                            text1: 'See all history',
                            text2: 'Manage History',
                            showModal: () {
                              Navigator.of(context).push(
                                CustomSlideTransition(
                                  direction: AxisDirection.left,
                                  child: History(
                                      token: widget.token,
                                      agencyName: agencyname!),
                                ),
                              );
                            },
                            lineColor1: Colors.blue.shade400,
                            lineColor2: Colors.blue.shade50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'View',
                      style: GoogleFonts.plusJakartaSans().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 140,
                      child: Row(
                        mainAxisAlignment: kIsWeb
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.center,
                        children: [
                          EventCard(
                            text1: 'E',
                            text2: 'Registration',
                            text3: 'Events',
                            color1: const Color.fromARGB(232, 213, 128, 115),
                            color2: const Color.fromARGB(232, 214, 70, 47),
                            circleColor: themeData.brightness == Brightness.dark
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromARGB(206, 255, 255, 255),
                            onTap: () => Navigator.of(context).push(
                              CustomSlideTransition(
                                direction: AxisDirection.left,
                                child: ManageEventsScreen(
                                    agencyName: agencyname!,
                                    token: widget.token),
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
                            color1: const Color.fromARGB(223, 226, 168, 180),
                            color2: const Color.fromARGB(226, 215, 123, 140),
                            circleColor: themeData.brightness == Brightness.dark
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromARGB(206, 255, 255, 255),
                            onTap: () => Navigator.of(context).push(
                              CustomSlideTransition(
                                direction: AxisDirection.left,
                                child: const RescueMapScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                ],
              ),
            ),
          );
  }
}
