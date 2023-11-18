import 'package:agencies_app/custom_elevated_buttons/manage_elevated_button.dart';
import 'package:agencies_app/custom_functions/datepicker_function.dart';
import 'package:agencies_app/modal_bottom_sheets/textfield_modal.dart';
import 'package:agencies_app/small_widgets/custom_text_widget.dart';
import 'package:agencies_app/small_widgets/text_in_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrganizeEvent extends StatefulWidget {
  const OrganizeEvent({super.key});

  @override
  State<OrganizeEvent> createState() => _OrganizeEventState();
}

class _OrganizeEventState extends State<OrganizeEvent> {
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    _selectedDate = await customDatePicker(context);
    setState(() {});
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.near_me_outlined),
                  const SizedBox(
                    width: 11,
                  ),
                  Flexible(
                    child: Text(
                      'Select Location',
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
            text: 'EVENT NAME',
          ),
          const SizedBox(
            height: 5,
          ),
          const TextfieldModal(
            hintText: 'Enter event name',
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
          const TextfieldModal(
            hintText: 'Enter event description',
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
