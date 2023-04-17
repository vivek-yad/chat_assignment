import 'package:cloud_firestore/cloud_firestore.dart';

// class MessageModel {
//   MessageModel({
//     required this.text,
//     required this.senderId,
//     required this.timestamp,
//   });
//
//   String text;
//   String senderId;
//   num timestamp;
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//     text: json["text"],
//     senderId: json["senderId"],
//     timestamp: json["'timestamp'"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "text": text,
//     "senderId": senderId,
//     "'timestamp'": timestamp,
//   };
// }

class MessageModel {
  String text;
  String senderId;
  num timestamp;

  MessageModel({
  required this.text,
  required this.senderId,
  required this.timestamp,
  });

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    return MessageModel(
      timestamp: snapshot.get("timestamp"),
      text: snapshot.get('text'),
      senderId: snapshot.get('senderId'),
    );
  }
}