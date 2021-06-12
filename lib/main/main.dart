import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/components/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Finance App',
      darkTheme: AppTheme.darkThemeData,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      curve: Curves.easeInOut,
      data: Theme.of(context),
      child: Scaffold(
        body: Center(
          child: Text(
            'Finance App',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
