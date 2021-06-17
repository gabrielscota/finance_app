import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';
import './components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with KeyboardManager, NavigationManager, SystemNavigationUIOverlays, UIErrorManager {
  late ScrollController _scrollController;
  late FocusNode _passwordInputfocusNode;

  @override
  void initState() {
    _scrollController = ScrollController();
    _passwordInputfocusNode = FocusNode()
      ..addListener(() async {
        if (_passwordInputfocusNode.hasPrimaryFocus) {
          await Future.delayed(const Duration(milliseconds: 100));
          _scrollController.animateTo(140, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
        }
      });

    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);
    handleMainError(context, widget.presenter.mainErrorStream);

    super.initState();
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
                    padding: const EdgeInsets.all(32.0),
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
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
