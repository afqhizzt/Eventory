import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'dart:convert';

class RememberUserPrefs {
  static Future<void> storeUserInfo(Userr userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  static Future<Userr?> readUserInfo() async {
    Userr? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = Userr.fromJson(userDataMap);
    }

    return currentUserInfo;
  }
}
