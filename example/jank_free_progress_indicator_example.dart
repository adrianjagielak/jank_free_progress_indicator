import 'package:flutter/material.dart';
import 'package:jank_free_progress_indicator/jank_free_progress_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('jank_free_progress_indicator example'),
        ),
        body: const Column(
          children: [
            JankFreeProgressIndicator(),
            SizedBox(height: 32.0),
            JankFreeLinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
