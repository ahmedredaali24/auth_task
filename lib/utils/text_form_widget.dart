import 'package:flutter/material.dart';

import 'app_color.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;

  const AuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.maxLines ,
      this.maxLength });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppColors.kLightWhite2,
        filled: true,
        hintStyle: const TextStyle(color: Colors.grey),
        errorMaxLines: 3,
      ),
    );
  }
}
