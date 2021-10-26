import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';
import '../../pages.dart';

class GoToSignUp extends StatelessWidget {
  final LoginPresenter presenter;

  const GoToSignUp({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            R.string.dontHaveAccount,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withAlpha(200),
                ),
          ),
          const SizedBox(width: 4.0),
          InkWell(
            onTap: presenter.goToSignUpPage,
            splashColor: Colors.transparent,
            child: Text(
              R.string.addAccount,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
