import 'package:flutter/material.dart';

class JankFreeLinearProgressIndicator extends StatelessWidget {
  const JankFreeLinearProgressIndicator({
    super.key,
    this.color,
    this.backgroundColor,
    this.minHeight,
  }) : assert(minHeight == null || minHeight > 0);

  final Color? color;
  final Color? backgroundColor;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: color,
      backgroundColor: backgroundColor,
      minHeight: minHeight,
    );
  }
}
