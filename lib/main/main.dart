import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/components/components.dart';
import './factories/factories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _globalKey,
      title: 'Fi-Nance',
      darkTheme: AppTheme.darkThemeData,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: AppTheme.lightThemeData,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeSplashPage,
        ),
        GetPage(
          title: 'Home Page',
          name: '/home',
          page: makeHomePage,
        ),
        GetPage(
          title: 'Login Page',
          name: '/login',
          page: makeLoginPage,
        ),
      ],
      unknownRoute: GetPage(
        title: 'Unknow Page',
        name: '/unknow',
        page: makeUnknowPage,
      ),
    );
  }
}
