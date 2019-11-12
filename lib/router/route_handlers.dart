import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/pages/confirm_new_password.dart';
import 'package:flutter_myfirstdemo/pages/forget_password.dart';
import 'package:flutter_myfirstdemo/pages/login.dart';
import 'package:flutter_myfirstdemo/pages/login_index.dart';
import 'package:flutter_myfirstdemo/pages/tabbar_page.dart';

/// 根目录
var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TabbarPage();
});

///登录首页
var loginIndexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        LoginIndexPage());

///登录
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        LoginPage());

///忘记密码
var forgetPasswordHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        ForgetPasswordPage());

///确认新密码
var confirmNewPasswordHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String phone = params['mobile']?.first ?? '';
  String code = params['code']?.first ?? "";
  return ConfirmNewPasswordPage(code: code, phone: phone);
});
