import 'package:flutter/material.dart';
import 'package:flutter_local_auth_invisible/auth_strings.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class BiometricButton extends StatelessWidget {
  const BiometricButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final localAuthentication = LocalAuthentication();
        final bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

        bool isAuthenticated = false;

        if (canCheckBiometrics) {
          isAuthenticated = await localAuthentication.authenticateWithBiometrics(
            localizedReason: ' ',
            stickyAuth: true,
            // androidAuthStrings: const AndroidAuthMessages(
            //   biometricHint: '',
            //   biometricRequiredTitle: 'Biometria é obrigatória',
            //   biometricNotRecognized: 'Não foi possível reconhecer a digital, tente novamente!',
            //   biometricSuccess: 'Digital reconhecida com sucesso!',
            //   cancelButton: 'Senha',
            //   signInTitle: 'Autenticação',
            // ),
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
