import 'package:flutter/material.dart';

class ObstacleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width / 2, height / 2);
    path.lineTo(0, height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}

class LeftWallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    double curvePoint = 0;
    Path path = Path();
    path.lineTo(0, 0);
    for (int i = 1; curvePoint <= height; i++) {
      curvePoint += width;
      path.lineTo(i % 2 == 0 ? width / 2 : width, curvePoint);
    }
    path.lineTo(0, height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}

class RightWallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    double curvePoint = 0;
    Path path = Path();
    path.lineTo(width, 0);
    for (int i = 1; curvePoint <= height; i++) {
      curvePoint += width;
      path.lineTo(i % 2 == 0 ? width / 2 : 0, curvePoint);
    }
    path.lineTo(width, height);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
