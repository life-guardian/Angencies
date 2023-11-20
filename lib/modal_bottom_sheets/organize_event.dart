// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/custom_elevated_buttons/manage_elevated_button.dart';
import 'package:agencies_app/custom_functions/datepicker_function.dart';
import 'package:agencies_app/modal_bottom_sheets/textfield_modal.dart';
import 'package:agencies_app/small_widgets/custom_google_maps_dialog.dart';
import 'package:agencies_app/small_widgets/custom_show_dialog.dart';
import 'package:agencies_app/small_widgets/custom_text_widget.dart';
import 'package:agencies_app/small_widgets/text_in_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OrganizeEvent extends StatefulWidget {
  const OrganizeEvent({super.key, required this.token});
  final token;

  @override
  State<OrganizeEvent> createState() => _OrganizeEventState();
}

class _OrganizeEventState extends State<OrganizeEvent> {
  TextEditingController descController = TextEditingController();
  TextEditingController eventNameController = TextEditingController();
  double? lat;
  double? lng;
  String? address;
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    _selectedDate = await customDatePicker(context);
    setState(() {});
  }

  void openMaps() async {
    PickedData pickedLocationData = await customGoogleMapsDialog(
        context: context, titleText: 'Select Location to send alert');
    lat = pickedLocationData.latLong.latitude;
    lng = pickedLocationData.latLong.longitude;
    setState(() {
      address = pickedLocationData.address.toString().trim();
    });
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (ctx) => const OpenStreetMap(),
    // ));
  }

  void _publishEvent() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );

    final jwtToken = widget.token;

    var reqBody = {
      "eventName": eventNameController.text,
      "description": descController.text,
      "latitude": lat,
      "longitude": lng,
      "eventDate": _selectedDate.toString()
    };

    try {
      var response = await http.post(
        Uri.parse(awarenessEventUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Alert Send succefully yess');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alert send successfully!'),
          ),
        );
      } else {
        Navigator.of(context).pop();
        customShowDialog(
            context: context,
            titleText: 'Something went wrong',
            contentText:
                'Please check that you have proper inputed all the fields!');
      }
    } catch (e) {
      Navigator.of(context).pop();
      customShowDialog(
          context: context,
          titleText: 'Error',
          contentText:
              'Something went wrong! Please check your internet connection');
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextWidget(
            text: 'Organize Awareness Event',
            fontSize: 20,
          ),
          const SizedBox(
            height: 31,
          ),
          const CustomTextWidget(
            text: 'LOCATION',
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: openMaps,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  // width: 2,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.near_me_outlined),
                    const SizedBox(
                      width: 11,
                    ),
                    Flexible(
                      child: Text(
                        address ?? 'Select Location',
                        style: GoogleFonts.mulish(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          const CustomTextWidget(
            text: 'EVENT NAME',
          ),
          const SizedBox(
            height: 5,
          ),
          TextfieldModal(
            hintText: 'Enter event name',
            controller: eventNameController,
          ),
          const SizedBox(
            height: 21,
          ),
          const CustomTextWidget(
            text: 'EVENT DESCRIPTION',
          ),
          const SizedBox(
            height: 5,
          ),
          TextfieldModal(
            hintText: 'Enter event description',
            controller: descController,
          ),
          const SizedBox(
            height: 21,
          ),
          const CustomTextWidget(
            text: 'DATE',
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                // width: 2,
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextInTextField(
                    text: (_selectedDate == null)
                        ? 'Pick Date'
                        : formatter.format(_selectedDate!),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: _presentDatePicker,
                    child: const Icon(Icons.calendar_month_outlined),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          ManageElevatedButton(
            buttonText: 'PUBLISH',
            onButtonClick: _publishEvent,
          ),
          const SizedBox(
            height: 31,
          ),
        ],
      ),
    );
  }
}
