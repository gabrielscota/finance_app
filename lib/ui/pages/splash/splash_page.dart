import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';

class SplashPage extends StatefulWidget {
  final SplashPresenter presenter;

  const SplashPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NavigationManager, SystemNavigationUIOverlays {
  @override
  void initState() {
    widget.presenter.checkAccount(durationInSeconds: 1);

    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream, clearStack: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    statusBarIconBrightness(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          Get.isDarkMode
              ? 'lib/ui/assets/splash/splash_dark_foreground.png'
              : 'lib/ui/assets/splash/splash_light_foreground.png',
        ),
      ),
    );
  }
}
