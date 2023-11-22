// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/small_widgets/custom_elevated_buttons/manage_elevated_button.dart';
import 'package:agencies_app/custom_functions/datepicker_function.dart';
import 'package:agencies_app/small_widgets/custom_textfields/textfield_modal.dart';
import 'package:agencies_app/small_widgets/custom_dialogs/custom_google_maps_dialog.dart';
import 'package:agencies_app/small_widgets/custom_dialogs/custom_show_dialog.dart';
import 'package:agencies_app/small_widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:agencies_app/small_widgets/custom_textfields/text_in_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class SendAlert extends StatefulWidget {
  const SendAlert({super.key, required this.token});
  final token;

  @override
  State<SendAlert> createState() => _SendAlertState();
}

class _SendAlertState extends State<SendAlert> {
  String dropDownValue = 'Select Severty';
  DateTime? _selectedDate;
  final formatter = DateFormat.yMd();
  TextEditingController alertNameController = TextEditingController();
  double? lat;
  double? lng;
  String? address;
  bool buttonEnabled = true;
  Widget activeButtonText = Text(
    'SEND ALERT',
    style: GoogleFonts.mulish(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
  );

  @override
  void dispose() {
    super.dispose();
    alertNameController.dispose();
  }

  void _presentDatePicker(BuildContext context) async {
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

  Future<void> _sendAlert() async {
    setState(() {
      buttonEnabled = false;
      activeButtonText = const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        ),
      );
    });

    final jwtToken = widget.token;
    var serverMessage;

    var reqBody = {
      "locationCoordinates": [lng, lat],
      "alertName": alertNameController.text.toString(),
      "alertSeverity": dropDownValue.toString().toLowerCase(),
      "alertForDate": _selectedDate.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(sendAlertUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(reqBody),
      );

      // var jsonResponse = jsonDecode(response.body);
      var jsonResponse = jsonDecode(response.body);

      serverMessage = jsonResponse['message'];

      if (response.statusCode == 200) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(serverMessage.toString()),
          ),
        );
      } else {
        setState(() {
          activeButtonText = Text(
            'SEND ALERT',
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          );
        });
        customShowDialog(
            context: context,
            titleText: 'Something went wrong',
            contentText: serverMessage.toString());
      }
    } catch (e) {
      setState(() {
        activeButtonText = Text(
          'SEND ALERT',
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        );
      });
      customShowDialog(
          context: context,
          titleText: 'Error',
          contentText: serverMessage.toString());
      print("Exception: $e");
    }
    buttonEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    List<String> values = ['High', 'Medium', 'Low'];
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 12,
        left: 12,
        right: 12,
      ),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget(
              text: 'Send Emergency Alert',
              fontSize: 20,
            ),
            const SizedBox(
              height: 31,
            ),
            const CustomTextWidget(
              text: 'ALERTING AREA',
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
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.near_me_outlined,
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Flexible(
                        child: Text(
                          address ??
                              'Area will be in radius of 2km from the locating point',
                          style: GoogleFonts.mulish(
                            fontSize: 16,
                          ),
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
              text: 'ALERT NAME',
            ),
            const SizedBox(
              height: 5,
            ),
            TextfieldModal(
              hintText: 'Fire and Safety Drill',
              controller: alertNameController,
            ),
            const SizedBox(
              height: 21,
            ),
            const CustomTextWidget(
              text: 'ALERT SEVERITY',
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
                    TextInTextField(text: dropDownValue),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        underline: null,
                        iconSize: 35,
                        items: values
                            .map(
                              (value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ),
                  ],
                ),
              ),
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
                      onTap: () {
                        _presentDatePicker(context);
                      },
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
              buttonItem: activeButtonText,
              onButtonClick: _sendAlert,
              enabled: buttonEnabled,
            ),
            const SizedBox(
              height: 31,
            ),
          ],
        ),
      ),
    );
  }
}
