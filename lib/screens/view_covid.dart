import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/screens/loading.dart';
import 'package:covid19_kr/views/clearView.dart';
import 'package:covid19_kr/views/deathView.dart';
import 'package:covid19_kr/views/decideView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewCovidScreen extends StatefulWidget {
  ViewCovidScreen({this.covidData_yesterday, this.covidData_today});

  final dynamic covidData_today;
  final dynamic covidData_yesterday;

  @override
  _ViewCovidScreenState createState() => _ViewCovidScreenState();
}

class _ViewCovidScreenState extends State<ViewCovidScreen> {
  String? upadate_time; //기준 시간
  String? today_deathCnt; //오늘 총 사망 수
  String? today_decideCnt; //오늘 총 확진자 수
  String? today_clearCnt; //오늘 누적 격리해제 수
  String? yesterday_deathCnt; //어제 총 사망 수
  String? yesterday_decideCnt; //어제 총 확진자 수
  String? yesterday_clearCnt; //어제 총 격리 해제 수
  int? diff_death; //사망자 수 변동
  int? diff_decide; //확진자 수 변동
  int? diff_clear; //격리해제 변동 수
  int? real_decide; //남은확진자 = 총 확진자 - 격리해제 자

  GetCovidData data = GetCovidData();
  DateTime? selectedDate;

  @override
  void initState() {
    updateData(widget.covidData_today, widget.covidData_yesterday);

    super.initState();
  }

  void updateData(dynamic covidData_today, dynamic covidData_yesterday) {
    upadate_time =
        covidData_today['response']['body']['items']['item'][0]['stateDt'];
    today_deathCnt =
        covidData_today['response']['body']['items']['item'][0]['deathCnt'];
    today_decideCnt =
        covidData_today['response']['body']['items']['item'][0]['decideCnt'];
    today_clearCnt =
        covidData_today['response']['body']['items']['item'][0]['clearCnt'];
    yesterday_deathCnt =
        covidData_yesterday['response']['body']['items']['item'][0]['deathCnt'];
    yesterday_decideCnt = covidData_yesterday['response']['body']['items']
        ['item'][0]['decideCnt'];
    yesterday_clearCnt =
        covidData_yesterday['response']['body']['items']['item'][0]['clearCnt'];

    diff_death =
        int.parse(today_deathCnt!) - int.parse(yesterday_deathCnt!); //변동 사망자 수
    diff_decide = int.parse(today_decideCnt!) -
        int.parse(yesterday_decideCnt!); //변동 확진자 수
    diff_clear = int.parse(today_clearCnt!) -
        int.parse(yesterday_clearCnt!); //변동 격리해제자 수
    real_decide = int.parse(today_decideCnt!) - int.parse(today_clearCnt!);
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      return (picked);
    } else {
      return (picked);
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
              '$upadate_time',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ],
        ),
        leading: (IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            dynamic pickDate = await selectDate(context);
            pickDate = pickDate.add(Duration(days: 1));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Loading(todayDate: pickDate, yesterdayDate: pickDate),
              ),
            );
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
              DecideView(total: today_decideCnt, diff: diff_decide),
              SizedBox(
                height: 10,
              ),
              ClearView(
                  total: today_clearCnt, diff: diff_clear, real: real_decide),
              SizedBox(
                height: 10,
              ),
              DeathView(total: today_deathCnt, diff: diff_death),
              SizedBox(
                height: 280,
                width: 200,
                child: SvgPicture.asset(
                  'images/covid-19.svg',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
