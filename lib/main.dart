import 'package:chat/features/chat/presentation/views/sign_up/sign_up.dart';
import 'package:chat/features/chat/presentation/views/user_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'di/di.dart';
import 'features/chat/data/data_source/local/local_storage.dart';
import 'features/chat/presentation/views/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:LoginPage(),
    );
  }
}
