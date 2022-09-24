import 'dart:convert';

import 'package:hacknu_mobile/feature/auth/model/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomLocalStorage {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // ## user
  static Future<bool> saveUser({required UserData user}) async {
    var data = user.toMap();
    return await prefs.setString('user', jsonEncode(data));
  }

  static UserData? getUser() {
    var model = prefs.getString('user');
    if (model == null) return null;
    var decoded = jsonDecode(model);
    return UserData.parseMap(decoded);
  }

  static Future<void> removeUser() async {
    prefs.remove('user');
  }
}
