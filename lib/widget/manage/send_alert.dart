// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:agencies_app/view/animations/snackbar_animations/awesome_snackbar_animation.dart';
import 'package:agencies_app/helper/functions/validate_textfield.dart';
import 'package:agencies_app/helper/classes/exact_location.dart';
import 'package:agencies_app/widget/buttons/custom_elevated_button.dart';
import 'package:agencies_app/helper/functions/datepicker_function.dart';
import 'package:agencies_app/widget/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:agencies_app/widget/textfields/select_map_location_field.dart';
import 'package:agencies_app/widget/textfields/manage_events_textformfield.dart';
import 'package:agencies_app/widget/dialogs/osm_map_dialog.dart';
import 'package:agencies_app/widget/dialogs/custom_show_dialog.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String? dropDownValue;
  bool isPickeddropDownValue = false;
  DateTime? _selectedDate;
  final formatter = DateFormat.yMd();
  TextEditingController alertNameController = TextEditingController();
  TextEditingController alertDescriptionController = TextEditingController();
  double? lat;
  double? lng;
  String? address;
  bool buttonEnabled = true;
  bool dateSelected = false;
  ExactLocation exactLocation = ExactLocation();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Widget activeButtonText;

  @override
  void initState() {
    super.initState();
    setButtonText();
  }

  @override
  void dispose() {
    super.dispose();
    alertNameController.dispose();
    alertDescriptionController.dispose();
  }

  void _presentDatePicker(BuildContext context) async {
    _selectedDate = await customDatePicker(context);
    if (!(_selectedDate == null)) {
      dateSelected = true;
    }
    setState(() {});
  }

  void setButtonText() {
    activeButtonText = Text(
      'SEND ALERT',
      style: GoogleFonts.mulish(
          fontWeight: FontWeight.bold, fontSize: 12.sp, color: Colors.white),
    );
  }

  void openMaps() async {
    PickedData pickedLocationData = await osmMapDialog(
        context: context, titleText: 'Select Location to send alert');
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (address == null || _selectedDate == null || !isPickeddropDownValue) {
        customShowDialog(
            context: context,
            titleText: 'Something went wrong',
            contentText:
                'Please check that you have proper inputed alerting area, alert severity and date.');
      } else {
        _sendAlert();
      }
    }
  }

  Future<void> _sendAlert() async {
    setState(() {
      buttonEnabled = false;
      activeButtonText = const CustomCircularProgressIndicator();
    });

    final jwtToken = widget.token;
    var serverMessage;

    var reqBody = {
      "locationCoordinates": [lng, lat],
      "alertName": alertNameController.text.trim(),
      "alertSeverity": dropDownValue.toString().toLowerCase(),
      "alertForDate": _selectedDate.toString(),
      "alertDescription": alertDescriptionController.text.trim().isEmpty
          ? null
          : alertDescriptionController.text.trim(),
    };

    try {
      String baseUrl = dotenv.get("BASE_URL");

      var response = await http.post(
        Uri.parse('$baseUrl/api/alert/agency/sendalert'),
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

        showAwesomeSnackBarAnimation(
          context: context,
          title: "Alert for disaster!!",
          message: serverMessage,
          contentType: ContentType.failure,
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
    List<String> values = ['High', 'Medium', 'Low'];
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 12.h,
        left: 12.w,
        right: 12.w,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Send Emergency Alert',
                fontSize: 18.sp,
              ),
              SizedBox(
                height: 31.h,
              ),
              const CustomTextWidget(
                text: 'ALERTING AREA',
              ),
              SizedBox(
                height: 5.h,
              ),
              SelectMapLocationField(
                onTap: openMaps,
                address: address,
                initialText:
                    'area will be in radius of 2 km from the location point.',
              ),
              SizedBox(
                height: 21.h,
              ),
              const CustomTextWidget(
                text: 'ALERT NAME',
              ),
              SizedBox(
                height: 5.h,
              ),
              ManageEventsTextFormField(
                hintText: 'Eg: flood alert',
                controller: alertNameController,
                checkValidation: (value) =>
                    validateTextField(value, 'alert name'),
              ),
              SizedBox(
                height: 21.h,
              ),
              const CustomTextWidget(
                text: 'DESCRIPTION',
              ),
              SizedBox(
                height: 5.h,
              ),
              ManageEventsTextFormField(
                hintText: 'alert description',
                maxLines: 4,
                controller: alertDescriptionController,
                // checkValidation: (value) =>
                //     validateTextField(value, 'alert description'),
              ),
              SizedBox(
                height: 21.h,
              ),
              const CustomTextWidget(
                text: 'ALERT SEVERITY',
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 70.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: dropDownValue == null
                            ? 'select severty'
                            : dropDownValue!,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: dropDownValue == null
                            ? Colors.grey.shade500
                            : Theme.of(context).colorScheme.onBackground,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          underline: null,
                          iconSize: 40.h,
                          items: values
                              .map(
                                (value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              isPickeddropDownValue = true;

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
              SizedBox(
                height: 21.h,
              ),
              const CustomTextWidget(
                text: 'DATE',
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: () {
                  _presentDatePicker(context);
                },
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: _selectedDate == null
                              ? 'pick date'
                              : formatter.format(_selectedDate!),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: _selectedDate == null
                              ? Colors.grey.shade500
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                        SizedBox(
                          width: 11.w,
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 31.h,
              ),
              ManageElevatedButton(
                childWidget: activeButtonText,
                onPressed: _submitForm,
                isButtonEnabled: buttonEnabled,
              ),
              SizedBox(
                height: 31.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
