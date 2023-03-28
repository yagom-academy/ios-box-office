# 박스오피스 🎬

> 소개: 영화진흥위원회 오픈 API를 사용하여 영화 정보를 조회할 수 있는 앱 구현


</br>

## 목차
1. [팀원](#1-팀원)
2. [타임라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [트러블슈팅](#4-트러블-슈팅)
5. [참고링크](#5-참고-링크)

<br>

## 1. 팀원

|[Harry](https://github.com/HarryHyeon)| [kaki](https://github.com/kak1x) |
| :--------: | :--------: |
|<img height="180px" src="https://i.imgur.com/BYdaDjU.png">| <img height="180px" src="https://i.imgur.com/KkFB7j3.png"> |

<br>

## 2. 타임라인
### 프로젝트 진행 기간
**23.03.20 (월) ~ 23.03.24 (금)** 

| 날짜 | 타임라인 |
| --- | --- |
|23.03.20 (월)| 박스오피스 모델 타입, 영화 상세정보 모델 타입 구현, 모델 테스트 |
|23.03.21 (화)| 원격 서버와 Http 통신을 위한 NetworkManager 타입 구현 |
|23.03.22 (수)| EndPoint를 생성가능한 BoxOfficeEndPoint 구현 |
|23.03.23 (목)| NetworkManager 테스트(MockURLSession, MockURLSessionDataTask 활용) |
|23.03.24 (금)| 전체적인 코드 컨벤션 수정, Pull Request 컨플릭 해결, README 작성 |



<br>

## 3. 프로젝트 구조

<details>
    <summary><big>폴더 구조</big></big></summary>

``` swift
BoxOffice
    ├── Model
    |    ├── Network
    |    │    ├── NetworkManager
    |    │    ├── NetworkError
    |    │    ├── BoxOfficeEndPoint
    |    │    ├── URLSessionProtocol
    |    │    └── URLSessionDataTaskProtocol
    |    └── JSONModel
    |         ├── BoxOffice
    |         └── Movie
    ├── View
    |    ├── Main
    |    └── LaunchScreen
    ├── Controller
    |    └── ViewController
    ├── Etc
    |    ├── AppDelegate
    |    └── SceneDelegate
    ├── Assets
    ├── Info
    └── UnitTests
         ├── BoxOfficeTests
         │    └── URLSessionDataTaskProtocol
         ├── MovieTests
         │    └── URLSessionDataTaskProtocol
         └── NetworkManagerTests
              ├── NetworkManagerTests
              ├── SampleData
              └── Mocks
                   ├── MockURLSessionDataTask
                   └── MockURLSession
```

</details>

</br>

## 4. 트러블 슈팅

### 1️⃣ Model의 UnitTest

```swift
extension DailyBoxOfficeList: Equatable {
    public static func == (lhs: DailyBoxOfficeList, rhs: DailyBoxOfficeList) -> Bool {
        return lhs.number == rhs.number
        && lhs.rank == rhs.rank
        && lhs.rankIncrement == rhs.rankIncrement
        && lhs.rankOldAndNew == rhs.rankOldAndNew
        && lhs.movieCode == rhs.movieCode
        && lhs.movieKoreanName == rhs.movieKoreanName
        && lhs.openDate == rhs.openDate
        && lhs.salesAmount == rhs.salesAmount
        && lhs.salesShare == rhs.salesShare
        && lhs.salesIncrement == rhs.salesIncrement
        && lhs.salesChange == rhs.salesChange
        && lhs.salesAccumulation == rhs.salesAccumulation
        && lhs.audienceCount == rhs.audienceCount
        && lhs.audienceIncrement == rhs.audienceIncrement
        && lhs.audienceChange == rhs.audienceChange
        && lhs.audienceAccumulation == rhs.audienceAccumulation
        && lhs.screenCount == rhs.screenCount
        && lhs.showCount == rhs.showCount
    }
}
```

- 모델의 유닛 테스트를 위해 Equatable 채택을 하여 모델의 모든 값이 맞는지 확인하였습니다.
- 그러나 위 방식은 휴먼에러가 발생할 위험성이 높다고 생각되어 다른 방법을 고민하였습니다.
- 모델의 검증하는 방법 중에 서버에서 고유한 아이디 값을 내려주거나 `identifiable` 프로토콜을 채택하여 해당 모델이 고유한 id를 가질 수 있도록하여 검증하는 방법이 있습니다.
- 현재 프로젝트에서는 서버에서 값을 내려줄 수 없기 때문에 몇 가지 프로퍼티가 맞는지 확인하는 방법을 사용하기로 했습니다.

### ⚒️ 해결방법
``` swift
func test_두번째_dailyBoxOffice의_number값이_문자열2이다() {
        // given
        let expectedResult = "2"
     
        // when
        let boxOfficeNumber = sut.boxOfficeResult.dailyBoxOfficeList[1].numberText
        
        // then
        XCTAssertEqual(expectedResult, boxOfficeNumber)
    }
```
- 따라서 테스트 할 때를 제외하고 필요없는 코드라고 판단되어 Equatable 채택을 제거하고 특정 프로퍼티 몇 개를 체크하는 방식으로 변경하였습니다.

<br>

### 2️⃣ ErrorDescription 사용
```swift
enum NetworkError: LocalizedError {
    case urlError
    case invalidResponseError
    case invalidHttpStatusCode(Int)
    case emptyData
    case decodeError
    
    var errorDescription: String {
        switch self {
        case .urlError:
            return "잘못된 URL입니다."
        case .invalidResponseError:
            return "알 수 없는 응답 에러입니다."
        case .invalidHttpStatusCode(let code):
            return "status: \(code)"
        case .emptyData:
            return "데이터가 비어있습니다."
        case .decodeError:
            return "decodeError가 발생했습니다."
        }
    }
}
```
- NetworkError 타입이 LocalizedError를 채택하도록 하고, API 호출을 요청하는 쪽에서 error를 수신하게 될때 `error.localizedDescription`를 통해 위에 정의한 문자열을 반환하도록 처리하기 위해 `errorDescription` 연산 프로퍼티를 구현해주었습니다.
- 하지만 `error.localizedDescription`를 사용할시 정의한 문자열이 반환되지 않는 오류가 발생하였습니다.

### ⚒️ 해결방법
```swift
var errorDescription: String? {
    switch self {
    case .urlError:
        return "잘못된 URL입니다."
    case .invalidResponseError:
        return "알 수 없는 응답 에러입니다."
    case .invalidHttpStatusCode(let code):
        return "status: \(code)"
    case .emptyData:
        return "데이터가 비어있습니다."
    case .decodeError:
        return "decodeError가 발생했습니다."
    }
}
```
- `eerorDescription`의 타입을 String?이 아닌 String으로 구현해주어 발생한 문제였고 타입을 String?으로 변경해주니 정상적으로 작동하게 되었습니다.
- LocalizedError 프로토콜이 Error를 상속받기 때문에 Result의 실패 타입이 Error여도 정의한 문자열이 잘 출력되는 것을 확인할 수 있었습니다.

<br>

### 3️⃣ EndPoint를 관리하는 타입
```swift
struct BoxOfficeURLManager {
...
    
    func makeBoxOfficeURL(targetDate: String) -> URL? {
        
        var components = URLComponents()
        ...
        return components.url
    }
    
    func makeMovieInfoURL(movieCode: String) -> URL? {
        var components = URLComponents()
        ...
        return components.url
    }
}

```

- 박스오피스 프로젝트에서는 2가지 api를 사용합니다.
    - 일별 박스오피스 순위 조회
    - 영화 상세정보 조회
- 2가지 api의 url을 쿼리를 통해 정보를 가져와야 하기 때문에 EndPoint를 관리하고 url을 생성해주는 타입이 필요하다고 생각했습니다.
- 박스오피스 순위 조회를 위한 url, 영화 상세정보 보기를 위한 url을 각각 다른 메서드를 사용해서 url을 만들어 주는 방식을 사용하고 있었습니다.



### ⚒️ 해결방법

``` swift
enum BoxOfficeEndPoint {
    case fetchDailyBoxOffice(targetDate: String)
    case fetchMovieInfo(movieCode: String)
}

extension BoxOfficeEndPoint {
    var path: String {
        switch self {
        case .fetchDailyBoxOffice:
            return "..."
        case .fetchMovieInfo:
            return "..."
        }
    }
    
    var queries: [URLQueryItem] {
        switch self {
        case .fetchDailyBoxOffice(let targetDate):
            return [ ... ]
        case .fetchMovieInfo(let movieCode):
            return [ ... ]
        }
    }
    
    func createURL() -> URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queries
        
        return components?.url
    }
}
```
- enum 타입으로 정의하여 2가지 조회 방법이 필요하게되는 경우를 각각 case로 지정하고 switch문을 사용하여 case에 따라 경로와 쿼리가 달라지도록 하여 url을 생성해 주는 방식으로 변경하였습니다.

## 5. 참고 링크
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Docs - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Wiki - HTTP](https://ko.wikipedia.org/wiki/HTTP)
---


###### tags: `readme`



