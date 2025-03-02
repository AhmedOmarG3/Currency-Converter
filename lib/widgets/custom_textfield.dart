import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onSubmitted,
    this.controller,
  });
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amount',
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        hintText: 'Enter amount',
        filled: true,
        focusColor: const Color.fromARGB(255, 240, 237, 237),
        fillColor: const Color.fromARGB(255, 207, 207, 207),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
