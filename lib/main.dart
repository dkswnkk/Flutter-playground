import 'package:covid19_kr/screens/loading.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '한국 코로나 현황',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loading(),
    );
  }
}
