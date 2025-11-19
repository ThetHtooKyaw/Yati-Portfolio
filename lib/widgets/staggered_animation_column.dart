import 'package:flutter/material.dart';

class StaggeredAnimationColumn extends StatelessWidget {
  final AnimationController controller;
  final List<Widget> children;
  final double slideYOffset;

  const StaggeredAnimationColumn({
    super.key,
    required this.controller,
    required this.children,
    this.slideYOffset = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final staggerDelay = 1.0 / (children.length + 1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(children.length, (index) {
        final startAnimation = index * staggerDelay;
        final endAnimation = startAnimation + staggerDelay;

        final animation = CurvedAnimation(
          parent: controller,
          curve: Interval(
            startAnimation.clamp(0.0, 1.0),
            endAnimation.clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value,
              child: Transform.translate(
                offset: Offset(0, (1 - animation.value) * slideYOffset),
                child: child,
              ),
            );
          },
          child: children[index],
        );
      }),
    );
  }
}
