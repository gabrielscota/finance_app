import 'package:flutter/material.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';
import 'components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with KeyboardManager, NavigationManager, SystemNavigationUIOverlays, UIErrorManager, TickerProviderStateMixin {
  late ScrollController _scrollController;
  late FocusNode _passwordInputfocusNode;
  late bool _showBiometricInput;
  late final AnimationController _controller;
  late LocalAuthentication _localAuth;
  late Rx<bool?> _authenticationStatus;
  late Stream<bool?> _authenticationStatusStream;
  late final AnimationController _authenticationAnimationController;
  late Rx<int> _countAuthentication;
  late Stream<int?> _countAuthenticationStream;
  late bool _enterWithPassword;

  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);
    handleNavigationWithArgs(widget.presenter.navigateToHomeWithArgsStream, clearStack: true);
    handleMainError(context, widget.presenter.mainErrorStream);

    _countAuthentication = Rx<int>(0);
    _countAuthenticationStream = _countAuthentication.stream;

    _localAuth = LocalAuthentication();

    _scrollController = ScrollController();
    _passwordInputfocusNode = FocusNode()
      ..addListener(() async {
        if (_passwordInputfocusNode.hasPrimaryFocus) {
          await Future.delayed(const Duration(milliseconds: 100));
          _scrollController.animateTo(140, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
        }
      });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _showBiometricInput = false;
    _authenticationStatus = Rx<bool?>(null);
    _authenticationStatusStream = _authenticationStatus.stream;
    _authenticationAnimationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    Future.delayed(const Duration(seconds: 1)).then((_) => authenticate());

    _enterWithPassword = false;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _authenticationAnimationController.dispose();
    _authenticationStatus.close();

    super.dispose();
  }

  void handleShowBiometricInput() {
    if (_showBiometricInput == false) {
      setState(() {
        _controller.forward();
        _showBiometricInput = true;
      });
    }
  }

  Future<void> authenticate() async {
    if (_showBiometricInput == false) {
      handleShowBiometricInput();

      bool _didAuthenticate = false;
      bool canAuthenticateAgain = true;
      while (_didAuthenticate == false && canAuthenticateAgain == true) {
        canAuthenticateAgain = false;
        _didAuthenticate = await _localAuth.authenticateWithBiometrics(
          stickyAuth: true,
          localizedReason: 'Please authenticate to show account balance',
          maxTimeoutMillis: 15000,
        );
        _authenticationStatus.subject.add(_didAuthenticate);

        if (_didAuthenticate == false) {
          _authenticationAnimationController.forward();
          int _currentCountValue = _countAuthentication.value;
          _currentCountValue++;
          _countAuthentication.value = _currentCountValue;
          await Future.delayed(const Duration(seconds: 2));
          _authenticationAnimationController.reverse();
          canAuthenticateAgain = true;
        } else if (_didAuthenticate == true) {
          canAuthenticateAgain = false;
          await Future.delayed(const Duration(seconds: 2));
          widget.presenter.goToHomePage();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    statusBarIconBrightness(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: Provider(
                create: (_) => widget.presenter,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0),
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: !_enterWithPassword
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fi-Nance',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(color: Theme.of(context).primaryColor),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 36.0,
                                      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                      child: Text(
                                        'G',
                                        style: Theme.of(context).textTheme.headline4?.copyWith(
                                              color: Theme.of(context).colorScheme.background,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
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
                                    Visibility(
                                      visible: !_showBiometricInput,
                                      child: ElevatedButton(
                                        onPressed: authenticate,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
                                        ),
                                        child: Text(
                                          'Entrar',
                                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizeTransition(
                                sizeFactor: _controller,
                                child: Column(
                                  children: [
                                    StreamBuilder<bool?>(
                                      stream: _authenticationStatusStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData && snapshot.data == true) {
                                          return LottieBuilder.asset(
                                            'lib/ui/assets/animations/fingerprint_success.json',
                                            animate: true,
                                            height: 64.0,
                                            width: 64.0,
                                            repeat: false,
                                          );
                                        } else if (snapshot.hasData && snapshot.data == false) {
                                          return LottieBuilder.asset(
                                            'lib/ui/assets/animations/fingerprint_fail.json',
                                            animate: true,
                                            height: 64.0,
                                            width: 64.0,
                                            repeat: false,
                                            controller: _authenticationAnimationController,
                                          );
                                        }
                                        return LottieBuilder.asset(
                                          'lib/ui/assets/animations/fingerprint_waiting.json',
                                          animate: false,
                                          height: 64.0,
                                          width: 64.0,
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
                                      child: Text(
                                        'Toque no sensor de impressão digital do seu celular',
                                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
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
                                    StreamBuilder<int?>(
                                        stream: _countAuthenticationStream,
                                        builder: (context, snapshot) {
                                          return AnimatedOpacity(
                                            opacity: snapshot.hasData && snapshot.data! > 0 ? 1.0 : 0.0,
                                            duration: const Duration(milliseconds: 400),
                                            child: InkWell(
                                              onTap: () async {
                                                await _localAuth.stopAuthentication();
                                                setState(() {
                                                  _enterWithPassword = true;
                                                });
                                              },
                                              child: Text(
                                                'Entrar com a senha',
                                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const AppTitle(),
                                  GoogleLoginButton(presenter: widget.presenter),
                                  const DividerWithOr(),
                                  UserInput(
                                    presenter: widget.presenter,
                                    scrollController: _scrollController,
                                    passwordInputfocusNode: _passwordInputfocusNode,
                                  ),
                                  PasswordInput(
                                    presenter: widget.presenter,
                                    scrollController: _scrollController,
                                    focusNode: _passwordInputfocusNode,
                                  ),
                                  LoginButton(presenter: widget.presenter),
                                ],
                              ),
                              const GoToSignUp(),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
