import 'package:flutter/material.dart';

TextFormField customTextField({
  required TextEditingController controller,
  String? hint,
  IconData? suffixIcon,
  bool expands = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller, //Passed Controller
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    expands: expands,
    minLines: null,
    maxLines: expands==true? null : 1,
    decoration: InputDecoration(
      hintText: hint, //Passed hint text
      suffixIcon: Icon(suffixIcon),
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 20),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
  // END OF THE FUNCTION