import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/common/app_global.dart';

class LoginStatusProvide extends ChangeNotifier {
  /// 是否登录
  bool get isLogin => Global.user.token != null && Global.user.token.isNotEmpty;

  void loginStatus(String token) {
    if (token != null && token.isNotEmpty) {
      Global.user.token = token;
      notifyListeners();
    }
  }

  /// 退出登录状态
  void logoutStatus() {
    Global.user.token = "";
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
