
한국의 코로나 현황을 알려주는 앱
==

What Used
--

|||
|-|-|
|<img width="59" alt="스크린샷 2021-07-16 오전 2 55 25" src="https://user-images.githubusercontent.com/74492426/125834839-3fe552f7-dbe4-4e6b-abe6-82e770701815.png">|- 코로나 정보: [무료 API](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15043376]) 사용<br> - 이미지 정보: 무료로 제공하는 이미지 및 위키피디아 이미지 사용|


Sample Screens
--

|screens||
|-----|-----|
|<img width="475" alt="스크린샷 2021-07-16 오후 7 50 25" src="https://user-images.githubusercontent.com/74492426/125936750-3da088b4-b737-408b-af50-21ef17fe9a8f.png">|<img width="475" alt="스크린샷 2021-07-16 오후 7 51 01" src="https://user-images.githubusercontent.com/74492426/125936831-fca69a28-2805-43ac-9547-8c76abdfaa6a.png">|







To Do List
--
- [x] api로 xml데이터를 받아와 json으로 변환 후 디코딩하기
- [x] 변동데이터 구현하기 (api에서 지원 x)
- [x] 날짜 선택시 해당 날의 코로나 정보 불러오기 (api 문제로 인해 20210118 ~ 20210420 날짜 사이의 값을 받아오지 못함.) 
- [x] 2021.07.18 -> 새 날짜 갱신마다 이전 페이지 스택 제거하여 안정성 확보. 
- [ ] 최근 일주일간의 데이터 그래프로 출력하기


