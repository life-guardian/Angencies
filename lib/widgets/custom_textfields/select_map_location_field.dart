import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectMapLocationField extends StatelessWidget {
  const SelectMapLocationField({
    super.key,
    required this.onTap,
    this.address,
    required this.initialText,
  });

  final void Function() onTap;
  final dynamic address;
  final String initialText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              Icon(
                Icons.near_me_outlined,
                color: (address == null)
                    ? Colors.grey.shade700
                    : Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 11,
              ),
              Flexible(
                child: CustomTextWidget(
                  text: address ?? initialText,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: (address == null)
                      ? Colors.grey.shade700
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
