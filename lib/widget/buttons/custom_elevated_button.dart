// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ManageElevatedButton extends StatelessWidget {
  const ManageElevatedButton({
    super.key,
    required this.childWidget,
    this.color = const Color(0xff2F80ED),
    required this.onPressed,
    this.isButtonEnabled = true,
  });
  final Widget childWidget;
  final void Function() onPressed;
  final Color color;
  final bool isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 40),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: childWidget,
      ),
    );
  }
}
