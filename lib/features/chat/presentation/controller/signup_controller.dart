import 'package:chat/core/values/utils.dart';
import 'package:chat/features/chat/data/repo_impl/repository_impl.dart';
import 'package:chat/features/chat/presentation/controller/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data_source/local/local_storage.dart';
import '../../data/model/user_data.dart';
import '../views/user_list.dart';
import 'login_controller.dart';

class SignUpController extends GetxController {
  var isLoading = true.obs;
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  RepositoryImpl repositoryImpl;

  SignUpController(this.repositoryImpl);

  showLoading(isLoading) {
    isLoading.value = isLoading;
  }

  signUpUser() async {
    if (validUser()) {
      var data = await repositoryImpl.signUpUser(nameController.value.text,
          emailController.value.text, passwordController.value.text);
      if (data != null) {
        ShowSnackBar.success("Success");
        await getUser(data.uid);
        Get.offAll(() => UserList(user:userDetail.value ,));
      } else {
        ShowSnackBar.errors("error");
        print("data=====$data");
      }
    }
  }
  var userDetail = UserData().obs;

  getUser(datai) async {
    var data = await repositoryImpl.getUser(datai);
    userDetail.value = data;
    print("dea====${userDetail.value.userName}");
    final LoginController userListAndChatController =
    Get.find<LoginController>();
    var id= await LocalStorage.get("id");
    await userListAndChatController.getUserList(userDetail.value.uid);
    update();
    Get.offAll(() => UserList(user:userDetail.value));
    update();
  }
  validUser() {
    var name = nameController.value.text.trim();
    var email = emailController.value.text.trim();
    var pass = passwordController.value.text.trim();
    if (name.isEmpty) {
      ShowSnackBar.errors("Please enter valid name");
      return false;
    } else if (email.isEmpty) {
      ShowSnackBar.errors("Please enter valid email");
      return false;
    } else if (pass.isEmpty) {
      ShowSnackBar.errors("Please enter valid pass");
      return false;
    } else {
      return true;
    }
  }
}
