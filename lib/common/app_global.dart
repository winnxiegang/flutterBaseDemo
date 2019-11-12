import 'package:flutter_myfirstdemo/models/user_info.dart';

import '../utils/tire_export.dart';

var API_DOMAIN = 'http://192.168.249.220:8111/';

class Global {
  static SharedPreferences _prefs;

  static bool get isDebug => !bool.fromEnvironment("dart.vm.product");
  static LoginStatusProvide loginStatus;

  static UserInfo user;

  static String cartCookie = '';

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    API_DOMAIN = _prefs.getString("api_domain") ?? API_DOMAIN;

    cartCookie = _prefs.getString("cart_cookie") ?? '';

    loginStatus = LoginStatusProvide();

    user = UserInfo();

    user.token = _prefs.getString('token') ?? '';
  }

  static void saveCartCookie(String cookie) {
    _prefs.setString("cart_cookie", cookie);
  }

  static void saveUserProfileInfo() {
    _prefs.setString("token", user.token);
    _prefs.setString("api_domain", API_DOMAIN);
  }
}
