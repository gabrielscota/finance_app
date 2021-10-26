import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../home.dart';

class ProfilePageView extends StatefulWidget {
  final HomePresenter presenter;

  const ProfilePageView({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> with AutomaticKeepAliveClientMixin {
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
      onRefresh: () => Future.delayed(const Duration(seconds: 2)),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      color: Theme.of(context).colorScheme.primary,
      showChildOpacityTransition: false,
      height: 72.0,
      animSpeedFactor: 3.0,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StreamBuilder<HomeUserViewModel>(
                  stream: widget.presenter.currentUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 116.0,
                              width: 116.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.indigo.shade600,
                                  width: 4.0,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.avatar,
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 56.0,
                                ),
                                placeholder: (context, url) => CircleAvatar(
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: LottieBuilder.asset(
                                      Get.isDarkMode
                                          ? 'lib/ui/assets/animations/loading_dark.json'
                                          : 'lib/ui/assets/animations/loading_light.json',
                                    ),
                                  ),
                                  radius: 56.0,
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              snapshot.hasData && snapshot.data!.name.isNotEmpty ? snapshot.data!.name : '',
                              style: Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            Text(
                              'gabrielscota2015@gmail.com',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: Theme.of(context).colorScheme.primaryVariant,
                                  ),
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.indigo.shade600,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    IconlyLight.ticket_star,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Premium',
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // TODO: arrumar shimmer
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
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfilePageItem(
                    leadingIcon: IconlyLight.edit,
                    title: 'Edit Profile',
                    onTap: () {},
                  ),
                  ProfilePageItem(
                    leadingIcon: IconlyLight.notification,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  ProfilePageItem(
                    leadingIcon: IconlyLight.ticket,
                    title: 'Plan',
                    onTap: () {},
                  ),
                  ProfilePageItem(
                    leadingIcon: IconlyLight.setting,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  ProfilePageItem(
                    leadingIcon: IconlyLight.logout,
                    title: 'Logout',
                    onTap: () {},
                  ),
                ],
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

class ProfilePageItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Function() onTap;

  const ProfilePageItem({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        color: Theme.of(context).colorScheme.primary,
        size: 32.0,
      ),
      horizontalTitleGap: 4.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 19.0,
            ),
        textAlign: TextAlign.left,
      ),
      trailing: Icon(
        IconlyLight.arrow_right_2,
        color: Theme.of(context).colorScheme.primaryVariant,
        size: 24.0,
      ),
    );
  }
}
