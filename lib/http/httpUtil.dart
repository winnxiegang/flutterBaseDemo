import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/common/apiurls.dart';
import 'package:flutter_myfirstdemo/utils/toast_util.dart';

import 'http_base_response.dart';
import '../wedghts/simple_dialog.dart' as dialog;

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;
  CancelToken cancelToken = CancelToken();
  BuildContext _context;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _codeKey = "errorCode";

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String _msgKey = "errorMsg";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "data";

  static HttpUtil getInstance(BuildContext context) {
    if (null == instance) instance = HttpUtil(context);
    return instance;
  }

  /*
   * config it and create
   */
  HttpUtil(BuildContext context) {
    this._context = context;
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: ApiUrls.BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        //do something
        "version": "1.0.0"
      },
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      contentType: ContentType.json,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    dio = Dio(options);

    //Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors.add(new LogsInterceptors(_context));
  }

  Future<BaseResp<T>> request<T>(String method, String path,
      {data,
      Options options,
      CancelToken cancelToken,
      Map<String, dynamic> queryParameters,
      String pathReplace,
      String match}) async {
    if (match != null && pathReplace != null) {
      path = path.replaceAll(match, pathReplace);
    }
    print(data);
    Response response = await dio.request(path,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseResp(_code, _msg, _data);
      } catch (e) {
        formatError(e);
        return new Future.error(new DioError(
          response: response,
          message: "data parsing exception11...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      message: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  /// Download the file and save it in local. The default http method is "GET",you can custom it by [Options.method].
  /// [urlPath]: The file url.
  /// [savePath]: The path to save the downloading file later.
  /// [onProgress]: The callback to listen downloading progress.please refer to [OnDownloadProgress].
  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback onProgress,
    CancelToken cancelToken,
    data,
    Options options,
  }) {
    return dio.download(urlPath, savePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
        data: data,
        options: options);
  }

  Future<BaseResp<T>> upload<T>(String method, String path,
      {data,
      Options options,
      CancelToken cancelToken,
      Map<String, dynamic> queryParameters}) async {
    Response response = await dio.post(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken,
        queryParameters: queryParameters);
    int _code;
    String _msg;
    T _data;
    OkToast.show(msg: "statusCode${HttpStatus.ok + HttpStatus.created}");
    print("statusCode${HttpStatus.ok + HttpStatus.created}");
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseResp(_code, _msg, _data);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          message: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      message: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    dialog.dismissDialog(_context);
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.SEND_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      OkToast.show(msg: "连接请求超时,稍后重试");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else if (e.type == DioErrorType.DEFAULT) {
      // When the server response, but with a incorrect status, such as 404, 503...
      OkToast.show(msg: "网络异常,请检查网络后重试");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

/**
 * 返回正常异常网络数据都经过这里
 */
class LogsInterceptors extends InterceptorsWrapper {
  BuildContext _context;

  LogsInterceptors(BuildContext context) {
    this._context = context;
  }

  @override
  onRequest(RequestOptions options) {
    print('请求头: ' + options.headers.toString());
    print("请求url：${options.path}");
    if (options.data != null) {
      print('请求参数: ${options.data}');
    }
    if (options.queryParameters != null) {
      print('请求参数: ${options.queryParameters}');
    }
    return options;
  }

  @override
  onResponse(Response response) {
    print('返回结果: ${response.toString()}');
    return response; // continue
  }

  @override
  onError(DioError err) {
    formatError(err, _context);
  }

  /*
   * error统一处理
   */
  void formatError(DioError e, BuildContext context) {
    dialog.dismissDialog(context);
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.SEND_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      OkToast.show(msg: "连接请求超时,稍后重试");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else if (e.type == DioErrorType.DEFAULT) {
      // When the server response, but with a incorrect status, such as 404, 503...
      OkToast.show(msg: "网络异常,请检查网络后重试");
    }
  }
}

/// decode response data.
Map<String, dynamic> _decodeData(Response response) {
  if (response == null ||
      response.data == null ||
      response.data.toString().isEmpty) {
    return new Map();
  }
  return json.decode(response.data.toString());
}

/// check Options.
Options _checkOptions(method, options) {
  Options opNew;
  if (options == null) {
    opNew = new Options(
        method: method,
        responseType: ResponseType.json,
        contentType: ContentType.parse("application/json; charset=utf-8"));
  } else {
    opNew = options;
  }
  return opNew;
}
