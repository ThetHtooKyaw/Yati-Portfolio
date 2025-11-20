import 'package:flutter/material.dart';
import 'package:yati_portfolio/widgets/foundations/custom_layout.dart';
import '../desktop/about_desktop.dart';

class AboutSection extends StatelessWidget {
  final double scrollOffset;
  const AboutSection({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      desktop: AboutDesktop(scrollOffset: scrollOffset),
      mobile: Container(),
    );
  }
}
