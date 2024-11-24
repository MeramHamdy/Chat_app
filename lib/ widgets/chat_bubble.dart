import 'package:chat_app/colors.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 30, bottom: 30, right: 30),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32))),
        child: Text(
          message.message,
          style: TextStyle(color: primary2),
        ),
      ),
    );
  }
}

class ChatBubble2 extends StatelessWidget {
  final Message message;

  ChatBubble2({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 30, bottom: 30, right: 30),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: bubble2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32))),
        child: Text(
          message.message,
          style: TextStyle(color: primary2),
        ),
      ),
    );
  }
}
