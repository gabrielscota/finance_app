import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingPresenter presenter;

  const OnboardingPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with NavigationManager {
  final PageController _pageController = PageController();

  final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Theme.of(Get.context!).colorScheme.onPrimary,
    systemNavigationBarColor: Theme.of(Get.context!).colorScheme.onPrimary,
  );

  int _selectedPageIndex = 0;
  void changeSelectedPageIndex(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsAndClearStackStream, clearStack: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: changeSelectedPageIndex,
                  children: const [
                    OnboardingPageView(
                      illustration: 'lib/ui/assets/illustrations/wallet.svg',
                      title: 'Connect',
                      text: 'Add your wallet and let it sync automatically.',
                    ),
                    OnboardingPageView(
                      illustration: 'lib/ui/assets/illustrations/secure.svg',
                      title: 'Secure',
                      text: 'Rest assured, your data is protected.',
                    ),
                    OnboardingPageView(
                      illustration: 'lib/ui/assets/illustrations/finance.svg',
                      title: 'Profitability',
                      text: 'Track the profitability of your portfolio and have access to reports.',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 48.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInUp(
                      delay: const Duration(milliseconds: 1800),
                      duration: const Duration(milliseconds: 800),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          dotColor: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.3),
                          dotHeight: 12.0,
                          spacing: 8.0,
                          dotWidth: 12.0,
                        ),
                      ),
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1800),
                      duration: const Duration(milliseconds: 800),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          fixedSize: const Size(112.0, 56.0),
                        ),
                        onPressed: () {
                          if (_selectedPageIndex == 2) {
                            widget.presenter.goToSignUpPage();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOutSine,
                            );
                          }
                        },
                        child: _selectedPageIndex == 2
                            ? Text(
                                'Lets go',
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                              )
                            : LottieBuilder.asset(
                                'lib/ui/assets/animations/arrow_dark.json',
                                height: 24.0,
                                fit: BoxFit.fitHeight,
                                animate: true,
                                repeat: true,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageView extends StatelessWidget {
  final String illustration;
  final String title;
  final String text;

  const OnboardingPageView({
    Key? key,
    required this.illustration,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInRight(
            delay: const Duration(milliseconds: 600),
            duration: const Duration(milliseconds: 1000),
            child: SvgPicture.asset(illustration),
          ),
          FadeInRight(
            delay: const Duration(milliseconds: 1200),
            duration: const Duration(milliseconds: 1000),
            child: Transform.translate(
              offset: const Offset(0, -64.0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.6),
                            fontSize: 20.0,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
