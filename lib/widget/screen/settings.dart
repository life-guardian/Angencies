// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:agencies_app/view_model/providers/agencydetails_providers.dart';
import 'package:agencies_app/widget/dialogs/logout_dialog.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:agencies_app/widget/text/custom_lifeguardian_tag.dart';
import 'package:agencies_app/widget/dividers/horizontal_divider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({
    super.key,
    required this.logoutUser,
    required this.ref,
  });
  final void Function() logoutUser;
  final WidgetRef ref;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        child: FadeInUp(
          duration: const Duration(milliseconds: 500),
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
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FadeInUp(
                                  duration: const Duration(milliseconds: 500),
                                  child: AlertDialog(
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
                            radius: 100,
                            backgroundImage: _pickedImage != null
                                ? Image(
                                    image: FileImage(
                                      File(
                                        _pickedImage!.path,
                                      ),
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ).image
                                : null,
                          ),
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
              ),
              const SizedBox(
                height: 31,
              ),
              Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            _pickedImage = await pickImageFromGallery();
                            if (_pickedImage != null) {
                              widget.ref
                                  .read(profileImageProvider.notifier)
                                  .state = _pickedImage;

                              setState(() {});
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.camera_alt_outlined),
                                SizedBox(
                                  width: 21,
                                ),
                                CustomTextWidget(
                                  text: 'Update Profile Photo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ),
                        ),
                        const HorizontalDivider(),
                        InkWell(
                          onTap: () {
                            // navigate to help page
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.help_center_rounded),
                                SizedBox(
                                  width: 21,
                                ),
                                CustomTextWidget(
                                  text: 'Learn More!',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ),
                        ),
                        const HorizontalDivider(),
                        InkWell(
                          onTap: () {
                            logoutDialog(
                                context: context,
                                titleText: 'Change Password?',
                                onTap: () {},
                                actionText2: 'Yes',
                                contentText:
                                    'Do you really want to reset your password');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.lock_clock_rounded),
                                SizedBox(
                                  width: 21,
                                ),
                                CustomTextWidget(
                                  text: 'Change Password',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ),
                        ),
                        const HorizontalDivider(),
                        InkWell(
                          onTap: () async {
                            String url =
                                "https://lifeguardian-agencies.netlify.app/";
                            await Share.share(
                                "Lifeguardian Agencies app for agencies \n\n$url");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.share_outlined),
                                SizedBox(
                                  width: 21,
                                ),
                                CustomTextWidget(
                                  text: 'Share App',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ),
                        ),
                        const HorizontalDivider(),
                        InkWell(
                          onTap: () {
                            logoutDialog(
                              context: context,
                              titleText: 'Log out?',
                              contentText:
                                  'You will be logged out from your account!',
                              actionText2: 'Log Out',
                              onTap: widget.logoutUser,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.logout_rounded),
                                SizedBox(
                                  width: 21,
                                ),
                                CustomTextWidget(
                                  text: 'Logout',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLifeGuardianTag(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
