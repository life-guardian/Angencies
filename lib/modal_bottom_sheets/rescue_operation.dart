import 'package:agencies_app/custom_elevated_buttons/manage_elevated_button.dart';
import 'package:agencies_app/modal_bottom_sheets/textfield_modal.dart';
import 'package:agencies_app/small_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RescueOperation extends StatefulWidget {
  const RescueOperation({super.key});

  @override
  State<RescueOperation> createState() => _RescueOperationState();
}

class _RescueOperationState extends State<RescueOperation> {
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
            text: 'Start Rescue Operation',
            fontSize: 20,
          ),
          const SizedBox(
            height: 31,
          ),
          const CustomTextWidget(
            text: 'OPERATION LOCATION',
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
                      'Give precise location access',
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
            text: 'RESCUE OPERATION NAME',
          ),
          const SizedBox(
            height: 5,
          ),
          const TextfieldModal(
            hintText: 'Enter Rescue operation name',
          ),
          const SizedBox(
            height: 21,
          ),
          const CustomTextWidget(
            text: 'RESCUE TEAM SIZE',
          ),
          const SizedBox(
            height: 5,
          ),
          const TextfieldModal(
            keyboardType: TextInputType.number,
            hintText: 'Enter rescue team size',
          ),
          const SizedBox(
            height: 21,
          ),
          const CustomTextWidget(
            text: 'DESCRIPTION',
          ),
          const SizedBox(
            height: 5,
          ),
          const TextfieldModal(
            hintText: 'Enter description',
          ),
          const SizedBox(
            height: 21,
          ),
          const SizedBox(
            height: 31,
          ),
          ManageElevatedButton(
            buttonText: 'START OPERATION',
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
