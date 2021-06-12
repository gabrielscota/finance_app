import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../ui/components/components.dart';

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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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

  bool isDarkModeEnabled = false;
  int selectedIndex = 0;

  void _setSelectedIndex(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor,
    ));

    return AnimatedTheme(
      curve: Curves.easeIn,
      data: Theme.of(context),
      child: Scaffold(
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fi-Nance App',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () => Get.changeTheme(Get.isDarkMode ? AppTheme.lightThemeData : AppTheme.darkThemeData),
                child: const Text('Change theme'),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 96,
                width: 96,
                child: Material(
                  color: Theme.of(context).primaryColor,
                  shape: SquircleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor, width: 3.0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Lottie.asset(
                      'lib/ui/assets/animations/404.json',
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
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavigationBarItem(
                key: const ValueKey(0),
                iconAsset: 'lib/ui/assets/icons/home.svg',
                onTap: () => _setSelectedIndex(0),
                isActive: selectedIndex == 0,
              ),
              BottomNavigationBarItem(
                key: const ValueKey(1),
                iconAsset: 'lib/ui/assets/icons/stocks.svg',
                onTap: () => _setSelectedIndex(1),
                isActive: selectedIndex == 1,
              ),
              BottomNavigationBarItem(
                key: const ValueKey(2),
                iconAsset: 'lib/ui/assets/icons/wallet.svg',
                onTap: () => _setSelectedIndex(2),
                isActive: selectedIndex == 2,
              ),
              BottomNavigationBarItem(
                key: const ValueKey(3),
                iconAsset: 'lib/ui/assets/icons/profile.svg',
                onTap: () => _setSelectedIndex(3),
                isActive: selectedIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationBarItem extends StatelessWidget {
  final String iconAsset;
  final void Function() onTap;
  final bool isActive;

  const BottomNavigationBarItem({
    Key? key,
    required this.iconAsset,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            color: isActive
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimary.withAlpha(100),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            opacity: isActive ? 1.0 : 0.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: 2.0,
              width: isActive ? 8.0 : 0.0,
              margin: const EdgeInsets.only(top: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
