
한국의 코로나 현황을 알려주는 앱
==

Information
--

|코로나 한국|what used|Download|
|-|-|----|
|<img width="59" alt="스크린샷 2021-07-16 오전 2 55 25" src="https://user-images.githubusercontent.com/74492426/125834839-3fe552f7-dbe4-4e6b-abe6-82e770701815.png">|- 코로나 정보: [공공기관 API](https://www.data.go.kr/index.do) 사용<br> - 이미지 정보: 무료로 제공하는 이미지 및 위키피디아 이미지 사용|[구글플레이(안드로이드)](https://play.google.com/store/apps/details?id=com.dkswnzz.covid19_kr)|


Sample Screens
--

|main|site|gif|
|-----|-----|-----|
|<img width="475" alt="스크린샷 2021-07-18 오전 3 47 08" src="https://user-images.githubusercontent.com/74492426/126046807-13e98007-6aee-45f4-b0e2-5f1a74863ffa.png">|<img width="475" alt="스크린샷 2021-07-18 오후 4 23 52" src="https://user-images.githubusercontent.com/74492426/126059242-2a13191a-8ff5-42c9-a863-6e96efa118bb.png">|![Simulator Screen Recording - iPhone 12 Pro Max - 2021-07-19 at 20 50 43](https://user-images.githubusercontent.com/74492426/126155768-79449695-a432-4be8-81c4-ce9055e349e5.gif)|



To Do List
--
>2021.07.16
- [x] api로 xml데이터를 받아와 json으로 변환 후 디코딩하기
- [x] 변동데이터 구현하기 (api에서 지원 x)
- [x] UI 구현 
>2021.07.17
- [x] 날짜 선택시 해당 날의 코로나 정보 불러오기 
>2021.07.18
- [x] 새 날짜 갱신마다 이전 페이지 스택 제거하여 안정성 확보.
- [x] 날짜 선택 취소 시 갱신 되지 않도록 하여 효율성 up.
- [x] 날짜 선택 데이터 불러온 후 다시 날짜 검색 시 날짜 커서가 현재로 초기화되던 불편사항 해결.
- [x] 아래 이미지 클릭시 [기관사이트](http://ncov.mohw.go.kr/) 띄우기.
- [x] 애니메이션 추가하여 자연스럽게 자연스럽게 화면 전환.
- [x] 날짜선택시 해당 날짜와 이전날짜만 데이터를 불러와 로딩속도 향상. 
>2021.07.19
- [x] 날짜갱신시 메세지 출력.
- [x] 구글플레이 앱 제출 [검토중].

>2021.07.20
- [x] 오늘 코로나 정보가 집계되지 않았는데 오늘의 데이터를 불러올 시 앱이 먹통이 되던 현상 해결.
- [x] api 운영계정 등록: 일일트래픽 제한없음, 라이센스 이용허락범위 제한 없음 
<img width="1029" alt="스크린샷 2021-07-20 오전 3 33 08" src="https://user-images.githubusercontent.com/74492426/126209583-cbf6b767-2fe5-47ae-a282-7c225c384f8f.png">

- [x] 안드로이드는 앱바가 왼쪽에 고정되던 문제 해결. 
- [x] Api 정보 미 제공으로 인한 날짜 최초 선택일을 2020, 2, 8 으로 지정

>업데이트 할 것.
- [ ] 앱스토어 출시하기.


