import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jank_free_progress_indicator/jank_free_progress_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    unawaited(_simulateJank());
  }

  Future _simulateJank() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));

      final s = Stopwatch()..start();
      while (s.elapsedMilliseconds < 500) {}
      s.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('jank_free_progress_indicator example'),
        ),
        body: Center(
          child: Container(
            width: 600,
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'CircularProgressIndicator',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'monospace',
                          fontFamilyFallback: ['Courier'],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(width: 32.0),
                          CircularProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.green.withAlpha(85),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2.0,
                          ),
                          SizedBox(width: 32.0),
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      const Text(
                        'LinearProgressIndicator',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'monospace',
                          fontFamilyFallback: ['Courier'],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      const LinearProgressIndicator(),
                      const SizedBox(height: 32.0),
                      LinearProgressIndicator(
                        minHeight: 2.0,
                        color: Colors.orange,
                        backgroundColor: Colors.orange.withAlpha(85),
                      ),
                      const SizedBox(height: 32.0),
                      const LinearProgressIndicator(
                        color: Colors.red,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32.0),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'JankFreeProgressIndicator',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'monospace',
                          fontFamilyFallback: ['Courier'],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const JankFreeProgressIndicator(),
                          const SizedBox(width: 32.0),
                          JankFreeProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.green.withAlpha(85),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          JankFreeProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2.0,
                          ),
                          SizedBox(width: 32.0),
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: JankFreeProgressIndicator(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      const Text(
                        'JankFreeLinearProgressIndicator',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'monospace',
                          fontFamilyFallback: ['Courier'],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      const JankFreeLinearProgressIndicator(),
                      const SizedBox(height: 32.0),
                      JankFreeLinearProgressIndicator(
                        minHeight: 2.0,
                        color: Colors.orange,
                        backgroundColor: Colors.orange.withAlpha(85),
                      ),
                      const SizedBox(height: 32.0),
                      const JankFreeLinearProgressIndicator(
                        color: Colors.red,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
