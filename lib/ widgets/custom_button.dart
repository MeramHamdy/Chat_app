import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String txt;
  VoidCallback? onTap;

  CustomButton({required this.txt, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(child: Text(txt)),
        decoration: BoxDecoration(
            color: primary2, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
