import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/components/components.dart';
import './factories/factories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _globalKey,
      title: 'Fi-Nance App',
      darkTheme: AppTheme.darkThemeData,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: AppTheme.lightThemeData,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeLoginPage,
        ),
        GetPage(
          name: '/home',
          page: makeHomePage,
        ),
      ],
    );
  }
}
