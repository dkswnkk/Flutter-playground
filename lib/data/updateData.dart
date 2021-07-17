class UpdateData {
  String? update_time; //기준 시간
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

  void updateData(dynamic covidData_today, dynamic covidData_yesterday) {
    //api 오류로 인한 20210118 ~ 20210420 사이에는 두번째 인덱스의 값을 받아야함.
    update_time =
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
}
