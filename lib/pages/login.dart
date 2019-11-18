import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/utils/tire_export.dart';
import '../utils/common_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    this.name,
    this.passworld,
    Key key,
  }) : super(key: key);
  final String name, passworld;

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    // dialog.dismissDialog(context);
  }

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

  /// Login网路请求

  Future _requestLogin() async {
    DioRequestControl().logion(widget.name, widget.passworld, context,
        printError: (value) {
      ProviderUtils.Pro<LoginStatusProvide>(context)?.loginStatus("66666");
    }).then((value) {});
  }

  /**
   * loadNet组件
   */
  Widget _loadNetWidget() {
    return InkWell(
      child: Text(
        "点击测试网络框架1133311",
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
