import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/provider/login_provide.dart';
import 'package:flutter_myfirstdemo/utils/button_utils.dart';
import 'package:flutter_myfirstdemo/utils/common_utils.dart';
import 'package:flutter_myfirstdemo/utils/input_check_utils.dart';
import 'package:flutter_myfirstdemo/utils/tire_export.dart';

import '../loginpage/login_item_page.dart';

class LoginPage extends StatefulWidget {
  String useWorld = "";
  String usePhone = "";

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: CommonAppBar.buildAppBar(
        "登录界面",
      ),
      body: Container(
        color: CommonColors.grayBg,
        child: Column(
          children: <Widget>[LoginItemPage(), _loginSumbitWidget()],
        ),
      ),
    );
  }

  /// Login网路请求

  Future _requestLogin() async {
    DioRequestControl()
        .logion(widget.usePhone, widget.useWorld, context,
            printError: (value) {})
        .then((value) {
      ProviderUtils.Pro<LoginStatusProvide>(context)?.loginStatus("66666");
    });
  }

  /// LoginSumbit组件
  Widget _loginSumbitWidget() {
    return Container(
      height: ScreenUtil().setHeight(78),
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: ScreenUtil.screenWidth,
      child: ButtonUtls.raisedButtonUtils(onClick: () {
        widget.useWorld =
            ProviderUtils.Pro<LoginProvide>(context)?.getUseWorld();
        widget.usePhone =
            ProviderUtils.Pro<LoginProvide>(context)?.getUsePhone();
        if (InputCheckUtils.isCanLogin(
            context, widget.usePhone, widget.useWorld)) {
          this._requestLogin();
        }
      }),
    );
  }
}
