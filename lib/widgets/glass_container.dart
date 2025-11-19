import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:yati_portfolio/utils/app_color.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;

  const GlassContainer({
    super.key,
    required this.child,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          // Blur Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(),
          ),

          // Grandient Effect & Widget
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: gradient,
              border: Border.all(color: AppColors.whiteColor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
