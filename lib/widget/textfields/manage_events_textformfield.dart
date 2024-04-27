import 'package:agencies_app/view/theme/textstyle_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageEventsTextFormField extends StatelessWidget {
  const ManageEventsTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.name,
     this.checkValidation,
    this.maxLines,
  });

  final String hintText;
  final TextInputType keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? checkValidation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        validator: checkValidation,
        cursorColor: Theme.of(context).colorScheme.onBackground,
        keyboardType: keyboardType,
        enableSuggestions: true,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          hintText: hintText,
          hintStyle: textStyleFont().copyWith(
            fontSize: 12.sp,
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
