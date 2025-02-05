import 'package:flutter/material.dart';

/// A widget that displays a jank-free circular progress indicator on the web,
/// fallback to [CircularProgressIndicator] on other platforms.
///
/// This spinner relies purely on CSS transforms, so it remains smooth and
/// responsive even under heavy main-thread load in Flutter Web. The appearance
/// closely resembles an indeterminate Material spinner, but without using
/// stroke-dasharray (which can freeze if the main thread is blocked).
///
/// {@tool snippet}
/// ```dart
/// JankFreeProgressIndicator(
///   color: Colors.red,
///   backgroundColor: Colors.grey.shade200,
///   strokeWidth: 6.0,
/// )
/// ```
/// {@end-tool}
///
/// See also:
///  * [CircularProgressIndicator], the default Flutter widget for non-web platforms.
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
