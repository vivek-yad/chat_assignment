import 'package:chat/features/chat/data/data_source/local/local_storage.dart';
import 'package:chat/features/chat/data/repo_impl/repository_impl.dart';
import 'package:chat/features/chat/presentation/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/user_data.dart';

class UserListAndChatController extends GetxController {
  var isLoading = true.obs;
  var userData = RxList<UserData>().obs;

  var messageController = TextEditingController().obs;

  RepositoryImpl repositoryImpl;
  var userDetail = UserData().obs;

  UserListAndChatController(this.repositoryImpl);

  showLoading(isLoading) {
    isLoading.value = isLoading;
  }

  @override
  onInit() async {
    super.onInit();
    var id = await LocalStorage.get("id") ?? '';
    getUserList(id);
    print("$id========idd");
    if ( id.toString().isNotEmpty) {
      await getUser(id);
      print("$id===ddddd=====idd");
    } else {
      print("$id=======dddddsss=idd");
     // Get.to(() => LoginPage());
    }

    //user=repositoryImpl.firebaseRepoImpl.user;
    //print("user========$user");

  //  update();
  }

  getUser(id) async {
    print(
        "userIdjjjjjjkkkkkkkkkkkk   ${LocalStorage.get("id") ?? ''} =======${repositoryImpl.firebaseRepoImpl.user?.uid ?? ''}");
    userDetail.value = await repositoryImpl.getUser(id);
    await getUserList(id);
    update();
  }

  // onReady(){
  //   user=repositoryImpl.firebaseRepoImpl.user;
  //   print("user========$user");
  // }

  getUserList(id) async {
    print("userhhh+++++}${userDetail.value}+++ddddddddddd++++++$userData");
    var data = await repositoryImpl.getUserList(userDetail.value.uid);
    userData.value.clear();
    userData.value.addAll(data);
    userData.value.refresh();
    print("userhhh++++++++++++++$userData");
    update();
  }

  sendMessage(String message, String senderId, String recieverId) async {
    await repositoryImpl.sendMessage(message, senderId, recieverId);
    getChatList(senderId, recieverId);
    //getChatList(String senderId, String recieverId);
  }

  getChatList(String senderId, String recieverId) {
    repositoryImpl.getChatList(senderId, recieverId);
  }

  logout() async {
    print(
        "USERID=================================${repositoryImpl.firebaseRepoImpl.user?.uid ?? ''}");
    var data = await LocalStorage.get("id") ?? '';
    print("USERID=2================================${data}");
    await repositoryImpl
        .logout(repositoryImpl.firebaseRepoImpl.user?.uid ?? '');
    Get.offAll(() => LoginPage());
  }
}
