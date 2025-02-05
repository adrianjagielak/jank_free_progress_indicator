import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'utils.dart';

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
class JankFreeProgressIndicator extends StatefulWidget {
  const JankFreeProgressIndicator({
    super.key,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
  });

  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;

  Color _getValueColor(
    BuildContext context, {
    required Color defaultColor,
  }) {
    return color ?? ProgressIndicatorTheme.of(context).color ?? defaultColor;
  }

  @override
  State<JankFreeProgressIndicator> createState() =>
      _JankFreeProgressIndicatorState();
}

class _JankFreeProgressIndicatorState extends State<JankFreeProgressIndicator> {
  static const String _viewId = 'jank-free-progress-indicator';

  @override
  void initState() {
    super.initState();
    ui.platformViewRegistry.registerViewFactory(
      _viewId,
      (
        int id, {
        Object? params,
      }) {
        final List paramsList = params! as List;

        final String color = paramsList[0];
        final String trackColor = paramsList[1];
        final double width = paramsList[2];
        final double height = paramsList[3];
        final double strokeWidth = paramsList[4];

        return _createElement(
          color,
          trackColor,
          width,
          height,
          strokeWidth,
        );
      },
    );
  }

  static html.Element _createElement(
    String color,
    String trackColor,
    double width,
    double height,
    double strokeWidth,
  ) {
    // ignore: unsafe_html
    return html.Element.html(
      '''
      <div style="
          width: ${width - strokeWidth}px;
          height: ${height - strokeWidth}px;
          border: ${strokeWidth}px solid $trackColor;
          border-top: ${strokeWidth}px solid $color;
          border-right: ${strokeWidth}px solid $color;
          border-radius: 50%;
          animation: spin 1s linear infinite;
          position: absolute;
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
        ">
        <style>
          @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
          }
        </style>
      </div>
      ''',
      treeSanitizer: html.NodeTreeSanitizer.trusted,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Theme.of(context).colorScheme.primary;
    final Color? trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = math.min(36.0, constraints.maxWidth);
        final double height = math.min(36.0, constraints.maxHeight);

        return SizedBox(
          width: width,
          height: height,
          child: HtmlElementView(
            viewType: _viewId,
            // creationParams must be a JS-compatible type
            creationParams: [
              colorToCssColor(
                widget._getValueColor(context, defaultColor: defaultColor),
              ),
              colorToCssColor(trackColor ?? Colors.transparent),
              width,
              height,
              widget.strokeWidth,
            ],
          ),
        );
      },
    );
  }
}
