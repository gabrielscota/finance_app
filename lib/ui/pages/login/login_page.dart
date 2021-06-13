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
  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);
    handleMainError(context, widget.presenter.mainErrorStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    statusBarIconBrightness(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: Provider(
                create: (_) => widget.presenter,
                child: SingleChildScrollView(
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const AppTitle(),
                            GoogleLoginButton(presenter: widget.presenter),
                            const DividerWithOr(),
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
