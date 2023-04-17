import 'package:chat/features/chat/data/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../controller/user_list_controller.dart';
import '../widgets/chat_page.dart';

class UserList extends StatelessWidget {
  UserList({
    Key? key,  this.user,
  }) : super(key: key);
  UserData ?user;
  final LoginController userListAndChatController =
      Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text("UserList"),
            actions: [InkWell(onTap:(){userListAndChatController.logout();},child: Icon(Icons.logout))],
          ),
          body: Center(
            child: ListView.builder(
              itemBuilder: (BuildContext context, index) {
                var user = ctrl.userData.value[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => ChatScreen(
                          currentUser: ctrl.userDetail.value!,
                          otherUser: user,
                        ));
                  },
                  child: ListTile(
                    title: Text(user?.userName ?? ''),
                    subtitle: Text(user?.email ?? ''),
                  ),
                );
              },
              itemCount: ctrl.userData.value.length,
            ),
          ),
        );
      },
    );
  }
}
