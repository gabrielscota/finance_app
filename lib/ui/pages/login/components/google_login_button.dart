import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../pages.dart';

class GoogleLoginButton extends StatelessWidget {
  final LoginPresenter presenter;

  const GoogleLoginButton({required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: presenter.authWithGoogle,
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.surface,
          elevation: 2.0,
          shadowColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/ui/assets/icons/google.svg',
              height: 24.0,
              width: 24.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              'Entrar com o Google',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
