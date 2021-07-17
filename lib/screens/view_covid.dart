import 'package:covid19_kr/data/getCovidData.dart';
import 'package:covid19_kr/data/updateData.dart';
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
  UpdateData update = UpdateData();

  GetCovidData data = GetCovidData();
  DateTime? selectedDate;
  dynamic day;
  @override
  void initState() {
    update.updateData(widget.covidData_today, widget.covidData_yesterday);
    day = update.update_time;
    super.initState();
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
      print(picked);
      return (picked);
    } else {
      print(picked);
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
              DecideView(
                  total: update.today_decideCnt, diff: update.diff_decide),
              SizedBox(
                height: 10,
              ),
              ClearView(
                  total: update.today_clearCnt,
                  diff: update.diff_clear,
                  real: update.real_decide),
              SizedBox(
                height: 10,
              ),
              DeathView(total: update.today_deathCnt, diff: update.diff_death),
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
