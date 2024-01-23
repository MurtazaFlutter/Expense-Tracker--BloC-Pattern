import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final Function(String? value) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return validator(value);
      },
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
      ),
    );
  }
}
