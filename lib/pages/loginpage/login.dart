import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/provider/login_provide.dart';
import 'package:flutter_myfirstdemo/utils/button_utils.dart';
import 'package:flutter_myfirstdemo/utils/common_utils.dart';
import 'package:flutter_myfirstdemo/utils/input_check_utils.dart';
import 'package:flutter_myfirstdemo/utils/textstyle.dart';
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
        appBar: CommonAppBar.buildAppBar("登录界面"),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .requestFocus(FocusNode()); //兼容iPhone 点击空白关闭键盘
          },
          child: Container(
            color: CommonColors.grayBg,
            child: Column(
              children: <Widget>[
                LoginItemPage(),
                _loginSumbitWidget(),
                CommonDivider.buildDivider(ScreenUtil().setHeight(30)),
                _forgotPasswordWidget(),
              ],
            ),
          ),
        ));
  }

  /// Login网路请求

  Future _requestLogin() async {
    DioRequestControl().logion(widget.usePhone, widget.useWorld, context,
        printError: (value) {
      ProviderUtils.Pro<LoginProvide>(context).setUsePhone(widget.usePhone);
      ProviderUtils.Pro<LoginStatusProvide>(context)?.loginStatus("66666");
    }).then((value) {
      ProviderUtils.Pro<LoginStatusProvide>(context)?.loginStatus("66666");
      ProviderUtils.Pro<LoginProvide>(context).setUsePhone(widget.usePhone);
    });
  }

  /// LoginSumbit组件
  Widget _loginSumbitWidget() {
    return Container(
      height: ScreenUtil().setHeight(78),
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: ScreenUtil.screenWidth,
      child: ButtonUtils.raisedButtonUtils(onClick: () {
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

  /// 忘记密码组件
  Widget _forgotPasswordWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
      alignment: Alignment.centerRight,
      height: ScreenUtil().setHeight(78),
      child: InkWell(
        onTap: () {
          Routes.router.navigateTo(context, Routes.forgetPassword);
        },
        child: Text(
          '忘记密码?',
          style: TextStyleUtils.NormalTextStyle,
        ),
      ),
    );
  }
}
