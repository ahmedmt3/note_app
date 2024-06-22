// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.hint,
    this.validator,
    this.expands = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final bool expands;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, //Passed Controller
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlignVertical: TextAlignVertical.top,
      expands: expands,
      minLines: null,
      maxLines: expands == true ? null : 1,
      autofocus: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.grey),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.grey),
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
