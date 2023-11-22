import 'package:agencies_app/small_widgets/custom_dialogs/custom_google_maps_dialog.dart';
import 'package:agencies_app/small_widgets/custom_elevated_buttons/manage_elevated_button.dart';
import 'package:agencies_app/small_widgets/custom_textfields/textfield_modal.dart';
import 'package:agencies_app/small_widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class RescueOperation extends StatefulWidget {
  const RescueOperation({super.key});

  @override
  State<RescueOperation> createState() => _RescueOperationState();
}

class _RescueOperationState extends State<RescueOperation> {
  TextEditingController operationNameController = TextEditingController();
  TextEditingController teamSizeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  double? lat;
  double? lng;
  String? address;
  bool buttonEnabled = true;
  Widget activeButtonText = Text(
    'START OPERATION',
    style: GoogleFonts.mulish(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
  );

  void openMaps() async {
    PickedData pickedLocationData = await customGoogleMapsDialog(
        context: context, titleText: 'Select Location to send alert');
    lat = pickedLocationData.latLong.latitude;
    lng = pickedLocationData.latLong.longitude;
    setState(() {
      address = pickedLocationData.address.toString().trim();
    });
  }

  void startOperation() {
    // code to send data to server setState(() {
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
    // make sure to buttonEnabled=true
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
                          address ?? 'Give precise location access',
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
              text: 'RESCUE OPERATION NAME',
            ),
            const SizedBox(
              height: 5,
            ),
            TextfieldModal(
              hintText: 'Enter Rescue operation name',
              controller: operationNameController,
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
            TextfieldModal(
              keyboardType: TextInputType.number,
              hintText: 'Enter rescue team size',
              controller: teamSizeController,
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
            TextfieldModal(
              hintText: 'Enter description',
              controller: descController,
            ),
            const SizedBox(
              height: 21,
            ),
            const SizedBox(
              height: 31,
            ),
            ManageElevatedButton(
              buttonItem: activeButtonText,
              onButtonClick: startOperation,
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
