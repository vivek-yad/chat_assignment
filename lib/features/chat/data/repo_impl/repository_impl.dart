import 'package:chat/features/chat/domain/repo/repository.dart';

import '../data_source/firebase/firebase_db_impl.dart';

class RepositoryImpl implements Repository {
  FirebaseRepoImpl firebaseRepoImpl;

  RepositoryImpl({required this.firebaseRepoImpl});

  @override
  getChatList(String senderId, String receiverId) {
    return firebaseRepoImpl.getChat(senderId, receiverId);
  }

  @override
  getUserList(String? uid) async {
    return await firebaseRepoImpl.getUserList(uid);
  }

  @override
  loginUser(
    String email,
    String password,
  ) async {
    return await firebaseRepoImpl.loginUser(email, password);
  }

  @override
  signUpUser(String userName, String email, String password) async {
    return await firebaseRepoImpl.signUpUser(userName, email, password);
  }

  @override
  sendMessage(String message, String senderId, String recieverId) async {
    // TODO: implement sendMessage
    await firebaseRepoImpl.sendMessage(message, senderId, recieverId);
    getChatList(senderId, recieverId);
  }

  @override
  logout(String id) async {
    await firebaseRepoImpl.logout(id);
  }

  @override
  getUser(String id) async {
    // TODO: implement getUser
    return await firebaseRepoImpl.getUser(id);
  }
}
