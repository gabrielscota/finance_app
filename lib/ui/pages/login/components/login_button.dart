import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

import '../../../mixins/mixins.dart';
import '../login.dart';

class LoginButton extends StatelessWidget with KeyboardManager {
  final LoginPresenter presenter;

  const LoginButton({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StreamBuilder<bool?>(
                  stream: presenter.isFormValidStream,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.hasData && snapshot.data == true
                          ? () {
                              hideKeyboard(context);
                              presenter.auth();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
                        alignment: Alignment.center,
                        fixedSize: const Size(0.0, 56.0),
                      ),
                      child: StreamBuilder<bool?>(
                        stream: presenter.isLoadingStream,
                        builder: (context, isLoadingSnapshot) {
                          if (isLoadingSnapshot.hasData && isLoadingSnapshot.data == true) {
                            return LottieBuilder.asset(
                              Get.isDarkMode
                                  ? 'lib/ui/assets/animations/loading_dark.json'
                                  : 'lib/ui/assets/animations/loading_light.json',
                              fit: BoxFit.fitHeight,
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyLight.login,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  size: 32.0,
                                ),
                                const SizedBox(width: 12.0),
                                Text(
                                  'Entrar',
                                  style: Theme.of(context).textTheme.headline6?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Esqueceu sua senha?',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
          ),
        ],
      ),
    );
  }
}
