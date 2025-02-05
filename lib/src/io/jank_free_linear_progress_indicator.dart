import 'package:flutter/material.dart';

/// A widget that displays a jank-free linear progress indicator on the web,
/// fallback to [LinearProgressIndicator] on other platforms.
///
/// This linear indicator animates using only CSS transforms (translate/scale),
/// which are typically handled by the browser's GPU compositor. As a result,
/// it won't freeze as easily when the Flutter Web main thread is busy.
///
/// While it approximates the Material Design indeterminate animation, it may
/// not exactly match the official spec since stroke-dash or width-based
/// animations often require main-thread paint.
///
/// {@tool snippet}
/// ```dart
/// JankFreeLinearProgressIndicator(
///   color: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
///   height: 4,
/// )
/// ```
/// {@end-tool}
///
/// See also:
///  * [LinearProgressIndicator], the default Flutter widget on non-web platforms.
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
