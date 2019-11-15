import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/provider/login_status_provide.dart';
import 'package:provider/provider.dart';

class CommonColors {
  ///主颜色
  static const Color mainColor = Color(0xFFE22319);

  //灰色图片
  static Color grayPicture = Color(0xFF888889);
}

class CommonDivider {
  static Divider buildDivider(double mheight, {Color mColor}) {
    if (mColor == null) {
      return Divider(height: mheight, color: Color.fromRGBO(239, 239, 239, 1));
    } else {
      return Divider(height: mheight, color: mColor);
    }
  }
}

class CommonAppBar {
  static AppBar buildAppBar(String title, {BuildContext mBackContext}) {
    Widget backIcon;
    if (mBackContext != null) {
      backIcon = IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(mBackContext));
    } else {
      backIcon = null;
    }
    return AppBar(
      leading: backIcon,
      backgroundColor: CommonColors.mainColor,
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      centerTitle: true,
      elevation: 0,
    );
  }
}

class PrintUtils {
  static void printMsg(String msg, {String msgTag}) {
    if (msgTag == null) {
      print('log${msg}');
    } else {
      print('${msgTag + msg}');
    }
  }
}

class ProviderUtils {
  static T Pro<T>(BuildContext buildContext, {bool refushListen = true}) {
    if (buildContext != null) {
      return Provider.of<T>(buildContext, listen: refushListen);
    }
    PrintUtils.printMsg("------->${T}的buildContext为空");
    return null;
  }
}
