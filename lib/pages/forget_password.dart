import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({
    Key key,
  }) : super(key: key);

  @override
  ForgetPasswordPageState createState() => new ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("appBar标题"), centerTitle: true),
      body: ForgetPasswordContent(),
    );
  }
}

class ForgetPasswordContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("内容区域"));
  }
}
