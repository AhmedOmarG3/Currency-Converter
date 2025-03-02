import 'package:flutter/material.dart';

class CustomTextFieldForAuth extends StatelessWidget {
  const CustomTextFieldForAuth({
    super.key,
    required this.hintTitle,
    this.onchanged,
    this.obscureText = false,
    this.controller,
    this.KeyboardType, // default to false for easier control
  });
  final TextInputType? KeyboardType;
  final TextEditingController? controller;
  final String hintTitle;
  final ValueChanged<String>? onchanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: KeyboardType,
      controller: controller,
      obscureText: obscureText, // Use the passed value for obscureText
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hintTitle,
        hintStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.7),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
