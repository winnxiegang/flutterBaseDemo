import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/common/apiurls.dart';
import 'package:flutter_myfirstdemo/models/user_entity.dart';
import 'package:flutter_myfirstdemo/router/routes.dart';
import 'package:flutter_myfirstdemo/utils/toast_util.dart';
import '../wedghts/simple_dialog.dart' as dialog;
import 'httpUtil.dart';
import 'http_base_response.dart';

///
///
class DioRequestControl {
  DioRequestControl();

  DioRequestControl _dioModelControl;

  DioRequestControl.getInstans() {
    if (null == _dioModelControl) {
      _dioModelControl = new DioRequestControl();
    }
  }

/*
处理错误，可以自己在ui层.error处理
printError 在需要退出到其他界面中，可能导致dialog 或者其他的控件的context无法获取，需要网络请求时加上
 */
  Future _error<T>(BaseResp baseResp, BuildContext context,
      {Function printError}) {
    if (baseResp.errorCode == 401 && context != null) {
      OkToast.show(msg: "登录失效，重新登录");
      Routes.router.navigateTo(context, Routes.login, replace: true);
      return new Future<T>.error(baseResp.errorMsg);
    }
    OkToast.show(msg: baseResp.errorMsg);
    if (printError != null) {
      printError(baseResp.errorMsg);
      return new Future<T>.error(baseResp.errorMsg);
    } else {
      if (baseResp.errorCode == 401) {
        Routes.router.navigateTo(context, Routes.login, replace: true);
        return new Future<T>.error("登录失效，重新登录");
      }
      return new Future<T>.error(baseResp.errorMsg);
    }
  }

  /**
   * 登陆
   */
  Future<UserEntity> logion(
      String username, String password, BuildContext context,
      {bool backdiss, Function printError}) async {
    dialog.showLoadingProgress(context, backdiss);
    BaseResp<Map<String, dynamic>> baseResp =
        await HttpUtil.getInstance(context).request<Map<String, dynamic>>(
            Method.post, ApiUrls.getPath(path: ApiUrls.LOGIN),
            data: {"username": username, "password": password});
    dialog.dismissDialog(context);
    UserEntity userEntity;
    if (baseResp.errorCode == 200 ||
        baseResp.errorCode == 201 ||
        baseResp.errorCode == 204) {
      if (baseResp.data != null) {
        userEntity = UserEntity.fromJson(baseResp.data);
      }
      return userEntity;
    }
    return _error<UserEntity>(baseResp, context, printError: printError);
  }
}
