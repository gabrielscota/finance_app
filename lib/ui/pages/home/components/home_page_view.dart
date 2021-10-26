import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../home.dart';

class HomePageView extends StatefulWidget {
  final HomePresenter presenter;
  final Function(int value) goToPage;

  const HomePageView({
    Key? key,
    required this.presenter,
    required this.goToPage,
  }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with AutomaticKeepAliveClientMixin<HomePageView> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    widget.presenter.loadAccount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: () => Future.delayed(const Duration(seconds: 2)).whenComplete(() => widget.presenter.loadAccount()),
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
                  UserName(presenter: widget.presenter),
                  WalletBalance(presenter: widget.presenter),
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
                        onPressed: () => widget.goToPage(1),
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
                  return ElevatedButton(
                    onPressed: () => widget.goToPage(1),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      primary: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
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
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          'lib/ui/assets/icons/google.svg',
                        ),
                        Text(
                          'GOGL34',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'R\$ 105,23',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontSize: 19.0,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WalletBalance extends StatefulWidget {
  final HomePresenter presenter;

  const WalletBalance({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Wallet balance',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                              ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      StreamBuilder<bool>(
                        stream: widget.presenter.showBalance,
                        initialData: false,
                        builder: (context, snapshot) {
                          return Stack(
                            children: [
                              AnimatedOpacity(
                                opacity: snapshot.hasData && snapshot.data == true ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: AutoSizeText(
                                    'R\$ 2.753.213,98',
                                    style: Theme.of(context).textTheme.headline4?.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: snapshot.hasData && snapshot.data == false ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                child: Shimmer.fromColors(
                                  enabled: false,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.black26,
                                    ),
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: AutoSizeText(
                                      'R\$ 2.753.213,98',
                                      style: Theme.of(context).textTheme.headline4?.copyWith(
                                            color: Colors.transparent,
                                          ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  baseColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.26),
                                  highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.26),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                IconButton(
                  onPressed: widget.presenter.handleShowBalance,
                  icon: Icon(
                    IconlyLight.hide,
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                    size: 32.0,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserName extends StatefulWidget {
  final HomePresenter presenter;

  const UserName({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<HomeUserViewModel>(
      stream: widget.presenter.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
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
                        text: snapshot.hasData && snapshot.data!.name.isNotEmpty ? snapshot.data!.name : '',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.presenter.todayDate,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Shimmer.fromColors(
                        child: Container(
                          height: 56.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.black26,
                          ),
                        ),
                        baseColor: Colors.black26,
                        highlightColor: Colors.black12,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.presenter.todayDate,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
