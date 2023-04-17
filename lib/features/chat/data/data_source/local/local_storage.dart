import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static const isLogedIn = "isLoggedIn";
 static final box = GetStorage();
  static save(key, value) async {
    await box.write(key, value);
    print("$value==============$key====save=========$value");

  }

  static get(key) async {
    var value =await box.read(key);
    print("$value==============$key=============$value");
    return value;
  }

  static remove(key) async {
    var value =await box.read(key);
    print("$value=======remo=======$key=============$value");

    await box.erase();
    print("$value==============$key=====remove========$value");

  }
}
