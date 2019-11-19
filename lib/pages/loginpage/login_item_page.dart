import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/provider/login_provide.dart';
import 'package:flutter_myfirstdemo/utils/common_utils.dart';
import 'package:flutter_myfirstdemo/utils/screen_util.dart';
import 'package:flutter_myfirstdemo/utils/textstyle.dart';

class LoginItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              CommonDivider.buildDivider(20),
              CommonDivider.buildDivider(1),
              _usePhoneWidget(context), //登录名weight
              CommonDivider.buildDivider(1, mColor: Colors.amber),
              passwordTextFiled(context), //登录密码weight
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  ///用户名
  Widget _usePhoneWidget(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(88),
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: <Widget>[
          Text("用户名", style: TextStyleUtils.LoginInputText),
          SizedBox(width: 20),
          Container(
            child: Flexible(
              child: TextField(
                onChanged: (text) {
                  //内容改变的回调
                  ProviderUtils.Pro<LoginProvide>(context)
                      ?.setUsePhone('$text');
                },
                maxLength: 20,
                style: TextStyleUtils.LoginInputText,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyleUtils.LoginHintText,
                  hintText: '请输入手机号',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///密码
  Widget passwordTextFiled(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(88),
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: <Widget>[
          Text("密    码", style: TextStyleUtils.LoginInputText),
          SizedBox(width: 20),
          Container(
            child: Flexible(
              child: TextField(
                onChanged: (text) {
                  //内容改变的回调
                  ProviderUtils.Pro<LoginProvide>(context)?.setUseWorld('$text');
                },
                maxLength: 20,
                obscureText: true,
                style: TextStyleUtils.LoginInputText,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyleUtils.LoginHintText,
                  hintText: '请输入密码',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
