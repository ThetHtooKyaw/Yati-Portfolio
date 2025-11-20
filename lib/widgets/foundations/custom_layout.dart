import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;
  const CustomLayout({
    super.key,
    required this.desktop,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1000) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
