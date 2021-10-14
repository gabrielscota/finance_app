import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({Key? key, required this.presenter}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with NavigationManager, SingleTickerProviderStateMixin, SystemNavigationUIOverlays {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  late final PageController _pageController;

  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);

    _pageController = PageController(initialPage: 0);

    super.initState();
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
            physics: const NeverScrollableScrollPhysics(),
            children: [
              LiquidPullToRefresh(
                key: _refreshIndicatorKey,
                onRefresh: () => Future.delayed(const Duration(seconds: 2)),
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                color: Theme.of(context).colorScheme.primary,
                showChildOpacityTransition: false,
                height: 72.0,
                animSpeedFactor: 3.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0, bottom: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Hi, ',
                                          style: Theme.of(context).textTheme.headline4?.copyWith(
                                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                              ),
                                        ),
                                        TextSpan(
                                            text: 'Gabriel Scotá',
                                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                                  color: Theme.of(context).colorScheme.primary,
                                                )),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'October, 12',
                                    style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Wallet balance',
                                                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                                    ),
                                              ),
                                              Text(
                                                'R\$ 2178,98',
                                                style: Theme.of(context).textTheme.headline4?.copyWith(
                                                      color: Theme.of(context).colorScheme.onPrimary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            IconlyLight.arrow_right_2,
                                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  Container(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    height: 72.0,
                                    child: LineChart(
                                      LineChartData(
                                        lineTouchData: LineTouchData(
                                          handleBuiltInTouches: false,
                                          touchTooltipData: LineTouchTooltipData(
                                            tooltipBgColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
                                          ),
                                        ),
                                        gridData: FlGridData(show: false),
                                        titlesData: FlTitlesData(
                                          bottomTitles: SideTitles(showTitles: false),
                                          rightTitles: SideTitles(showTitles: false),
                                          topTitles: SideTitles(showTitles: false),
                                          leftTitles: SideTitles(showTitles: false),
                                        ),
                                        borderData: FlBorderData(
                                          show: true,
                                          border: const Border.fromBorderSide(BorderSide.none),
                                        ),
                                        lineBarsData: [
                                          LineChartBarData(
                                            isCurved: true,
                                            colors: [Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)],
                                            barWidth: 3,
                                            isStrokeCapRound: true,
                                            dotData: FlDotData(show: false),
                                            belowBarData: BarAreaData(show: false),
                                            spots: [
                                              FlSpot(1, 2100),
                                              FlSpot(2, 2050),
                                              FlSpot(3, 2175),
                                              FlSpot(4, 2150),
                                              FlSpot(5, 2125),
                                              FlSpot(6, 2100),
                                              FlSpot(7, 2028),
                                              FlSpot(8, 1960),
                                              FlSpot(9, 2163),
                                              FlSpot(10, 2250),
                                              FlSpot(11, 2300),
                                              FlSpot(12, 2369),
                                              FlSpot(13, 2400),
                                              FlSpot(14, 2500),
                                              FlSpot(15, 2689),
                                              FlSpot(16, 2899),
                                              FlSpot(17, 2633),
                                              FlSpot(18, 2245),
                                              FlSpot(19, 2555),
                                              FlSpot(20, 2900),
                                              FlSpot(21, 3110),
                                              FlSpot(22, 3095),
                                              FlSpot(23, 3052),
                                              FlSpot(24, 2758),
                                              FlSpot(25, 2569),
                                              FlSpot(26, 2458),
                                              FlSpot(27, 2325),
                                              FlSpot(28, 2245),
                                              FlSpot(29, 2058),
                                              FlSpot(30, 1852),
                                            ],
                                          ),
                                        ],
                                        minX: 1,
                                        maxX: 30,
                                        minY: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'My Stocks',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See All',
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                      SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 2,
                        itemCount: 10,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        staggeredTileBuilder: (index) => StaggeredTile.count(
                          1,
                          index == 0 || index == 9 ? 0.6 : 0.9,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconlyLight.plus,
                                    size: 24.0,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Add new stock',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          } else if (index == 9) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconlyLight.graph,
                                    size: 24.0,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'See All',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                ),
                              ),
                              child: const Text('Stock'),
                            );
                          }
                        },
                      ),
                      const SliverPadding(
                        padding: EdgeInsets.only(bottom: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const Center(child: Text('Stock')),
              const Center(child: Text('Wallet')),
              const Center(child: Text('Profile')),
            ],
          ),
        ),
        // bottomNavigationBar: Container(
        //   clipBehavior: Clip.hardEdge,
        //   padding: const EdgeInsets.only(bottom: 12.0),
        //   decoration: BoxDecoration(
        //     borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
        //     color: Theme.of(context).colorScheme.primary,
        //   ),
        //   child: SlidingClippedNavBar(
        //     backgroundColor: Theme.of(context).colorScheme.primary,
        //     onButtonPressed: (index) {
        //       setState(() {
        //         _selectedIndex = index;
        //       });
        //       _pageController.animateToPage(
        //         _selectedIndex,
        //         duration: const Duration(milliseconds: 600),
        //         curve: Curves.easeOutQuad,
        //       );
        //     },
        //     iconSize: 28.0,
        //     selectedIndex: _selectedIndex,
        //     activeColor: Theme.of(context).colorScheme.background,
        //     inactiveColor: Theme.of(context).colorScheme.background.withOpacity(0.6),
        //     barItems: [
        //       BarItem(
        //         icon: IconlyLight.home,
        //         title: 'Home',
        //       ),
        //       BarItem(
        //         icon: IconlyLight.graph,
        //         title: 'Stocks',
        //       ),
        //       BarItem(
        //         icon: IconlyLight.wallet,
        //         title: 'Wallet',
        //       ),
        //       BarItem(
        //         icon: IconlyLight.profile,
        //         title: 'Profile',
        //       ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
          ),
          padding: const EdgeInsets.all(24.0),
          child: GNav(
            onTabChange: (value) => _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutQuad,
            ),
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
