import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yati_portfolio/utils/app_color.dart';

class LandingTextDesktop extends StatelessWidget {
  final double scrollOffset;
  const LandingTextDesktop({super.key, required this.scrollOffset});

  double _calculateOpacity(double screenHeight) {
    final double startFadeOut = screenHeight * 0.3;
    final double endFadeOut = screenHeight * 0.9;

    if (scrollOffset < startFadeOut) return 1.0;
    if (scrollOffset >= endFadeOut) return 0.0;

    final progress =
        (scrollOffset - startFadeOut) / (endFadeOut - startFadeOut);
    return 1.0 - progress;
  }

  Color _calculateTextColorLerp(double screenHeight) {
    final offScreenPercentage = min(scrollOffset / (screenHeight * 0.7), 1.0);

    final textColor = Color.lerp(
        AppColors.midBrownColor, AppColors.accentColor, offScreenPercentage);
    return textColor!;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive variables
    final double titleSize = (screenWidth * 0.058).clamp(45, 90);
    final double bodySize = (screenWidth * 0.012).clamp(10, 18);

    return AnimatedOpacity(
      opacity: _calculateOpacity(screenHeight),
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              bottom: 60,
              left: screenWidth * 0.03,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Welcome! You\'ve arrived at',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: bodySize,
                      fontFamily: 'Agrandir',
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Text(
                    'KHIN YATI',
                    style: TextStyle(
                      height: 1.2,
                      color: AppColors.whiteColor,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  Text(
                    '        LIN LAI\'s',
                    style: TextStyle(
                      height: 1.2,
                      color: AppColors.whiteColor,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: TextStyle(
                          height: 0.7,
                          color: _calculateTextColorLerp(screenHeight),
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.9,
                          fontFamily: 'Horizon',
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "Connecting people, communication, and experiences with\npurpose and professionalism!",
                        style: TextStyle(
                          height: 1.3,
                          color: AppColors.whiteColor,
                          fontSize: bodySize,
                          fontFamily: 'Agrandir',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Scroll Animation
            Positioned(
              bottom: 0,
              right: 40,
              child: Lottie.asset(
                'assets/animations/scroll.json',
                repeat: true,
                animate: true,
                height: screenWidth * 0.3,
                width: screenWidth * 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
