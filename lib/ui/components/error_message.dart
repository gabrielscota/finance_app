import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showErrorMessage(BuildContext context, String error) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.error,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
      ),
    ),
  );
  Future.delayed(const Duration(milliseconds: 4500), () {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
      ),
    );
  });
}
