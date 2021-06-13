import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BiometricButton extends StatelessWidget {
  const BiometricButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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

        debugPrint('Authentication success: $isAuthenticated');
      },
      child: const Text('Entrar'),
    );
  }
}
