import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
                      child: StreamBuilder<bool?>(
                        stream: presenter.isLoadingStream,
                        builder: (context, isLoadingSnapshot) {
                          if (isLoadingSnapshot.hasData && isLoadingSnapshot.data == true) {
                            return SizedBox(
                              height: 32.0,
                              child: LottieBuilder.asset(
                                Get.isDarkMode
                                    ? 'lib/ui/assets/animations/loading_dark.json'
                                    : 'lib/ui/assets/animations/loading_light.json',
                                fit: BoxFit.fitHeight,
                              ),
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'lib/ui/assets/icons/login.svg',
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: 10.0),
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
