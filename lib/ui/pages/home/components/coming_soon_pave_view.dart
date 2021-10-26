import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:particles_flutter/particles_flutter.dart';

class CommingSoonPageView extends StatelessWidget {
  const CommingSoonPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CircularParticle(
          key: UniqueKey(),
          awayRadius: 32,
          numberOfParticles: 64,
          speedOfParticles: 0.6,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          onTapAnimation: true,
          particleColor: Theme.of(context).colorScheme.primaryVariant,
          randColorList: [
            Theme.of(context).colorScheme.primary,
          ],
          awayAnimationDuration: const Duration(milliseconds: 100),
          maxParticleSize: 6,
          isRandSize: true,
          isRandomColor: false,
          awayAnimationCurve: Curves.easeInOutBack,
          enableHover: true,
          hoverColor: Colors.white,
          hoverRadius: 90,
          connectDots: true,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconlyLight.time_circle,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 32.0,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Coming soon...',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
