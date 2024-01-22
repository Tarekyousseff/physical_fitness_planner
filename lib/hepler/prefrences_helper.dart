import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferncesHelper extends ChangeNotifier{
  final SharedPreferences _preferences;

  PreferncesHelper(this._preferences);

  void login() {
    _preferences.setBool('isLoggedIn', true);
    print(
        '***************************************Is Logged In *************************************');
  }

  void customerLoggin() {
    _preferences.setString('userType', 'customer');
    print(
        '*************************************** Customerr In *************************************');
  }

  String userType() {
    return _preferences.getString('userType') ?? 'coach';
    
  }

  void logout() {
    _preferences.setBool('isloggedIn', false);
  }

  bool isloggedIn() {
    return _preferences.getBool('isloggedIn') ?? false;
  }
}
