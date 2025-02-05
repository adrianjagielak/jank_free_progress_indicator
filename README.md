# jank_free_progress_indicator

A Flutter package that provides **jank-free** progress indicators (circular and linear) when running
on the web. These custom indicators are powered by CSS transforms that typically continue animating
on the browser’s compositor thread, even if Flutter’s main thread is under heavy load or temporarily
blocked.

![Example](https://raw.githubusercontent.com/adrianjagielak/jank_free_progress_indicator/refs/heads/master/doc/example.gif)

## Why Use This Package?

* **Jank-Free Animations**: The usual Flutter `CircularProgressIndicator`
  or `LinearProgressIndicator` can freeze if the Flutter web engine is blocked, since their
  animations rely on the same rendering pipeline.
* **Pure CSS (GPU-Accelerated)**: By using CSS `transform: rotate(...)`
  or `transform: translate/scale`, we offload the animation to the GPU. This helps maintain smooth
  motion independent of Flutter’s layout/painting cycle.
* **Self-Contained Widgets**: All animations and styles are injected into a
  single `HtmlElementView`, so **no external CSS** or `<head>` modifications are required.
* **Fallback to Native Flutter on Other Platforms**: The widgets detect if running on a non-web
  platform and fallback to the official `CircularProgressIndicator` or `LinearProgressIndicator`,
  ensuring consistent, expected behavior everywhere.

## Installation

1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  jank_free_progress_indicator: ^1.0.0
```

2. Import the package in your Dart code:

```dart
import 'package:jank_free_progress_indicator/jank_free_progress_indicator.dart';
```

## Usage

### JankFreeProgressIndicator (Circular)

```dart
import 'package:flutter/material.dart';
import 'package:jank_free_progress_indicator/jank_free_progress_indicator.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: JankFreeProgressIndicator(
          color: Colors.red,
          backgroundColor: Colors.grey.shade200,
          strokeWidth: 6.0,
        ),
      ),
    );
  }
}
```

* On **web**: Displays the custom CSS-based spinner that continues animating even if Flutter hangs.
* On **mobile** / **desktop** (non-web): Fallback to Flutter’s native `CircularProgressIndicator`.

### JankFreeLinearProgressIndicator (Linear)

```dart
import 'package:flutter/material.dart';
import 'package:jank_free_progress_indicator/jank_free_progress_indicator.dart';

class MyLinearIndicatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: JankFreeLinearProgressIndicator(
          color: Colors.blue,
          backgroundColor: Colors.grey[300],
          height: 5,
        ),
      ),
    );
  }
}
```

* On **web**: Displays the two-bar transform-based linear indeterminate indicator.
* On **other platforms**: Fallback to Flutter’s `LinearProgressIndicator`.

## Limitations

* **Not 100% Material-Exact**
    * The official Material Design spinners manipulate `stroke-dasharray` or element widths.
    * Doing so can freeze under heavy main-thread load. We rely on GPU-friendly transforms, so **the
      animations are close** but **not an identical replica**.
