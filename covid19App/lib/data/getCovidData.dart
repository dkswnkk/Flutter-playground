import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';

const apiKey =
    'Your api';

class GetCovidData {
  dynamic todayDate;
  dynamic yesterdayDate;
  Future<dynamic> getTodayXmlData(dynamic today, dynamic yesterday) async {
    if (today.hour < 10) {
      //api가 매일 09:35분에 갱신되기 때문에 그 이전 시간에는 전날의 기록을 가져온다.
      todayDate = today.subtract(Duration(days: 1));

      yesterdayDate = today.subtract(Duration(days: 2));
    } else {
      todayDate = today;
      yesterdayDate = today.subtract(Duration(days: 1));
    }

    var inputTodayDate = DateFormat('yyyyMMdd').format(todayDate);
    var inputYesterdayDate = DateFormat('yyyyMMdd').format(yesterdayDate);
    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=$apiKey&pageNo=1&numOfRows=10&startCreateDt=$inputYesterdayDate&endCreateDt=$inputTodayDate'),
      );

      final covidStatusXml = response.body; //xml데이터 받아오기
      final xml2JsonData = Xml2Json()..parse(covidStatusXml); //xml을 json으로 변환
      final jsonData = xml2JsonData.toParker(); //형식옵션
      print('오늘의 데이터 불러오기 성공');
      return jsonDecode(jsonData);
    } catch (e) {
      print('오늘의 데이터 불러오기 실패');
    }
  }

  Future<dynamic> getYesterdayXmlData(dynamic today, dynamic yesterday) async {
    if (today.hour < 10) {
      //api가 매일 09:35분에 갱신되기 때문에 그 이전 시간에는 전날의 기록을 가져온다.
      today = today.subtract(Duration(days: 1));

      yesterday = today.subtract(Duration(days: 2));
    } else {
      todayDate = today;
      yesterdayDate = today.subtract(Duration(days: 1));
    }

    var inputTodayDate = DateFormat('yyyyMMdd').format(todayDate);
    var inputYesterdayDate = DateFormat('yyyyMMdd').format(yesterdayDate);
    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=$apiKey&pageNo=1&numOfRows=10&startCreateDt=$inputYesterdayDate&endCreateDt=$inputTodayDate'),
      );

      final covidStatusXml = response.body; //xml데이터 받아오기
      final xml2JsonData = Xml2Json()..parse(covidStatusXml); //xml을 jsom으로 변환
      final jsonData = xml2JsonData.toParker(); //형식옵션
      print('어제의 데이터 불러오기 성공');
      return jsonDecode(jsonData);
    } catch (e) {
      print('어제의 데이터 불러오기 실패');
    }
  }
}
