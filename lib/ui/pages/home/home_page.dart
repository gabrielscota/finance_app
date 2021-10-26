import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';
import 'components/components.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({Key? key, required this.presenter}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with NavigationManager, SingleTickerProviderStateMixin, SystemNavigationUIOverlays, UIErrorManager {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final PageController _pageController;
  late int _selectedIndex;

  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);
    handleMainError(context, widget.presenter.mainErrorStream);

    _pageController = PageController(initialPage: 0, keepPage: true);
    _selectedIndex = 0;

    super.initState();
  }

  void goToPage(int value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuad,
    );
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    statusBarIconBrightness(context, systemNavigationBarColor: Theme.of(context).colorScheme.primary);

    return AnimatedTheme(
      curve: Curves.easeIn,
      data: Theme.of(context),
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            restorationId: 'homePageView',
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePageView(
                presenter: widget.presenter,
                goToPage: goToPage,
              ),
              const CommingSoonPageView(),
              const CommingSoonPageView(),
              ProfilePageView(presenter: widget.presenter),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
          ),
          padding: const EdgeInsets.all(24.0),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: goToPage,
            rippleColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
            hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
            haptic: true,
            tabActiveBorder: Border.all(
              color: Theme.of(context).colorScheme.background,
              width: 1,
            ),
            curve: Curves.easeOutQuad,
            duration: const Duration(milliseconds: 600),
            gap: 8,
            color: Theme.of(context).colorScheme.background.withOpacity(0.6),
            activeColor: Theme.of(context).colorScheme.background,
            iconSize: 24,
            tabBackgroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            tabs: const [
              GButton(
                icon: IconlyLight.home,
                text: 'Home',
              ),
              GButton(
                icon: IconlyLight.graph,
                text: 'Stocks',
              ),
              GButton(
                icon: IconlyLight.wallet,
                text: 'Wallet',
              ),
              GButton(
                icon: IconlyLight.profile,
                text: 'Profile',
              )
            ],
          ),
        ),
      ),
    );
  }
}
