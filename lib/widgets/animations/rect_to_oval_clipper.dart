import 'dart:math';
import 'package:flutter/material.dart';

class RectToOvalClipper extends CustomClipper<Path> {
  final double progress;
  final double rotationAngle;

  RectToOvalClipper({required this.progress, this.rotationAngle = 0.0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;
    double centerX = w / 2;
    double centerY = h / 2;

    if (progress == 0.0) {
      // Full rectangle
      path.addRect(Rect.fromLTWH(0, 0, w, h));
    } else if (progress == 1.0) {
      // Rotated ellipse
      double finalWidth = w * (1.0 - 0.2); // 80%
      double finalHeight = h * (1.0 - 0.2); // 80%
      path = _createRotatedEllipse(centerX, centerY, finalWidth * 0.5,
          finalHeight * 0.52, rotationAngle);
    } else {
      double easedProgress = Curves.easeInOutQuad.transform(progress);

      // Oval Size Adjustment
      double currentWidth = w * (1.0 - easedProgress * 0.2); // 80%
      double currentHeight = h * (1.0 - easedProgress * 0.2); // 80%

      // Rotation
      double currentRotation = rotationAngle * easedProgress;

      // Border Radius
      double maxRadius = min(currentWidth, currentHeight) / 2;
      double radiusMultiplier = 0.3 + (easedProgress - 0.19) * 1.5;
      double currentRadius = maxRadius * radiusMultiplier.clamp(0.0, 1.0);

      if (easedProgress < 0.9) {
        // Apply Border Radius
        Path rectPath = Path();
        rectPath.addRRect(RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(centerX, centerY),
            width: currentWidth,
            height: currentHeight,
          ),
          Radius.circular(currentRadius),
        ));

        // Apply rotation
        if (currentRotation != 0.0) {
          Matrix4 matrix = Matrix4.identity()
            ..translate(centerX, centerY)
            ..rotateZ(currentRotation)
            ..translate(-centerX, -centerY);
          path = rectPath.transform(matrix.storage);
        } else {
          path = rectPath;
        }
      } else {
        // Final stage: perfect rotated oval
        path = _createRotatedEllipse(centerX, centerY, currentWidth * 0.5,
            currentHeight * 0.52, currentRotation);
      }
    }

    return path;
  }

  Path _createRotatedEllipse(double centerX, double centerY, double radiusX,
      double radiusY, double angle) {
    Path path = Path();

    // Create ellipse points
    List<Offset> points = [];
    for (int i = 0; i <= 360; i += 5) {
      double radian = i * pi / 180;
      double x = radiusX * cos(radian);
      double y = radiusY * sin(radian);

      // Apply rotation
      double rotatedX = x * cos(angle) - y * sin(angle);
      double rotatedY = x * sin(angle) + y * cos(angle);

      points.add(Offset(centerX + rotatedX, centerY + rotatedY));
    }

    // Create ellipse shape
    if (points.isNotEmpty) {
      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
