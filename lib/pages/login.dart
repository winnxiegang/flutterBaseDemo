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
      body: Content(),
    );
  }

  Widget Test() => Container(child: Text("内容区域${widget.name}"));
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => new _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        child: Text(
          "点击测试网络框架",
          style: TextStyle(
            color: Colors.black,
            backgroundColor: Colors.black12,
          ),
        ),
        onTap: () {
          this._request();
        },
      ),
    );
  }

  Future _request() async {
    DioRequestControl()
        .logion("12222222211", "22222222222", context, backdiss: true)
        .then((value) {
      YToast.show(context: context, msg: "登录成功${555}");
      Routes.router.navigateTo(context, Routes.root,
          transition: TransitionType.native, replace: true);
    });
  }
}
