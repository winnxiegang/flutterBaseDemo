import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/utils/tire_export.dart';
import 'package:provider/provider.dart';
import 'common/app_global.dart';
import 'pages/loginpage/login.dart';
import 'pages/tabbar_page.dart';
import 'provider/currentIndex.dart';
import 'provider/login_provide.dart';
import 'router/routes.dart';
import 'pages/splash_page.dart';
import 'utils/common_utils.dart';

void main() {
  final router = new Router();
  Routes.configureRoutes(router);
  Global.init().then((e) {
    runApp(
      MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: CurrentIndexProvide()),
          ChangeNotifierProvider.value(value: Global.loginStatus),
          ChangeNotifierProvider.value(value: LoginProvide()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.router.generator,
            theme: ThemeData(primaryColor: Colors.amber),
            home:
                Consumer<LoginStatusProvide>(builder: (context, status, child) {
              if (status.isLogin) {
                PrintUtils.printMsg("------->TabbarPageMyApp的运作中");
                return TabbarPage();
              } else
                PrintUtils.printMsg("------->LoginPageMyApp的运作中");
              return LoginPage();
            })));
  }
}
