import 'package:flutter/material.dart';

class ModalBottomSheet {
  void openModal(
      {required BuildContext context,
      required Widget widget,
      isDismissible = false}) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (ctx) => widget,
    );
  }
}
