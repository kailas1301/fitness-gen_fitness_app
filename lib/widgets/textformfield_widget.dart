import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      this.labeltext,
      required this.errorText,
      required this.keyboardType,
      this.optionalerror,
      this.counterText,
      this.hintText,
      this.suffixText,
      this.prefixText});

  final TextEditingController controller;
  final String? labeltext;
  final String errorText;
  final TextInputType keyboardType;
  final String? optionalerror;
  final String? counterText;
  final String? hintText;
  final String? suffixText;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 210, 196, 234),
                  style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 229, 225, 235),
                  style: BorderStyle.solid)),
          prefixText: prefixText,
          suffixText: suffixText,
          suffixStyle:
              GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
          hintText: hintText,
          counterText: counterText,
          labelText: labeltext,
          labelStyle:
              GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
          contentPadding: const EdgeInsets.all(15)),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
