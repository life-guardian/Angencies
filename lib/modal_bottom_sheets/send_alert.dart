import 'package:agencies_app/custom_elevated_buttons/manage_elevated_button.dart';
import 'package:agencies_app/modal_bottom_sheets/textfield_modal.dart';
import 'package:agencies_app/small_widgets/custom_text_widget.dart';
import 'package:agencies_app/small_widgets/text_in_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendAlert extends StatefulWidget {
  const SendAlert({super.key});

  @override
  State<SendAlert> createState() => _SendAlertState();
}

class _SendAlertState extends State<SendAlert> {
  @override
  Widget build(BuildContext context) {
    TextEditingController alertNameController = TextEditingController();
    String? _selectedValue;
    List<String> values = ['High', 'Medium', 'Low'];
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
                children: [
                  const Icon(Icons.near_me_outlined),
                  const SizedBox(
                    width: 11,
                  ),
                  Flexible(
                    child: Text(
                      'Area will be in radius of 2km from the locating point',
                      style: GoogleFonts.mulish(fontSize: 16),
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
            text: 'ALERT NAME',
          ),
          const SizedBox(
            height: 5,
          ),
          const TextfieldModal(
            hintText: 'Fire and Safety Drill',
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
                  const TextInTextField(text: 'Select Severity'),
                  DropdownButton<String>(
                    iconSize: 35,
                    // isExpanded: true,
                    value: _selectedValue,
                    items: values
                        .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.arrow_drop_down_rounded),
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
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(
                    width: 11,
                  ),
                  Flexible(
                    child: Text(
                      'Today',
                      style: GoogleFonts.mulish(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          ManageElevatedButton(
            buttonText: 'SEND ALERT',
            onButtonClick: () {},
          ),
          const SizedBox(
            height: 31,
          ),
        ],
      ),
    );
  }
}
