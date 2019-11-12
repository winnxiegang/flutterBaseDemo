import 'package:flutter/material.dart';

class LoginIndexPage extends StatefulWidget {
  const LoginIndexPage({
    Key key,
  }) : super(key: key);

  @override
  LoginIndexPageState createState() => new LoginIndexPageState();
}

class LoginIndexPageState extends State<LoginIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("appBar标题"), centerTitle: true),
      body: LoginIndexContent(),
    );
  }
}

class LoginIndexContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("内容区域"));
  }
}
