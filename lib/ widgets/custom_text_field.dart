import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  String? hintText;
  Function(String)? onChanged;
  bool? obscureText;

  CustomFormTextField(
      {this.hintText, this.onChanged, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: primary2),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: primary2)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: logo)),
          border: OutlineInputBorder(borderSide: BorderSide(color: primary2))),
    );
  }
}
