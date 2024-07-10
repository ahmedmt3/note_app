// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:note_app/core/theme/app_styles.dart';

class AuthCustomButtonWidget extends StatelessWidget {
  const AuthCustomButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 50,
      color: const Color(0xFF329537),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: AppStyles.bodyMediumXL.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
