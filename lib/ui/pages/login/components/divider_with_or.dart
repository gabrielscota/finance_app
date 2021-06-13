import 'package:flutter/material.dart';

class DividerWithOr extends StatelessWidget {
  const DividerWithOr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(1.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'ou',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Theme.of(context).dividerColor,
                ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(1.0),
            ),
          ),
        ),
      ],
    );
  }
}
