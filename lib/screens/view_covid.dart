import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class viewCovidScreen extends StatefulWidget {
  viewCovidScreen({this.covidData_yesterday, this.covidData_today});

  final dynamic covidData_today;
  final dynamic covidData_yesterday;
  @override
  _viewCovidScreenState createState() => _viewCovidScreenState();
}

class _viewCovidScreenState extends State<viewCovidScreen> {
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
  @override
  void initState() {
    updateData(widget.covidData_today, widget.covidData_yesterday);
    super.initState();
  }

  void updateData(dynamic covidData_today, dynamic covidData_yesterday) {
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
    print(real_decide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('한국 코로나 현황'),
        leading: (IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {},
          iconSize: 30.0,
        )),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 53,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "확진자 수",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '총 ' + "$today_decideCnt" + '명',
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          "오늘 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                        ),
                        SvgPicture.asset(
                          'images/Increase_Negative.svg',
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          "$diff_decide",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                        Text(
                          "명 확진 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 53,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "격리해제 수",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '총 ' + "$today_clearCnt" + '명',
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          "오늘 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                        ),
                        SvgPicture.asset(
                          'images/Increase_Positive.svg',
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          "$diff_clear",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "명 해제 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          '남은 확진자 ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$real_decide',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                        Text(
                          '명',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 53,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "사망자 수",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '총 ' + "$today_deathCnt" + '명',
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          "오늘 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                        ),
                        SvgPicture.asset(
                          'images/Increase_Negative.svg',
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          "$diff_death",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                        Text(
                          "명 사망 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
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
