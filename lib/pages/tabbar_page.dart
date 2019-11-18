import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myfirstdemo/provider/currentIndex.dart';
import 'package:flutter_myfirstdemo/utils/tire_export.dart';
import 'package:provider/provider.dart';

import 'confirm_new_password.dart';
import 'listviewdemo.dart';
import 'login.dart';

class TabbarPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];
  final List<Widget> tabBodies = [
    ListViewDemo(),
    LoginPage(),
    LoginPage(),
    ConfirmNewPasswordPage()
  ];
  DateTime lastPopTime;

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<CurrentIndexProvide>(context).currentIndex;
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          key: PageStorageKey(currentIndex),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
            Provider.of<CurrentIndexProvide>(context).changeIndex(index);
          },
        ),
        body: IndexedStack(
          //集成自Stack，用来显示第index个child
          index: currentIndex,
          children: tabBodies,
        ),
      ),
      onWillPop: () {
        // ignore: missing_return
        _onWillPop(context);
      },
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('退出软件'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('取消'),
              ),
              new FlatButton(
                onPressed: () async => {
                  Navigator.of(context).pop(true),
                  await SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                },
                child: new Text('确定'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
