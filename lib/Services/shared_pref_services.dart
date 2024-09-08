import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  //set the token
  bool setToken(String value) {
    try {
      instance.setString("accessToken", value);
      return true;
    } catch (e) {
      return false;
    }
  }

  // get the token
  String? getToken() {
    return instance.getString("accessToken");
  }

  bool setRefreshToken(String value) {
    try {
      instance.setString("refreshToken", value);
      return true;
    } catch (e) {
      return false;
    }
  }

  // get the token
  String? getRefreshToken() {
    return instance.getString("refreshToken");
  }

  // Set the userName (Email).
  bool? setUserName(String userName) {
    try {
      instance.setString("userName", userName);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool? setPassword(String passcode) {
    try {
      instance.setString("passcode", passcode);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get the userName (Email).
  String? getUserName() {
    return instance.getString("userName");
  }

// Get the password.
  String? getPassword() {
    return instance.getString("passcode");
  }

  bool? clearToken() {
    try {
      instance.remove("accessToken");
      instance.remove("refreshToken");
      return true;
    } catch (e) {
      return false;
    }
  }
}
