// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:agencies_app/view/animations/shimmer_animations/homescreen_shimmer_animation.dart';
import 'package:agencies_app/model/manage_event.dart';
import 'package:agencies_app/widget/card/event_rescue_count_card.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:agencies_app/widget/errors/no_internet.dart';
import 'package:agencies_app/widget/manage/organize_event.dart';
import 'package:agencies_app/widget/manage/rescue_operation.dart';
import 'package:agencies_app/widget/manage/send_alert.dart';
import 'package:agencies_app/helper/classes/modal_bottom_sheet.dart';
import 'package:agencies_app/view_model/providers/agencydetails_providers.dart';

import 'package:agencies_app/view/screens/events_registration_screen.dart';
import 'package:agencies_app/view/screens/rescue_map_screen.dart';
import 'package:agencies_app/widget/card/event_card.dart';
import 'package:agencies_app/widget/card/manage_card.dart';

import 'package:agencies_app/widget/manage/history.dart';
import 'package:agencies_app/view/animations/transitions_animations/page_transition_animation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomeWidget extends ConsumerStatefulWidget {
  const HomeWidget({
    super.key,
    required this.token,
  });
  final token;

  @override
  ConsumerState<HomeWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeWidget> {
  late String userId;
  String? eventsCount;
  String? rescueCount;
  XFile? _pickedImage;
  String? agencyname;
  bool isInternetConnectionOn = false;
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
      SlideTransitionAnimation(
        direction: AxisDirection.left,
        child: const RescueMapScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isInternetConnectionOn = ref.watch(isInternetConnectionOnProvider);

    bool isLoading = ref.watch(isLoadingHomeScreen);
    isRescueOnGoing = ref.watch(isRescueOperationOnGoingProvider);
    _pickedImage = ref.watch(profileImageProvider);

    ThemeData themeData = Theme.of(context);
    agencyname = ref.watch(agencyNameProvider);
    String grettingMessage = ref.watch(greetingProvider);
    eventsCount = ref.watch(eventsCountProvider.notifier).state[0];
    rescueCount = ref.watch(eventsCountProvider.notifier).state[1];

    List<ManageEventData> listManageEventData = [
      ManageEventData(
        title: "Start",
        desc: "Rescue Operation",
        onPressed: isRescueOnGoing
            ? () {
                navigateToRescueMaps();
              }
            : () async {
                await modalBottomSheet.openModal(
                  context: context,
                  widget: RescueOperation(token: widget.token),
                );
                getAgencyDataFromServer();
              },
        lineColor1: Colors.yellow.shade400,
        lineColor2: Colors.yellow.shade50,
      ),
      ManageEventData(
        title: "Event",
        desc: "Organize Event",
        onPressed: () async {
          await modalBottomSheet.openModal(
            context: context,
            widget: OrganizeEvent(token: widget.token),
          );
          getAgencyDataFromServer();
        },
        lineColor1: Colors.green.shade400,
        lineColor2: Colors.green.shade50,
      ),
      ManageEventData(
        title: "Send Alert",
        desc: "Alert for disaster",
        onPressed: () {
          modalBottomSheet.openModal(
            context: context,
            widget: SendAlert(token: widget.token),
          );
        },
        lineColor1: Colors.red.shade400,
        lineColor2: Colors.red.shade50,
      ),
      ManageEventData(
        title: "Manage History",
        desc: "See all history",
        onPressed: () {
          Navigator.of(context).push(
            SlideTransitionAnimation(
              direction: AxisDirection.left,
              child: History(token: widget.token, agencyName: agencyname!),
            ),
          );
        },
        lineColor1: Colors.blue.shade400,
        lineColor2: Colors.blue.shade50,
      ),
    ];

    return isLoading
        ? const HomeScreenShimmerAnimation()
        : !isInternetConnectionOn
            ? const NoInternet()
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
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
                                          backgroundColor: Colors.transparent,
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
                                  radius: 25.r,
                                  backgroundImage:
                                      FileImage(File(_pickedImage!.path)),
                                ),
                              ),
                            SizedBox(
                              width: 21.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: grettingMessage,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  // color: const Color.fromARGB(255, 220, 217, 217),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                CustomTextWidget(
                                  text: agencyname ?? 'Loading...',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  // color: const Color.fromARGB(255, 220, 217, 217),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: EventRescueCountCard(
                          eventCount: eventsCount ?? '0',
                          rescueCount: rescueCount ?? '0'),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        'Manage',
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        mainAxisExtent: 125.h,
                      ),
                      shrinkWrap: true,
                      itemCount: listManageEventData.length,
                      itemBuilder: (context, index) {
                        final manageEvent = listManageEventData[index];

                        return manageEventCardWidget(
                            index: index, manageEvent: manageEvent);
                      },
                    ),
                    const Spacer(),
                    ZoomIn(
                      delay: const Duration(milliseconds: 900),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        'View',
                        style: GoogleFonts.plusJakartaSans().copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    BounceInDown(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 125.h,
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
                              circleColor: themeData.brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromARGB(206, 255, 255, 255),
                              onTap: () => Navigator.of(context).push(
                                SlideTransitionAnimation(
                                  direction: AxisDirection.left,
                                  child: EventsRegistrationScreen(
                                      agencyName: agencyname!,
                                      token: widget.token),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            EventCard(
                              text1: 'M',
                              text2: 'Rescue',
                              text3: 'Map',
                              color1: const Color.fromARGB(223, 226, 168, 180),
                              color2: const Color.fromARGB(226, 215, 123, 140),
                              circleColor: themeData.brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromARGB(206, 255, 255, 255),
                              onTap: () => Navigator.of(context).push(
                                SlideTransitionAnimation(
                                  direction: AxisDirection.left,
                                  child: const RescueMapScreen(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                  ],
                ),
              );
  }

  Widget manageEventCardWidget({
    required int index,
    required ManageEventData manageEvent,
  }) {
    switch (index) {
      case 0:
        return FadeInLeft(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 200),
          child: ManageCard(
            text1: manageEvent.desc,
            text2: manageEvent.title,
            onPressed: manageEvent.onPressed!,
            lineColor1: manageEvent.lineColor1,
            lineColor2: manageEvent.lineColor2,
          ),
        );
      case 1:
        return FadeInDown(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 200),
          child: ManageCard(
            text1: manageEvent.desc,
            text2: manageEvent.title,
            onPressed: manageEvent.onPressed!,
            lineColor1: manageEvent.lineColor1,
            lineColor2: manageEvent.lineColor2,
          ),
        );
      case 2:
        return FadeInUp(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 200),
          child: ManageCard(
            text1: manageEvent.desc,
            text2: manageEvent.title,
            onPressed: manageEvent.onPressed!,
            lineColor1: manageEvent.lineColor1,
            lineColor2: manageEvent.lineColor2,
          ),
        );
      default:
        return FadeInRight(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 200),
          child: ManageCard(
            text1: manageEvent.desc,
            text2: manageEvent.title,
            onPressed: manageEvent.onPressed!,
            lineColor1: manageEvent.lineColor1,
            lineColor2: manageEvent.lineColor2,
          ),
        );
    }
  }
}
