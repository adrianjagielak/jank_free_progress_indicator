import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'utils.dart';

class JankFreeLinearProgressIndicator extends StatefulWidget {
  const JankFreeLinearProgressIndicator({
    super.key,
    this.color,
    this.backgroundColor,
    this.minHeight,
  }) : assert(minHeight == null || minHeight > 0);

  final Color? color;
  final Color? backgroundColor;
  final double? minHeight;

  Color _getValueColor(
    BuildContext context, {
    required Color defaultColor,
  }) {
    return color ?? ProgressIndicatorTheme.of(context).color ?? defaultColor;
  }

  @override
  State<JankFreeLinearProgressIndicator> createState() => _JankFreeLinearProgressIndicatorState();
}

class _JankFreeLinearProgressIndicatorState extends State<JankFreeLinearProgressIndicator> {
  static const String _viewId = 'jank-free-linear-progress';

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
        final double height = paramsList[2];

        return _createElement(
          color,
          trackColor,
          height,
        );
      },
    );
  }

  static html.Element _createElement(
    String color,
    String trackColor,
    double height,
  ) {
    return html.Element.html(
      '''
      <div style="
          width: 100%;
          height: ${height}px;
          background: $trackColor;
          position: relative;
          overflow: hidden;
        "
      >
        <!-- Bar 1 -->
        <div style="
          position: absolute;
          left: 0; top: 0; bottom: 0;
          background: $color;
          transform-origin: left center;
          animation: indeterminate1 2s linear infinite;
          width: 100%; /* let scaleX reduce actual visible width */
        "></div>
        
        <!-- Bar 2 -->
        <div style="
          position: absolute;
          left: 0; top: 0; bottom: 0;
          background: $color;
          transform-origin: left center;
          animation: indeterminate2 2s linear infinite;
          width: 100%;
        "></div>
        
        <style>
          /* 
            Keyframes for the two bars, purely using translate+scale transforms.
            The numeric values here mimic the default MD movement/timings.
          */
          @keyframes indeterminate1 {
            0% {
              transform: translateX(-40%) scaleX(0.2);
            }
            20% {
              transform: translateX(0%) scaleX(0.3);
            }
            50% {
              transform: translateX(40%) scaleX(0.6);
            }
            100% {
              transform: translateX(100%) scaleX(0.0);
            }
          }

          @keyframes indeterminate2 {
            0% {
              transform: translateX(-40%) scaleX(0.2);
            }
            50% {
              transform: translateX(40%) scaleX(0.6);
            }
            100% {
              transform: translateX(100%) scaleX(0.0);
            }
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

    final ProgressIndicatorThemeData indicatorTheme = ProgressIndicatorTheme.of(context);
    final Color trackColor = widget.backgroundColor ??
        indicatorTheme.linearTrackColor ??
        (Theme.of(context).useMaterial3
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.surface);
    final double minHeight = widget.minHeight ?? indicatorTheme.linearMinHeight ?? 4.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double height = math.min(minHeight, constraints.maxHeight);

        return SizedBox(
          height: height,
          width: double.infinity,
          child: HtmlElementView(
            viewType: _viewId,
            // creationParams must be a JS-compatible type
            creationParams: [
              colorToCssColor(
                widget._getValueColor(context, defaultColor: defaultColor),
              ),
              colorToCssColor(trackColor),
              height,
            ],
          ),
        );
      },
    );
  }
}
