import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';
import 'components/components.dart';

class LoginBiometricPage extends StatefulWidget {
  final LoginBiometricPresenter presenter;

  const LoginBiometricPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _LoginBiometricPageState createState() => _LoginBiometricPageState();
}

class _LoginBiometricPageState extends State<LoginBiometricPage>
    with KeyboardManager, NavigationManager, SystemNavigationUIOverlays, UIErrorManager, TickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsAndClearStackStream, clearStack: true);

    _scrollController = ScrollController();

    widget.presenter.loadAccount();
    startAuthentication();

    super.initState();
  }

  Future<void> startAuthentication() async {
    await Future.delayed(const Duration(seconds: 1));
    widget.presenter.authWithBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    statusBarIconBrightness(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                padding: const EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fi-Nance',
                      style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Expanded(
                      child: StreamBuilder<LoginBiometricUserViewModel>(
                        stream: widget.presenter.currentUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data!.avatar,
                                  imageBuilder: (context, imageProvider) => CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: 48.0,
                                  ),
                                  placeholder: (context, url) => CircleAvatar(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    child: Text(
                                      'G',
                                      style: Theme.of(context).textTheme.headline4?.copyWith(
                                            color: Theme.of(context).colorScheme.background,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    radius: 48.0,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                                  child: Text(
                                    'Gabriel Scotá',
                                    style: Theme.of(context).textTheme.headline4?.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                                        ),
                                  ),
                                ),
                                BiometricButton(
                                  presenter: widget.presenter,
                                  biometricAuthentication: widget.presenter.authWithBiometrics,
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                  child: Text(
                                    'G',
                                    style: Theme.of(context).textTheme.headline4?.copyWith(
                                          color: Theme.of(context).colorScheme.background,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  radius: 48.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                                  child: Text(
                                    'Gabriel Scotá',
                                    style: Theme.of(context).textTheme.headline4?.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                                        ),
                                  ),
                                ),
                                BiometricButton(
                                  presenter: widget.presenter,
                                  biometricAuthentication: widget.presenter.authWithBiometrics,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 64.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'v1.0.0',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                                ),
                            textAlign: TextAlign.right,
                          ),
                          InkWell(
                            onTap: widget.presenter.goToLoginWithPasswordPage,
                            child: Text(
                              'Entrar com a senha',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
