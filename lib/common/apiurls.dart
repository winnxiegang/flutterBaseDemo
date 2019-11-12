/**

 * @Author:         xiegang
 * @CreateDate:     2019/11/11 15:12
 * @Description:
 */

///
class ApiUrls {
  //baseurl
  static const BASEURL = "https://www.wanandroid.com/";

  static String getPath({String path: ''}) {
    StringBuffer sb = new StringBuffer(path);
    return sb.toString();
  }

  //登录
  static const String LOGIN = "user/login";

  //注册
  static const String REGISTER = "user/register";

  //退出登录
  static const String LOGOUT = "user/logout/json";
}
