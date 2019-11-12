import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myfirstdemo/utils/tire_export.dart';
import 'package:provider/provider.dart';
import 'common/app_global.dart';
import 'pages/login.dart';
import 'pages/tabbar_page.dart';
import 'provider/currentIndex.dart';
import 'router/routes.dart';

void main() {
  final router = new Router();
  Routes.configureRoutes(router);
  Global.init().then((e) {
    runApp(
      MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: CurrentIndexProvide()),
          ChangeNotifierProvider.value(value: Global.loginStatus),
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
              if (status.isLogin)
                return TabbarPage();
              else
                return LoginPage();
            })));
  }
}


