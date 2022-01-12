class UpdateData {
  String? updateTime; //기준 시간
  String? todayDeathCnt; //오늘 총 사망 수
  String? todayDecideCnt; //오늘 총 확진자 수
  String? todayClearCnt; //오늘 누적 격리해제 수
  String? yesterdayDeathCnt; //어제 총 사망 수
  String? yesterdayDecideCnt; //어제 총 확진자 수
  String? yesterdayClearCnt; //어제 총 격리 해제 수
  int? diffDeath; //사망자 수 변동
  int? diffDecide; //확진자 수 변동
  int? diffClear; //격리해제 변동 수
  int? realDecide; //남은확진자 = 총 확진자 - 격리해제 자

  void updateData(dynamic covidDataToday, dynamic covidDataYesterday) {
    //api 오류로 인한 20210118 ~ 20210420 사이에는 두번째 인덱스의 값을 받아야함.
    updateTime =
        covidDataToday['response']['body']['items']['item'][0]['stateDt'];
    todayDeathCnt =
        covidDataToday['response']['body']['items']['item'][0]['deathCnt'];
    todayDecideCnt =
        covidDataToday['response']['body']['items']['item'][0]['decideCnt'];
    todayClearCnt =
        covidDataToday['response']['body']['items']['item'][0]['clearCnt'];
    yesterdayDeathCnt =
        covidDataYesterday['response']['body']['items']['item'][1]['deathCnt'];
    yesterdayDecideCnt =
        covidDataYesterday['response']['body']['items']['item'][1]['decideCnt'];
    yesterdayClearCnt =
        covidDataYesterday['response']['body']['items']['item'][1]['clearCnt'];

    diffDeath =
        int.parse(todayDeathCnt!) - int.parse(yesterdayDeathCnt!); //변동 사망자 수
    diffDecide =
        int.parse(todayDecideCnt!) - int.parse(yesterdayDecideCnt!); //변동 확진자 수
    diffClear =
        int.parse(todayClearCnt!) - int.parse(yesterdayClearCnt!); //변동 격리해제자 수
    realDecide = int.parse(todayDecideCnt!) - int.parse(todayClearCnt!);
  }
}
