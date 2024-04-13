// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:agencies_app/view/animations/snackbar_animations/awesome_snackbar_animation.dart';
import 'package:agencies_app/view_model/functions/validate_textfield.dart';
import 'package:agencies_app/helper/classes/exact_location.dart';
import 'package:agencies_app/widget/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:agencies_app/widget/textfields/select_map_location_field.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:agencies_app/widget/buttons/custom_elevated_button.dart';
import 'package:agencies_app/view_model/functions/datepicker_function.dart';
import 'package:agencies_app/widget/textfields/manage_events_textformfield.dart';
import 'package:agencies_app/widget/dialogs/osm_map_dialog.dart';
import 'package:agencies_app/widget/dialogs/custom_show_dialog.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
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
  ExactLocation exactLocation = ExactLocation();
  double? lat;
  double? lng;

  String? address;
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;

  bool buttonEnabled = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget activeButtonText = Text(
    'PUBLISH EVENT',
    style: GoogleFonts.mulish(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
  );

  @override
  void dispose() {
    super.dispose();
    descController.dispose();
    eventNameController.dispose();
  }

  void _presentDatePicker() async {
    _selectedDate = await customDatePicker(context);

    setState(() {});
  }

  void setButtonText() {
    activeButtonText = Text(
      'PUBLISH EVENT',
      style: GoogleFonts.mulish(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    );
  }

  void openMaps() async {
    PickedData pickedLocationData = await osmMapDialog(context: context);
    lat = pickedLocationData.latLong.latitude;
    lng = pickedLocationData.latLong.longitude;
    try {
      address = await exactLocation.locality(lat: lat!, lng: lng!);
    } catch (e) {
      address = pickedLocationData
          .addressName; // if failed to fetch address then assign value from osm address
      debugPrint('Failed to fetch address: ${e.toString()}');
    }
    setState(() {});
  }

  void _submitForm({required BuildContext context}) {
    if (_formKey.currentState!.validate()) {
      if (address == null || _selectedDate == null) {
        customShowDialog(
            context: context,
            titleText: 'Something went wrong',
            contentText:
                'Please check that you have proper inputed event location and picked date');
      } else {
        _publishEvent(context: context);
      }
    }
  }

  void _publishEvent({required BuildContext context}) async {
    setState(() {
      buttonEnabled = false;
      activeButtonText = const CustomCircularProgressIndicator();
    });

    final jwtToken = widget.token;
    String serverMessage;

    var reqBody = {
      "eventName": eventNameController.text,
      "description": descController.text,
      "latitude": lat,
      "longitude": lng,
      "eventDate": _selectedDate.toString()
    };

    try {
      String baseUrl = dotenv.get("BASE_URL");

      var response = await http.post(
        Uri.parse('$baseUrl/api/event/agency/add'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);

      serverMessage = jsonResponse['message'];

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        showAwesomeSnackBarAnimation(
          context: context,
          title: "Awareness Event!!",
          message: serverMessage,
          contentType: ContentType.warning,
        );
      } else {
        setState(() {
          setButtonText();
        });

        customShowDialog(
            context: context,
            titleText: 'Something went wrong',
            contentText: serverMessage.toString());
      }
    } catch (e) {
      setState(() {
        setButtonText();
      });

      debugPrint("Exception occured: ${e.toString()}");
    }

    buttonEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 12,
        left: 12,
        right: 12,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              // ontap , address
              SelectMapLocationField(
                onTap: openMaps,
                address: address,
                initialText: 'Select Location',
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
              ManageEventsTextFormField(
                hintText: 'Enter event name',
                controller: eventNameController,
                checkValidation: (value) =>
                    validateTextField(value, 'Event Name'),
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
              ManageEventsTextFormField(
                hintText: 'Enter event description',
                controller: descController,
                checkValidation: (value) =>
                    validateTextField(value, 'Description'),
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
              GestureDetector(
                onTap: _presentDatePicker,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: _selectedDate == null
                              ? 'Pick Date'
                              : formatter.format(_selectedDate!),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: _selectedDate == null
                              ? Colors.grey.shade700
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        const Icon(Icons.calendar_month_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              ManageElevatedButton(
                childWidget: activeButtonText,
                onPressed: () => _submitForm(context: context),
                isButtonEnabled: buttonEnabled,
              ),
              const SizedBox(
                height: 31,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
