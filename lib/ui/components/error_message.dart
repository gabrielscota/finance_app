import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void showErrorMessage(BuildContext context, String error) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.error,
    ),
  );
  Get.showSnackbar(
    GetBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      messageText: Text(
        error,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
      ),
      duration: const Duration(milliseconds: 1900),
      animationDuration: const Duration(milliseconds: 1200),
      isDismissible: false,
    ),
  );
  Future.delayed(const Duration(milliseconds: 2800), () {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
      ),
    );
  });
}
