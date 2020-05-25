import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Material(
        child: SafeArea(
          child: OpacityXExample(),
        ),
      ),
    );
  }
}

/// A simple example showing opacity extensions
class OpacityXExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildColoredBox(Colors.red.opacity50),
        buildColoredBox(Colors.red.opacity100),
        buildColoredBox(Colors.red.opacity200),
        buildColoredBox(Colors.red.opacity300),
        buildColoredBox(Colors.red.opacity400),
        buildColoredBox(Colors.red.opacity500),
        buildColoredBox(Colors.red.opacity600),
        buildColoredBox(Colors.red.opacity700),
        buildColoredBox(Colors.red.opacity800),
        buildColoredBox(Colors.red.opacity900),
        SizedBox(height: 20),
        Text("Keep up the good work!"),
      ],
    );
  }

  Widget buildColoredBox(Color color) {
    return Container(
      height: 50,
      width: 50,
      color: color,
    );
  }
}

/// Allows us to change opacity with semantics that match
/// [MaterialColor] shades.
extension ColorOpacityX on Color {
  Color get opacity50 => this.withOpacity(50 / 1000);
  Color get opacity100 => this.withOpacity(100 / 1000);
  Color get opacity200 => this.withOpacity(200 / 1000);
  Color get opacity300 => this.withOpacity(300 / 1000);
  Color get opacity400 => this.withOpacity(400 / 1000);
  Color get opacity500 => this.withOpacity(500 / 1000);
  Color get opacity600 => this.withOpacity(600 / 1000);
  Color get opacity700 => this.withOpacity(700 / 1000);
  Color get opacity800 => this.withOpacity(800 / 1000);
  Color get opacity900 => this.withOpacity(900 / 1000);
}
