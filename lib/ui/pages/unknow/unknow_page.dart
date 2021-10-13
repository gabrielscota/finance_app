import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';

class UnknowPage extends StatefulWidget {
  final UnknowPresenter presenter;

  const UnknowPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _UnknowPageState createState() => _UnknowPageState();
}

class _UnknowPageState extends State<UnknowPage> with SingleTickerProviderStateMixin, SystemNavigationUIOverlays {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    statusBarIconBrightness(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
              child: Lottie.asset(
                Get.isDarkMode ? 'lib/ui/assets/animations/404_dark.json' : 'lib/ui/assets/animations/404_light.json',
                controller: _controller,
                fit: BoxFit.fitWidth,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward()
                    ..repeat();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                children: [
                  Text(
                    'Oops!',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Essa página que tentou acessar não existe.',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground.withAlpha(120),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: Get.previousRoute == '/' ? () => Get.offAllNamed('/login') : Get.back,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    ),
                    child: Text(
                      'Voltar',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
