import 'package:http/http.dart' as http; //여기 as 안해주면 오류가 난다.
import 'dart:convert';

class Network {
  final String url;
  final String url2;
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    try {
      http.Response response = await http.get(
        //이 부분 유의깊게 보기 바람.
        Uri.parse(
          url,
        ),
      );
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } catch (e) {
      print('url 정보 불러오기 실패');
    }
  }

  Future<dynamic> getAirData() async {
    try {
      http.Response response = await http.get(
        //이 부분 유의깊게 보기 바람.
        Uri.parse(
          url2,
        ),
      );
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } catch (e) {
      print('url 정보 불러오기 실패');
    }
  }
}
