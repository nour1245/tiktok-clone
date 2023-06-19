import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/widgets/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final IconData icon;

  const TextInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isObscure,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: bordercolor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: bordercolor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
