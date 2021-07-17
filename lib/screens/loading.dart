import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/screens/view_covid.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
    Navigator.pop(context, 'view');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewCovidScreen(
            covidDataYesterday: yesterdayCovidData,
            covidDataToday: todayCovidData),
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
