import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Text(
        'Fi-Nance',
        style: Theme.of(context).textTheme.headline3?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
