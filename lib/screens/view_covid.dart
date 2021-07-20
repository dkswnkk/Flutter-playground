import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/data/updateData.dart';
import 'package:covid19_kr/screens/loading.dart';
import 'package:covid19_kr/views/clearView.dart';
import 'package:covid19_kr/views/deathView.dart';
import 'package:covid19_kr/views/decideView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    String showDay = day[0] +
        day[1] +
        day[2] +
        day[3] +
        '년 ' +
        day[4] +
        day[5] +
        '월 ' +
        day[6] +
        day[7] +
        '일 ';
    showToast("$showDay정보를 갱신했습니다.");

    initalDate = DateTime.parse(day);

    super.initState();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.grey,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void move() async {
    dynamic pickDate = await selectDate(context);
    if (pickDate == null) {
      return null;
    } else if (pickDate.day == DateTime.now().day) {
      if (DateTime.now().hour >= 10) {
        Navigator.pop(context);
        Navigator.push(
            context,
            Transition(
                child: Loading(
                    todayDate: pickDate.add(Duration(hours: 10)),
                    yesterdayDate: pickDate.add(Duration(hours: 10))),
                transitionEffect: TransitionEffect.FADE));
      } else {
        showToast("아직 오늘의 코로나 정보가 집계되지 않았습니다..");
        return null;
      }
    } else {
      pickDate = pickDate.add(Duration(days: 1));
      Navigator.pop(context);

      Navigator.push(
          context,
          Transition(
              child: Loading(todayDate: pickDate, yesterdayDate: pickDate),
              transitionEffect: TransitionEffect.FADE));
    }
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
        centerTitle: true,
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
