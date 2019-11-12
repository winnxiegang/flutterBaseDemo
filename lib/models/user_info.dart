import 'package:flutter_myfirstdemo/common/app_global.dart';

class UserInfo {
  UserInfo({this.userId, this.username, this.name});

  String userId;
  String username;
  String name;
  String _token;

  String get token => _token ?? '';

  set token(String token) {
    if (_token != token) {
      _token = token;
      Global.loginStatus.notify();
      Global.saveUserProfileInfo();
    }
  }
}
