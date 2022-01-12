import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityName;
  int? temp;
  var date = DateTime.now();
  Widget? icon; //날씨 모양
  late String des; //날씨 설명
  Widget? airIcon;
  Widget? airState;
  late double dust1, dust2; //dust1=미세먼지, dust2=초미세먼지

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    cityName = weatherData['name'];
    temp = weatherData['main']['temp'].toInt();
    int condition = weatherData['weather'][0]['id'];
    icon = model.getWeatherIcon(condition);
    des = weatherData['weather'][0]['description'];
    dynamic index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
  }

  String? getSystemTime() {
    var now = DateTime.now();
    return DateFormat(" H:mm").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //body를 앱바 까지 확장

      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            //앱 바 좌측
            icon: Icon(Icons.near_me),
            onPressed: () {},
            iconSize: 30.0),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {},
            iconSize: 30.0,
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 150.0),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  DateFormat('MM월 dd일').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                                Text(
                                  DateFormat(', EE').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                                TimerBuilder.periodic(
                                  Duration(minutes: 1),
                                  builder: (context) {
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 18.0, color: Colors.white),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                icon!,
                                SizedBox(width: 10.0),
                                Text(
                                  '$des',
                                  style: GoogleFonts.lato(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 3.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질 지수)',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              airIcon!,
                              SizedBox(height: 10.0),
                              airState!,
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '$dust1',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '㎍/㎥',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '$dust2',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '㎍/㎥',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
