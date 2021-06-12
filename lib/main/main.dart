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
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      curve: Curves.easeInOut,
      data: Theme.of(context),
      duration: const Duration(milliseconds: 300),
      child: Scaffold(
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Finance App',
                style: Theme.of(context).textTheme.headline4,
              ),
              Switch(
                value: isDarkModeEnabled,
                onChanged: (value) {
                  if (value) {
                    Get.changeThemeMode(ThemeMode.dark);
                  } else {
                    Get.changeThemeMode(ThemeMode.light);
                  }
                  isDarkModeEnabled = !isDarkModeEnabled;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
