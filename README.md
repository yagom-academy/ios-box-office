# 박스오피스
> 영화진흥위원회 웹 사이트에서 전달받은 데이터를 표시하는 앱
> 
> 프로젝트 기간: 2023.03.20-2023.03.31
> 

## 팀원
| kokkilE | 리지 |
| :--------: |  :--------: | 
| <Img src ="https://i.imgur.com/4I8bNFT.png" width="200" height="200"/>      |<Img src ="https://user-images.githubusercontent.com/114971172/221088543-6f6a8d09-7081-4e61-a54a-77849a102af8.png" width="200" height="200"/>
| [kokkilE](https://github.com/kokkilE) |[Github Profile](https://github.com/yijiye)


## 목차
1. [타임라인](#타임라인)
2. [프로젝트 구조](#프로젝트-구조)
3. [트러블 슈팅](#트러블-슈팅) 
4. [핵심경험](#핵심경험)
5. [참고 링크](#참고-링크)


# 타임라인 
- 2023.03.20 : Movie, BoxOffice 타입 구현 및 UnitTest
- 2023.03.21 : Decoder, MovieInformation, NetworkManager 타입 구현 및 step1 refactoring
- 2023.03.22 : Error 처리 구현, URL 관련 프로토콜 구현
- 2023.03.23 : 기존 NetworkManager 타입에서 Enpoint 타입 분리, refactorig
- 2023.03.24 : git merge 오류 해결, 불필요한 코드 삭제, README작성
<br/>


# 프로젝트 구조

## ClassDiagram

<img src="https://i.imgur.com/gN0y42I.png" width=1000>

## File Tree
```typescript
ios-box-office
├── BoxOffice
│   ├── Application
│   │   ├── AppDelegate.swift
│   │   ├── Base.lproj
│   │   └── SceneDelegate.swift
│   ├── Controller
│   │   └── ViewController.swift
│   ├── Model
│   │   ├── Decoder.swift
│   │   ├── EndPoint
│   │   │   ├── EndPoint.swift
│   │   │   ├── HttpMethod.swift
│   │   │   ├── NetworkRequestable.swift
│   │   │   ├── URLQueryItems.swift
│   │   │   └── extension+EndPoint.swift
│   │   ├── JSON
│   │   │   ├── BoxOffice.swift
│   │   │   ├── Decoder.swift
│   │   │   └── MovieInformation.swift
│   │   └── Network
│   │      ├── NetworkError.swift
│   │      └── NetworkManager.swift
│   ├── Namespace
│   │   └── URLElement.swift
│   ├── Resources
│   │   └── Assets.xcassets
│   └── View
│      └── Main.storyboard
├── BoxOfficeTests
│   └── BoxOfficeTests.swift
└── NetworkManagerTest
    ├── MockNetworkManager.swift
    ├── MockURLProtocol.swift
    └── NetworkManagerTest.swift
```

   




<br/>

# 트러블 슈팅
## 1️⃣ Endpoint, NetworkManager의 역할에 대한 고민

### 🔍 문제점

처음 코드를 작성했을 땐, Endpoint의 역할을 명확하게 설정하지 않아 설계하는데 어려움이 있었습니다. 그래서 API와 Endpoint의 역할에 대해 고민 해보았고, Endpoint는 HTTP method, body, URL을 모두 포함하고 API가 그 Endpoint를 통해 통신하는 것이라 생각했습니다.

**수정 전**
`오늘의 일일 박스오피스 조회`, `영화 개별 상세 조회`를 위한 URL을 보유하는 타입 구현

``` swift
struct DailyBoxOfficeURL: URLAcceptable {
    let url: URL?
    var urlComponents: URLComponents?
    let key: URLQueryItem
    let targetDate: URLQueryItem
    ...
```

``` swift
struct MovieInfomationURL: URLAcceptable {
    let url: URL?
    var urlComponents: URLComponents?
    let key: URLQueryItem
    let movieCode: URLQueryItem
    ...
```

기존에 `DailyBoxOfficeURL`, `MovieInfomationURL` 타입으로 구현하고, 최종 요청을 하는 `request`메서드에서 `URLAcceptable` 타입만으로 제한하였습니다.
위 설계에서 느낀 첫 번째 문제는 타입 내에서 HTTP method, HTTP Body 등 엔드포인트로서 역할을 하기엔 부족한 정보를 담고 있었다는 점이었고, 두 번째 문제는 조회하고자하는 정보가 추가된다면 새로운 타입을 구현해야한다는 점이었습니다.

### ⚒️ 해결방안
조회하고자 하는 정보가 추가되어 새로운 형태의 데이터의 추가가 필요할 경우 프로토콜을 정의하고 EndPoint가 해당 프로토콜을 채택하여 필요한 메서드를 구현하도록 변경하였습니다.

**수정 후**
위 두 타입을 삭제하고 모든 형태의 URL을 저장하는 타입 구현
```swift
// url프로퍼티를 갖는 프로토콜 구현
protocol NetworkRequestable {
    var urlRequest: URLRequest? { get }
    var url: URL? { get }
}
// EndPoint 타입 구현
struct EndPoint: NetworkRequestable {
    var urlRequest: URLRequest?
    var url: URL?
        
    mutating func setURLRequest(method: HttpMethod, body: Data?) {
       //// urlRequest 구현부
    }
}
// 박스오피스, 상세정보 별 protocol, extension 구현
protocol DailyBoxOfficeProtocol {
    mutating func setURLParameter() //매개변수 생략
}

extension EndPoint: DailyBoxOfficeProtocol {
    mutating func setEndPoint() {  //매개변수 생략
        setURLParameter(baseURL: baseURL, key: key, targetDate: targetDate, itemPerPage: itemPerPage, multiMovieType: multiMovieType, nationCode: nationCode, wideAreaCode: wideAreaCode)
        setURLRequest(method: method, body: body)
    }
    
    mutating func setURLParameter(baseURL: String, key: String, targetDate: String, itemPerPage: String? = nil, multiMovieType: MovieType? = nil, nationCode: NationalCode? = nil, wideAreaCode: String? = nil) {
        /// 코드생략
    }
}      
```


---
<br/>

# 핵심경험 

<details>
    <summary><big>✅ TestDouble</big></summary>

---
<br/>

- Test Double을 활용한 Network에 의존하지 않는 테스트를 진행하기 위해 두 가지 방법을 고려했습니다.
1. `URLSessionProtocol` 활용
2. `URLProtocol` 활용
`URLSessionDataTask` 의 init이 iOS13 부터 Deprecated 되기 때문에 `URLProtocol`을 활용하는 방법을 채택했습니다.

- 다음과 같이 타입을 구현하였습니다.
<img src="https://i.imgur.com/Dh7Yn3e.png" width=200>

- `MockNetworkManager`는 실제 통신 없이 동작하도록 앱에 사용되는 `NetworkManager`를 일부 수정하습니다.

``` swift
struct NetworkManager {
    static func request() -> {
        ...
        // 실제 통신을 위한 dataTask() 호출
        let task = URLSession.shared.dataTask(with: urlRequest) { 
            data, response, error in                               
            ...
        } 
        ...
    }
    ...
```
``` swift
struct MockNetworkManager {
    var urlSession: URLSession
    
    func request() -> {
        ...
        // 네트워크 통신 없이 data, response, error를 테스트 케이스에서 직접 할당하는 모의 객체의 dataTask
        let task = urlSession.dataTask(with: urlRequest) { 
            data, response, error in                               
            ...
        } 
        ...
    }
    ...
```
HTTP 통신을 수행하지 않고 `dataTask()`를 통해 `data`, `response`, `error`를 받아오기 위해 `urlSession` 프로퍼티를 보유하도록 했습니다.

- 각 테스트 케이스에서 `requestHandler`를 통해 `data`, `response`, `error`의 값을 직접 설정해서 받도록 테스트했습니다.

``` swift
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (Data?, URLResponse?, Error?))?
    ...
}

final class NetworkManagerTest: XCTestCase {
    ...
    MockURLProtocol.requestHandler = { [unowned self] request in
            let response = HTTPURLResponse(url: endPoint.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            
    return (data, response, NetworkError.unknown)
        }
}

```


---
<br/>

</details>

    
<details>
    <summary><big>✅ 테스트 케이스 작성 기준 </big></summary> 

---
이전에 단위 테스트를 진행할 땐 `기능`을 기준으로 테스트를 했습니다. 하지만 이번 스텝에서는 기능이 존재하지 않는 타입에 대한 테스트였기 때문에, 테스트 케이스 작성 기준이 모호하여 어려움이 있었습니다.
최대한 Parsing이 정상적으로 잘 되었는지 검증하기 위한 테스트 케이스를 작성하였습니다.

- 정상적인 json 파일명을 입력했을 때와 그렇지 않을 때 각각 Parsing에 성공/실패하는지 확인하기 위해 `parseJSON` 메서드를 구현하였습니다.
디코딩해주는 객체를 생성하기 전에 테스트를 진행하여 불가피하게 테스트 클래스 내에 메서드를 구현하여 테스트했습니다. 
    
``` swift
    func parseJSON(_ fileName: String) { ... }
    
    func test_잘못된파일명으로_parseJSON호출시_sut는nil이다() { ... }
    func test_올바른파일명으로_parseJSON호출시_sut는nil이아니다() { ... }
```

- 원본 데이터를 제대로 Parsing했는지 검증하기 위해 모든 데이터를 다 확인하는것은 불필요하다고 생각했습니다. 따라서 모든 프로퍼티를 각각의 테스트로 분리하기 보다는 하나의 테스트에서 모든 프로퍼티를 배열에 넣어 확인하는 테스트로 구현하였습니다.

</details>
    

<details>
    <summary><big>❇️ 추가 학습</big></summary>

### 중첩된 JSON 파일의 Model 구현
기존에 다뤄본 JSON 파일은 아래와 같이 배열형태였는데, 이번에 다뤄야 하는 파일은 중첩된 형태라 어떻게 model 타입을 구현하면 좋을지 고민하였습니다.
    
```bash
[
     { 
         "rnum":"1","rank":"1" 
     },
     { 
         "rnum":"2","rank":"2" 
     }
]
```
처음엔 타입을 3개 구현해야하나 싶었지만, JSON 파일과 비슷하게 중첩 타입을 만들어 적용시키면 될 것 같아 중첩 타입으로 구현하였습니다!

또한 JSON 파일의 항목 이름 중 축약형으로 표현되어있거나, 이름을 보고 어떤 의미인지 바로 알아차리기 힘든 경우 Swift API Naming Guideline에 맞게 변경하면서 CodingKey 프로토콜을 활용하였습니다.

```swift
struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let boxOfficeType: String
        let showRange: String
        let boxOfficeList: [Movie]
        
        enum CodingKeys: String, CodingKey {
            case showRange
            case boxOfficeType = "boxofficeType"
            case boxOfficeList = "dailyBoxOfficeList"
        }
        
        struct Movie: Decodable {
            let order: String
            ///생략
        }
    }
}
```
    
추가로, 이번 프로젝트에서는 타입을 하나씩 만들었는데 만들어야하는 항목이 많아 CodingKey를 작성할 때 오타 및 대소문자 구분 등 사소한 차이로 data parsing이 안되는 일이 간혹 있었습니다. 항목이 많은 경우는 [사이트](https://quicktype.io) 과 같은 프로그램을 이용하는 것도 좋은 방법이 될 것 같습니다.
    

<br/>
    

</details>

----

# 참고 링크
- [AppleDevelopment-URLProtocol](https://developer.apple.com/documentation/foundation/urlprotocol)
- [Test Double이란](https://jiseobkim.github.io/swift/2022/02/06/Swift-Test-Double(부제-Mock-&-Stub-&-SPY-이런게-뭐지-).html)
- [네트워크에 의존하지 않는 Test](https://velog.io/@leeyoungwoozz/iOS-네트워크에-의존하지-않는-Test)
- [Mock 을 이용한 Network Unit Test](https://sujinnaljin.medium.com/swift-mock-을-이용한-network-unit-test-하기-a69570defb41)
- [TestDouble-Mock](https://medium.com/@dhawaldawar/how-to-mock-urlsession-using-urlprotocol-8b74f389a67a)
- [kodeco-URLSession](https://www.kodeco.com/3244963-urlsession-tutorial-getting-started)
- [AppleDevelopment-dataTask](https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask)
