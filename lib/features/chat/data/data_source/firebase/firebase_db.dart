import '../../model/message_model.dart';

abstract class FirebaseRepo {
  signUpUser(String name,String email,String password);
  loginUser(String email,String password);
  getChat(String senderId,String receiverId);
  getUserList(String uid);

  sendMessage(String message,String senderId, String recieverId);
  getUser(String id);
  logout(String id);
}