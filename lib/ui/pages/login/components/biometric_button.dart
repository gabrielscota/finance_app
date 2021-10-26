import 'package:flutter/material.dart';

import '../login.dart';

class BiometricButton extends StatelessWidget {
  final LoginBiometricPresenter presenter;
  final Future Function() biometricAuthentication;

  const BiometricButton({
    Key? key,
    required this.presenter,
    required this.biometricAuthentication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: presenter.isLoadingStream,
      builder: (context, isLoadingSnapshot) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          opacity: isLoadingSnapshot.hasData && isLoadingSnapshot.data == true ? 0.0 : 1.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
              alignment: Alignment.center,
              fixedSize: const Size(172.0, 56.0),
            ),
            onPressed: biometricAuthentication,
            child: Text(
              'Entrar',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
