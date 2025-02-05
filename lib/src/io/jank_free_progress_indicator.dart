import 'package:flutter/material.dart';

class JankFreeProgressIndicator extends StatelessWidget {
  const JankFreeProgressIndicator({
    super.key,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
  });

  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
    );
  }
}
