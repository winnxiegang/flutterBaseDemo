import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/utils/tire_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
    this.name,
    this.passworld,
  }) : super(key: key);
  final String name, passworld;

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录界面"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[_loadNetWidget()],
          ),
        ),
      ),
    );
  }

  /**
   * Login网路请求
   */
  Future _requestLogin() async {
    DioRequestControl().logion("111", "222", context).then((value) {});
  }

  /**
   * loadNet组件
   */
  Widget _loadNetWidget() {
    return InkWell(
      child: Text(
        "点击测试网络框架",
        style: TextStyle(
          color: Colors.black,
          backgroundColor: Colors.black12,
        ),
      ),
      onTap: () {
        this._requestLogin();
      },
    );
  }
}
