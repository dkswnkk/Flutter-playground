import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';

const apiKey =
    'DMMWe2bJm7rS%2FA4eQ1ZQkHW1vXSFToMh0ZaOXls2ahp%2BrbGtnjMGyGZt1S7pU1oeLvViaiUUY6JGIbotsDFkCg%3D%3D';

class GetCovidData {
  var today = DateTime.now();
  var yesterday = DateTime.now().subtract(Duration(days: 1));

  Future<dynamic> getTodayXmlData() async {
    if (today.hour < 10) {
      //api가 매일 09:35분에 갱신되기 때문에 그 이전 시간에는 전날의 기록을 가져온다.
      today = DateTime.now().subtract(Duration(days: 1));
      yesterday = DateTime.now().subtract(Duration(days: 2));
    }

    var inputDate = DateFormat('yyyyMMdd').format(today);
    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=$apiKey&pageNo=1&numOfRows=10&startCreateDt=20200103&endCreateDt=$inputDate'),
      );

      final covidStatusXml = response.body; //xml데이터 받아오기
      final xml2JsonData = Xml2Json()..parse(covidStatusXml); //xml을 jsom으로 변환
      final jsonData = xml2JsonData.toParker(); //형식옵션
      print('데이터 불러오기 성공');
      return jsonDecode(jsonData);
    } catch (e) {
      print('데이터 불러오기 실패');
    }
  }

  Future<dynamic> getYesterdayXmlData() async {
    var inputDate = DateFormat('yyyyMMdd').format(yesterday);

    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=$apiKey&pageNo=1&numOfRows=10&startCreateDt=20200103&endCreateDt=$inputDate'),
      );

      final covidStatusXml = response.body; //xml데이터 받아오기
      final xml2JsonData = Xml2Json()..parse(covidStatusXml); //xml을 jsom으로 변환
      final jsonData = xml2JsonData.toParker(); //형식옵션
      print('데이터 불러오기 성공');
      return jsonDecode(jsonData);
    } catch (e) {
      print('데이터 불러오기 실패');
    }
  }
}
