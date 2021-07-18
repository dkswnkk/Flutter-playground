



한국의 코로나 현황을 알려주는 앱
==

What Used
--

|||
|-|-|
|<img width="59" alt="스크린샷 2021-07-16 오전 2 55 25" src="https://user-images.githubusercontent.com/74492426/125834839-3fe552f7-dbe4-4e6b-abe6-82e770701815.png">|- 코로나 정보: [무료 API](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15043376]) 사용<br> - 이미지 정보: 무료로 제공하는 이미지 및 위키피디아 이미지 사용|


Sample Screens
--

|main|site|gif|
|-----|-----|-----|
|<img width="475" alt="스크린샷 2021-07-18 오전 3 47 08" src="https://user-images.githubusercontent.com/74492426/126046807-13e98007-6aee-45f4-b0e2-5f1a74863ffa.png">|<img width="475" alt="스크린샷 2021-07-18 오후 4 23 52" src="https://user-images.githubusercontent.com/74492426/126059242-2a13191a-8ff5-42c9-a863-6e96efa118bb.png">|![Simulator Screen Recording - iPhone 12 Pro Max - 2021-07-18 at 16 22 27](https://user-images.githubusercontent.com/74492426/126059211-461e1b4f-c93b-4ae5-927f-161b322db184.gif)|



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

>업데이트 할 것.
- [ ] 확진자 수, 격리해제 수, 사망자 수 클릭시 각자 일주일치 데이터 그래프로 출력하기.


