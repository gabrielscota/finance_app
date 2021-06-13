import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).colorScheme.error,
    content: Text(
      error,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color: Theme.of(context).colorScheme.onError,
          ),
    ),
  ));
}
