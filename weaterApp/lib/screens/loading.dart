import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apiKey = '5708e0b074d1a78dc533872f25f40964';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double latitude3; //위도
  late double longitude3; //경도

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
            parseWeatherData: weatherData, parseAirPollution: airData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: null,
          child: Text('내 위치 얻어오기'),
        ),
      ),
    );
  }
}
