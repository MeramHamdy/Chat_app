import 'package:chat_app/%20widgets/chat_bubble.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  //static to access by class not obj from class
  static String id = "ChatPage";

  //messagesCollections in constants.dart
  CollectionReference messages =
      FirebaseFirestore.instance.collection(messagesCollections);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    //QuerySnapshot group of doc i need it
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson((snapshot.data!.docs[i])));
          }
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imgLogo,
                      height: 60,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(color: primary2),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? ChatBubble(
                                  message: messagesList[index],
                                )
                              : ChatBubble2(message: messagesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          KMessage: data,
                          KCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(
                            // _controller.position.maxScrollExtent,
                            0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                          //sufix in end  //prfix in start
                          suffixIcon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          hintText: 'Send Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: kPrimaryColor))),
                    ),
                  )
                ],
              ));
        } else {
          return Text('Loading....');
        }
      },
    );
  }
}
