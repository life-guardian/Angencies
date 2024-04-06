// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:agencies_app/providers/agencydetails_providers.dart';
import 'package:agencies_app/widgets/custom_dialogs/custom_logout_dialog.dart';
import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:agencies_app/widgets/dividers/horizontal_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccountDetails extends StatefulWidget {
  const UserAccountDetails({
    super.key,
    required this.logoutUser,
    required this.ref,
  });
  final void Function() logoutUser;
  final WidgetRef ref;

  @override
  State<UserAccountDetails> createState() => _UserAccountDetailsState();
}

class _UserAccountDetailsState extends State<UserAccountDetails> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  late SharedPreferences prefs;

  Future<XFile?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    return image;
  }

  @override
  Widget build(BuildContext context) {
    String? userName = widget.ref.watch(agencyNameProvider);
    _pickedImage = widget.ref.watch(profileImageProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: "Settings",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(
              height: 21,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: _pickedImage != null
                          ? FileImage(File(_pickedImage!.path))
                          : null,
                    ),
                    const SizedBox(
                      height: 31,
                    ),
                    CustomTextWidget(
                      text: userName ?? "",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        _pickedImage = await pickImageFromGallery();
                        if (_pickedImage != null) {
                          widget.ref.read(profileImageProvider.notifier).state =
                              _pickedImage;

                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.camera_alt_outlined),
                            const SizedBox(
                              width: 21,
                            ),
                            Text(
                              'Update Profile Photo',
                              style: GoogleFonts.mulish(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                    const HorizontalDivider(),
                    InkWell(
                      onTap: () {
                        // navigate to help page
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.help_center_rounded),
                            const SizedBox(
                              width: 21,
                            ),
                            Text(
                              'Learn More!',
                              style: GoogleFonts.mulish(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                    const HorizontalDivider(),
                    InkWell(
                      onTap: () {
                        customLogoutDialog(
                            context: context,
                            titleText: 'Forgot Password?',
                            onTap: () {},
                            actionText2: 'Yes',
                            contentText:
                                'Do you really want to reset your password');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.lock_clock_rounded),
                            const SizedBox(
                              width: 21,
                            ),
                            Text(
                              'Forgot Password?',
                              style: GoogleFonts.mulish(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                    const HorizontalDivider(thickness: 0.5),
                    InkWell(
                      onTap: () {
                        customLogoutDialog(
                          context: context,
                          titleText: 'Log out of your account?',
                          contentText:
                              'You will logged out and navigated to login dashboard',
                          actionText2: 'Log Out',
                          onTap: widget.logoutUser,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.logout_rounded),
                            const SizedBox(
                              width: 21,
                            ),
                            Text(
                              'Logout',
                              style: GoogleFonts.mulish(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jai ',
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                Text(
                  'Hind !',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
