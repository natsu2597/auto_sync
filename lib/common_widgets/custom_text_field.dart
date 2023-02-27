import 'package:auto_sync/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final VoidCallbackAction? onTap;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  const CustomTextField({
    this.onTap,
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: GlobalVariables.greyBackgroundCOlor,
        hintText: hintText,
        border: const  OutlineInputBorder(
          borderSide:  BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
