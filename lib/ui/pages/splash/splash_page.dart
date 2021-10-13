import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 96.0),
        child: Image.asset('lib/ui/assets/launcher_icon/icon.png'),
      ),
    );
  }
}
