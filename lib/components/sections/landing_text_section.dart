import 'package:flutter/material.dart';
import 'package:yati_portfolio/components/desktop/landing_text_desktop.dart';
import 'package:yati_portfolio/widgets/foundations/custom_layout.dart';

class LandingTextSection extends StatelessWidget {
  final double scrollOffset;
  const LandingTextSection({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      desktop: LandingTextDesktop(scrollOffset: scrollOffset),
      mobile: Container(),
    );
  }
}
