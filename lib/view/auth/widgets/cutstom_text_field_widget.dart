// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:note_app/core/theme/app_styles.dart';

class CutstomTextFieldWidget extends StatelessWidget {
  const CutstomTextFieldWidget({
    Key? key,
    required this.name,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  }) : super(key: key);
  final String name;
  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppStyles.bodyMediumL,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
