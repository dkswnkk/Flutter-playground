import 'package:flutter/material.dart';
import 'screens/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '날씨 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loading(),
    );
  }
}
