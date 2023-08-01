## 박스오피스
> 프로젝트 기간: 23/07/24 ~ 23/08/04

## 📂 목차
1. [팀원](#1.)
2. [타임 라인](#2.)
3. [실행 화면](#3.)
4. [트러블 슈팅](#4.)
5. [팀 회고](#5.)
6. [참고 문서](#6.)

## 1. 팀원
<a id="1."></a>
| Jusbug | Redmango |
| :--------: | :--------: |
| <Img src = "https://github.com/JusBug/ios-box-office/assets/125210310/549c2726-aa5a-48cc-a39a-7c10d10bdda5" width="200" height="200"> | <Img src = "https://github.com/JusBug/ios-box-office/assets/125210310/c1a12752-eda0-4c4d-8a58-0cc8dccd7707"  width="200" height="200"> |
|[Github Profile](https://github.com/JusBug) |[Github Profile](https://github.com/redmango1447) |
- - -
<a id="2."></a>

## 2. 타임라인

### 2023.07.24.(월)
- BoxOffice 데이터 타입 구현
- JSONDecodingHelper 구현

### 2023.07.25.(화)
- Unit Test 케이스 구현

### 2023.07.26.(수)
- API서버와 통신하는 APIManager 타입 구현
- fetchData() 구현
- Completion Handler 생성

### 2023.07.27.(목)
- Movie 데이터 타입 구현
- Test Double 공부

### 2023.07.28.(금)
- 조회할 대상인 Service 타입 구현
- URLrequest 생략
- fetchData()에 Service type에 따른 분기처리
- 제네릭 DecodeJSON() 메서드 생성

### 2023.07.31.(월)

### 2023.08.01.(화)

### 2023.08.02.(수)

### 2023.08.03.(목)

### 2023.08.04.(금)

<a id="3."></a>

## 3. 실행 화면


</br>
<a id="4."></a>

## 4. 트러블 슈팅

### <데이터 타입 구현>

🤯 **문제상황**
일일 박스오피스의 데이터 형식이 크게 boxOfficeType, showRange, dailyBoxOfficeList로 이루어져 있고 dailyBoxOfficeList 배열 안에 Rank number 순으로 그 안에서 영화들의 각 데이터 요소들을 관리하고 있는데, 처음에는 배열 안의 데이터만 구현할 것인지 아니면 전체 구조를 가져오는 타입을 구현할지 고민하게 되었습니다.
```Swift
struct MovieInfo: Decodable {
    let rankNumber: String
    let rank: String
    let rankInten: String
    ...
```

🔥 **해결방법**
애초에 json파일을 파싱하는 과정에서 json의 데이터 구조와 구조체에 구현한 타입 구조가 다르게 되면 디코딩 에러가 발생하는 이슈가 있었기 때문에 구조를 같게 타입을 구현해 주며 해결하였습니다.
```Swift
struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeInfo
}

struct BoxOfficeInfo: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfo]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct MovieInfo: Decodable {
    let rankNumber: String
    let rank: String
    let rankInten: String
    ...
```
- - -
### <HTTP 연결 이슈>

🤯 **문제상황** 
ATP 보안 기능으로 인해 HTTP에 대한 접근이 차단되어 테스트를 진행할 수 없었습니다.
![](https://hackmd.io/_uploads/rktGMWAqn.png)

🔥 **해결방법**
ATP에 도메인을 추가하여 해당 도메인에 HTTP에 대한 연결을 허용할 수 있도록 설정해주면서 해결할 수 있었습니다.
![](https://hackmd.io/_uploads/rynMz-R9h.png)

### <재활용성 이슈>

🤯 **문제상황**
요구사항에선
> 1. 오늘의 일일 박스오피스 조회
> 2. 영화 개별 상세 조회

위와같이 2가지의 데이터를 받아오길 원했습니다.
처음엔 매개변수로 URLString을 넘겨줄까했지만 URL이 너무 길어 가독성이 상당히 떨어지는 문제가 있었고, 기존에는 조회할 타입을 직접 넣어서 메서드를 구현했기 때문에 여러 타입의 정보를 가져올 수 있는 재활용성 측면에서 부족한 코드였습니다.

🔥 **해결방법**

enum으로 Service타입을 만든뒤 사용하는 쪽에선 매개변수로 Service를 받게하여 해결하였습니다.
```swift
enum Service: String {
    case dailyBoxOffice = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=202a30725"
    case movieDetailInfo = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=9edeb739e275f3013ffb896c2ff41cfe&targetDt=20230724"
    
    var type: Any {
        switch self {
        case .dailyBoxOffice:
            return BoxOffice.self
        case .movieDetailInfo:
            return Movie.self
        }
    }
}

func fetchData(service: Service, completion: @escaping (Data?) -> Void) { ... }
```

### **<URLRequest 객체의 필요성>**

🤯 **문제상황** 
기존에는 받아온 `URL`을 `URLRequest`로 다시 받아오면서 `DataTask`와 함께 서버로 요청을 넘겨주면서 응답을 받아왔는데, 사실 따로 메서드를 특정하거나 헤더/바디 등 다른 정보를 넘겨주지 않았기 때문에 불필요한 부분이라고 느껴졌습니다.

```Swift
var request = URLRequest(url: url)

// request.httpMethod = "GET"
// request.addValue("Bearer ...")
```

🔥 **해결방법**
`URLRequest` 객체 생성을 생략하고 URL을 바로 `DataTask`에 넘겨주는 것으로 수정했습니다. 다만 이렇게 되면 요청할 때 구성된 정보와 기능이 제한이 되지만 현재에서는 불필요한 부분이라고 생각합니다.

<br>


## 😀 미해결 문제
### **<>**

---
### **<>**

    
---
<a id="5."></a>

## 팀 회고


</br>

    
<a id="6."></a>

## 참고 문서
    
- [🍎 ]()

- [📖 ]()




    
