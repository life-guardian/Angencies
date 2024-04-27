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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    super.key,
    required this.logoutUser,
    required this.ref,
  });
  final void Function() logoutUser;
  final WidgetRef ref;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
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
      child: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: "Settings",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
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
                          radius: 50.r,
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
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextWidget(
                        text: userName ?? "",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Card(
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      settingsTile(
                        text: 'Update Profile Photo',
                        leadingIcon: Icons.camera_alt_outlined,
                        ontap: () async {
                          _pickedImage = await pickImageFromGallery();
                          if (_pickedImage != null) {
                            widget.ref
                                .read(profileImageProvider.notifier)
                                .state = _pickedImage;

                            setState(() {});
                          }
                        },
                      ),
                      const HorizontalDivider(),
                      settingsTile(
                        text: 'Learn More!',
                        leadingIcon: Icons.help_center_rounded,
                        ontap: () => launchWebUrl(),
                      ),
                      const HorizontalDivider(),
                      settingsTile(
                        text: 'Change Password',
                        leadingIcon: Icons.lock_clock_rounded,
                        ontap: () {
                          logoutDialog(
                              context: context,
                              titleText: 'Change Password?',
                              onTap: () {},
                              actionText2: 'Yes',
                              contentText:
                                  'Do you really want to reset your password');
                        },
                      ),
                      const HorizontalDivider(),
                      settingsTile(
                        text: 'Share App',
                        leadingIcon: Icons.share_outlined,
                        ontap: () async {
                          String url =
                              "https://lifeguardian-agencies.netlify.app/";
                          await Share.share(
                              "Lifeguardian Agencies app for agencies \n\n$url");
                        },
                      ),
                      const HorizontalDivider(),
                      settingsTile(
                        text: 'Log Out',
                        leadingIcon: Icons.logout_rounded,
                        ontap: () {
                          logoutDialog(
                            context: context,
                            titleText: 'Log out?',
                            contentText:
                                'You will be logged out from your account!',
                            actionText2: 'Log Out',
                            onTap: widget.logoutUser,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLifeGuardianTag(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsTile({
    required String text,
    required IconData leadingIcon,
    required Function() ontap,
  }) {
    return InkWell(
      onTap: () => ontap(),
      child: Padding(
        padding: EdgeInsets.all(4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              leadingIcon,
              size: 20.h,
            ),
            SizedBox(
              width: 21.w,
            ),
            CustomTextWidget(
              text: text,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchWebUrl() async {
    final Uri url = Uri.parse(
        'https://tejxcoder01.blogspot.com/2024/04/what-is-life-guardian-rescue-system.html');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
