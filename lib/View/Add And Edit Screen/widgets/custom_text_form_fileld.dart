import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String labelText;
  final String? prefixText;
  final String? suffixText;

  const CustomTextFormField(
      {this.prefixText,
      this.suffixText,
      super.key,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.prefixIcon,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        suffixText: suffixText,
        prefixText: prefixText,
        prefixIcon: Icon(prefixIcon),
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
