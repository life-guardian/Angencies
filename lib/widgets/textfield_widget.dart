import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.controllerText,
    required this.checkValidation,
  });

  final String labelText;
  final String? Function(String?) checkValidation;
  final TextEditingController controllerText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => checkValidation(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(162, 232, 236, 244),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(156, 158, 158, 158)),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: labelText,
      ),
    );
  }
}
