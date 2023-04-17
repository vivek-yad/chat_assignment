import 'package:chat/features/chat/data/repo_impl/repository_impl.dart';
import 'package:chat/features/chat/presentation/controller/signup_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage/get_storage.dart';

import '../features/chat/data/data_source/firebase/firebase_db_impl.dart';
import '../features/chat/presentation/controller/login_controller.dart';
import '../features/chat/presentation/controller/user_list_controller.dart';

class Di {
  static init() async {

  final  FirebaseRepoImpl firebaseRepoImpl=FirebaseRepoImpl();
  final RepositoryImpl repositoryImpl= RepositoryImpl(firebaseRepoImpl: firebaseRepoImpl);
  Get.put(SignUpController(repositoryImpl));
    Get.put(LoginController(repositoryImpl));

    Get.put(UserListAndChatController(repositoryImpl));
  }
}
