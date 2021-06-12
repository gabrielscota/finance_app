import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../../mixins/mixins.dart';
import '../pages.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with NavigationManager {
  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final localAuthentication = LocalAuthentication();
              final bool isBiometricSupported = await localAuthentication.isDeviceSupported();
              final bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

              bool isAuthenticated = false;

              if (isBiometricSupported && canCheckBiometrics) {
                isAuthenticated = await localAuthentication.authenticate(
                  localizedReason: ' ',
                  biometricOnly: true,
                  stickyAuth: true,
                  androidAuthStrings: const AndroidAuthMessages(
                    biometricHint: '',
                    biometricRequiredTitle: 'Biometria é obrigatória',
                    biometricNotRecognized: 'Não foi possível reconhecer a digital, tente novamente!',
                    biometricSuccess: 'Digital reconhecida com sucesso!',
                    cancelButton: 'Senha',
                    signInTitle: 'Autenticação',
                  ),
                  iOSAuthStrings: const IOSAuthMessages(
                    cancelButton: 'Senha',
                  ),
                );
              }

              if (isAuthenticated) {
                widget.presenter.goToHomePage();
              }
            },
            child: const Text('Entrar'),
          ),
        ),
      ),
    );
  }
}
