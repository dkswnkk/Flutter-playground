import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/screens/view_covid.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading({this.todayDate, this.yesterdayDate});
  dynamic todayDate;
  dynamic yesterdayDate;
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewCovidScreen(
            covidData_yesterday: yesterdayCovidData,
            covidData_today: todayCovidData),
      ),
    );
  }

  void initState() {
    update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }
}
