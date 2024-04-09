import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showAwesomeSnackBarAnimation({
  required BuildContext context,
  required String title,
  required String message,
  required ContentType contentType,
}) async {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

Future<void> showAwesomeSnackbarBannerAnimation({
  required BuildContext context,
  required String title,
  required String message,
  required ContentType contentType,
}) async {
  final materialBanner = MaterialBanner(
    elevation: 0,
    backgroundColor: Colors.transparent,
    forceActionsBelow: true,
    dividerColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
      inMaterialBanner: true,
    ),
    actions: const [
      SizedBox.shrink(),
    ],
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);

  return;
}

void clearAwesomeSnackBar({
  required BuildContext context,
}) {
  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(context).clearMaterialBanners();
  });
}
