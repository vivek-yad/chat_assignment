import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../data/model/message_model.dart';
import '../../data/model/user_data.dart';
import '../controller/user_list_controller.dart';

class ChatScreen extends StatefulWidget {
  final UserData currentUser;
  final UserData otherUser;

  const ChatScreen(
      {Key? key, required this.currentUser, required this.otherUser})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final UserListAndChatController userListAndChatController =
  Get.find<UserListAndChatController>();

  @override
  Widget build(BuildContext context) {
    print("useerrrrrrr========================${widget.currentUser.uid}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUser?.userName??''),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: userListAndChatController.repositoryImpl.getChatList(
                    widget.currentUser?.uid??'', widget.otherUser?.uid??''),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // final messages = snapshot.data!.docs.map((doc) =>print(doc)
                  //
                  // ).toList();
                  List<MessageModel> messages = snapshot.data!.docs.map((DocumentSnapshot document) {
                    return MessageModel.fromSnapshot(document);
                  }).toList();
                  //print("hdgfdhgfhdgsgfd${messages[0].text}");
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(message.timestamp.toInt());
                      String formattedDateTime = DateFormat('MMM d, y H:mm:ss').format(dateTime);
                      return ListTile(
                        title: Text(message.text),
                        subtitle: Text(formattedDateTime
                        ),
                        trailing: Text(message.senderId == widget.currentUser?.uid
                            ? 'You'
                            : widget.otherUser?.userName??''),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: userListAndChatController.messageController
                          .value,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final message = userListAndChatController.messageController
                          .value.text.trim();
                      if (message.isNotEmpty) {
                        await userListAndChatController.sendMessage(
                            message, widget.currentUser?.uid??'',
                            widget.otherUser?.uid??'');
                        userListAndChatController.messageController.value.clear();
                      }
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}