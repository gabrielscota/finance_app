import 'package:flutter/material.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';

class SplashPage extends StatefulWidget {
  final SplashPresenter presenter;

  const SplashPage({required this.presenter});

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

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
