import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/screens/view_covid.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

class Loading extends StatefulWidget {
  Loading({this.todayDate, this.yesterdayDate});
  final todayDate;
  final yesterdayDate;
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  GetCovidData data = GetCovidData();

  void update() async {
    dynamic todayCovidData =
        await data.getTodayXmlData(widget.todayDate, widget.yesterdayDate);
    dynamic yesterdayCovidData =
        await data.getYesterdayXmlData(widget.todayDate, widget.yesterdayDate);
    Navigator.pop(context);
    Navigator.push(
        context,
        Transition(
            child: ViewCovidScreen(
                covidDataYesterday: yesterdayCovidData,
                covidDataToday: todayCovidData),
            transitionEffect: TransitionEffect.FADE));
  }

  void initState() {
    update();
    super.initState();
  }

//child: Loading(todayDate: pickDate, yesterdayDate: pickDate),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }
}
