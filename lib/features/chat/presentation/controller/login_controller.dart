import 'package:chat/features/chat/presentation/controller/user_list_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/values/utils.dart';
import '../../data/data_source/local/local_storage.dart';
import '../../data/model/user_data.dart';
import '../../data/repo_impl/repository_impl.dart';
import '../views/login/login.dart';
import '../views/sign_up/sign_up.dart';
import '../views/user_list.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  RepositoryImpl repositoryImpl;
  User? user;

  LoginController(this.repositoryImpl);

  var userDetail = UserData().obs;

  @override
  onInit() async {
    super.onInit();
   // navigateToPage();
    var id= await LocalStorage.get("id");
    getUser(id);
  }

  navigateToPage() {
    repositoryImpl.firebaseRepoImpl.user?.uid != null
        ? Get.offAll(() => UserList())
        : Get.offAll(() => LoginPage());
  }

  showLoading(isLoading) {
    isLoading.value = isLoading;
  }

  LoginUser() async {
    if (validUser()) {
      var data = await repositoryImpl.loginUser(
          emailController.value.text, passwordController.value.text);
      if (data != null) {
        ShowSnackBar.success("Success");
        await LocalStorage.remove(LocalStorage.isLogedIn);
        await LocalStorage.save(LocalStorage.isLogedIn, data.email);
        await LocalStorage.save("id", data.uid);
       var uid= await LocalStorage.get("id");
       var email= await LocalStorage.get(LocalStorage.isLogedIn);

        print("email==$email====$uid========${data.email}${data.uid}");
        await getUser(uid);
      } else {
        ShowSnackBar.errors("error");
        print("data=====$data");
      }
    }
  }

  navigateToSignupPage() {
    Get.to(() => SignUpUser());
  }

  validUser() {
    var email = emailController.value.text.trim();
    var pass = passwordController.value.text.trim();
    if (email.isEmpty) {
      ShowSnackBar.errors("Please enter valid email");
      return false;
    } else if (pass.isEmpty) {
      ShowSnackBar.errors("Please enter valid pass");
      return false;
    } else {
      return true;
    }
  }

  getUser(datai) async {
    var data = await repositoryImpl.getUser(datai);
    userDetail.value = data;
    print("dea====${userDetail.value.userName}");
    final UserListAndChatController userListAndChatController =
    Get.find<UserListAndChatController>();
    var id= await LocalStorage.get("id");
   await getUserList(userDetail.value.uid);
    Get.offAll(() => UserList(user:userDetail.value));
    update();
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
  var userData = RxList<UserData>().obs;

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
}
