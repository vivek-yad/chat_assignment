import 'dart:convert';

import 'package:chat/core/values/utils.dart';
import 'package:chat/features/chat/data/data_source/firebase/firebase_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/message_model.dart';
import '../../model/user_data.dart';
import '../local/local_storage.dart';

class FirebaseRepoImpl implements FirebaseRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  getChat(String senderId, String receiverId) {
   bool data= senderId.hashCode <= receiverId.hashCode;
    var roomId =( data==true
        ? senderId + '_' + receiverId
        : receiverId + '_' + senderId);
    print("SenderID$senderId,receiverId:$receiverId");
    print("roomId=======================$roomId");
    var document = firebaseInstance
        .collection('chat_rooms')
        .doc(roomId)
        .collection("messages").orderBy('timestamp', descending: true)
        .snapshots();
    print("ddddd$document");
    return document;
  }

  @override
  getUserList(String? uid) async {
    // TODO: implement getUserList
    List<UserData> userDat = [];
    print(
        "emailllllll==== $uid ====${LocalStorage.get(LocalStorage.isLogedIn)}");
    var userData = firebaseInstance.collection('users');
    QuerySnapshot usersQuerySnapshot = await userData
        .where(
          "uid",
          isNotEqualTo: uid,
        )
        .get();
    userDat.clear();
    //var response=jsonEncode(usersQuerySnapshot);
    for (DocumentSnapshot userSnapshot in usersQuerySnapshot.docs) {
      var userList = userSnapshot.data();
      var reEncode = jsonEncode(userList);
      var data = jsonDecode(reEncode);
      var response = UserData.fromJson(data);
      print(
          "$response================================================response");
      userDat.add(response);
    }
    return userDat;
  }

  @override
  loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
      // Do something with the userCredential if needed
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ShowSnackBar.errors("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        ShowSnackBar.errors("Wrong password provided for that user.");

        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  signUpUser(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        final user = userCredential.user!;
        var userData = await firebaseInstance
            .collection('users')
            .doc(user.uid)
            .set({'email': user.email, "userName": name, "uid": user.uid});
        await LocalStorage.remove(user.uid);
        await LocalStorage.save(LocalStorage.isLogedIn, user.email);
        await LocalStorage.save("id", user.uid);
        // print("user====$userData");
        return user;
      }
      // Do something with the userCredential if needed
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  sendMessage(String message, String senderId, String recieverId) async {
    List userList = [senderId, recieverId];
    var roomId = senderId.hashCode <= recieverId.hashCode
        ? senderId + '_' + recieverId
        : recieverId + '_' + senderId;
    print("SenderID$senderId,receiverId:$recieverId");
    var document = await firebaseInstance.collection('chat_rooms').doc(roomId);
    var data = document.set({
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "userList": FieldValue.arrayUnion(userList)
    });

    return document.collection('messages').add({
      'text': message,
      'senderId': senderId,
      'timestamp': DateTime.now().microsecondsSinceEpoch,
    });
  }

  @override
  getUser(String id) async {
    // TODO: implement getUser
    UserData userData;

    print("id=====${LocalStorage.get("id")}kkkkkkkkkkkkkkkkkkkkk$id");
    var data = await firebaseInstance.collection("users").doc(id).get();
    var response = jsonEncode(data.data());
    var userDetail = jsonDecode(response);
    print("$userDetail=========userDetail");
    userData = UserData.fromJson(userDetail);
    return userData;
  }

  @override
  logout(String id) async {
    await _auth.signOut();
    await LocalStorage.remove(LocalStorage.isLogedIn);
    await LocalStorage.remove("id");
  }
}
