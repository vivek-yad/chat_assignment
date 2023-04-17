import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../widgets/user_input_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginPage"),
      ),
      body: Column(
        children: [
          UserTextField(
            title: "Email",
            textEditingController: loginController.emailController.value,
          ),
          UserTextField(
            title: "password",
            textEditingController: loginController.passwordController.value,
          ),
          ElevatedButton(
            onPressed: () {
              loginController.LoginUser();
            },
            child: Text("Login"),
          ),
          ElevatedButton(onPressed: () {loginController.navigateToSignupPage();}, child: Text("Signup"))
        ],
      ),
    );
  }
}
