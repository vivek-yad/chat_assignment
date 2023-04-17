import 'package:chat/features/chat/presentation/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/user_input_widget.dart';

class SignUpUser extends StatelessWidget {
  SignUpUser({Key? key}) : super(key: key);
  SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup"),),
      body: Center(
        child: Column(
          children: [
            UserTextField(
              title: "Name",
              textEditingController: signUpController.nameController.value,
            ),
            UserTextField(
              title: "Email",
              textEditingController: signUpController.emailController.value,
            ),
            UserTextField(
              title: "Password",
              textEditingController: signUpController.passwordController.value,
            ),
            ElevatedButton(
              onPressed: () {
                signUpController.signUpUser();
              },
              child: const Text("SignUp"),
            )
          ],
        ),
      ),
    );
  }
}
