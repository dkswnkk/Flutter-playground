import 'package:covid19_kr/screens/loading.dart';
import 'package:covid19_kr/screens/view_covid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

// ignore: must_be_immutable

class MyApp extends StatelessWidget {
  var today = DateTime.now();
  var yesterday = DateTime.now().subtract(Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(todayDate: today, yesterdayDate: yesterday),
        'view': (context) => ViewCovidScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: '한국 코로나 현황',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ko', 'KO'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //  home: Loading(todayDate: today, yesterdayDate: yesterday),
    );
  }
}
