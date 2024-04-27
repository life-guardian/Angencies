// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginRegisterTextFormField extends StatefulWidget {
  const LoginRegisterTextFormField({
    super.key,
    this.labelText = '',
    this.hideText = false,
    this.obsecureIcon = false,
    required this.controllerText,
    required this.checkValidation,
    this.textHint = '',
    this.height,
  });

  final String labelText;
  final bool obsecureIcon;
  final double? height;
  final bool hideText;
  final String textHint;
  final String? Function(String?) checkValidation;
  final TextEditingController controllerText;

  @override
  State<LoginRegisterTextFormField> createState() =>
      _LoginRegisterTextFormFieldState(selectedObscure: hideText);
}

class _LoginRegisterTextFormFieldState
    extends State<LoginRegisterTextFormField> {
  _LoginRegisterTextFormFieldState({required this.selectedObscure});
  bool selectedObscure;

  void _obscuretxt() {
    setState(() {
      selectedObscure = selectedObscure ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        obscureText: selectedObscure,
        controller: widget.controllerText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Theme.of(context).colorScheme.onBackground,
        validator: (value) => widget.checkValidation(value),
        selectionControls: DesktopTextSelectionControls(),
        decoration: InputDecoration(
          suffixIcon: widget.obsecureIcon
              ? IconButton(
                  onPressed: _obscuretxt,
                  icon: selectedObscure
                      ? const Icon(
                          Icons.lock_rounded,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.lock_open_rounded,
                          color: Colors.grey,
                        ),
                )
              : null,
          filled: true,
          fillColor: (themeData.brightness == Brightness.light)
              ? const Color.fromARGB(162, 232, 236, 244)
              : Theme.of(context).colorScheme.primary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(156, 158, 158, 158)),
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
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 14.sp),
          hintText: widget.textHint,
        ),
      ),
    );
  }
}
