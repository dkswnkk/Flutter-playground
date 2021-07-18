import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/data/updateData.dart';
import 'package:covid19_kr/screens/loading.dart';
import 'package:covid19_kr/views/clearView.dart';
import 'package:covid19_kr/views/deathView.dart';
import 'package:covid19_kr/views/decideView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transition/transition.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCovidScreen extends StatefulWidget {
  ViewCovidScreen({this.covidDataYesterday, this.covidDataToday});

  final dynamic covidDataToday;
  final dynamic covidDataYesterday;

  @override
  _ViewCovidScreenState createState() => _ViewCovidScreenState();
}

class _ViewCovidScreenState extends State<ViewCovidScreen> {
  UpdateData update = UpdateData();

  GetCovidData data = GetCovidData();
  DateTime? selectedDate;
  dynamic day;
  DateTime? initalDate;

  @override
  void initState() {
    update.updateData(widget.covidDataToday, widget.covidDataYesterday);
    day = update.updateTime;
    initalDate = DateTime.parse(day);
    super.initState();
  }

  void move() async {
    dynamic pickDate = await selectDate(context);
    if (pickDate == null) return null;

    pickDate = pickDate.add(Duration(days: 1));
    Navigator.pop(context);

    Navigator.push(
        context,
        Transition(
            child: Loading(todayDate: pickDate, yesterdayDate: pickDate),
            transitionEffect: TransitionEffect.FADE));
  }

  _goURL() async {
    const url = 'http://ncov.mohw.go.kr/bdBoardList_Real.do';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initalDate!,
      firstDate: new DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(
        () => selectedDate = picked,
      );
      return (picked);
    } else {
      return (null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('한국 코로나 현황'),
            Text(
              "$day",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ],
        ),
        leading: (IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            move();
          },
          iconSize: 30.0,
        )),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DecideView(total: update.todayDecideCnt, diff: update.diffDecide),
              SizedBox(
                height: 10,
              ),
              ClearView(
                  total: update.todayClearCnt,
                  diff: update.diffClear,
                  real: update.realDecide),
              SizedBox(
                height: 10,
              ),
              DeathView(total: update.todayDeathCnt, diff: update.diffDeath),
              TextButton(
                child: SizedBox(
                  height: 250,
                  width: 200,
                  child: SvgPicture.asset(
                    'images/covid-19.svg',
                    width: 200,
                    height: 200,
                  ),
                ),
                onPressed: () {
                  _goURL();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
