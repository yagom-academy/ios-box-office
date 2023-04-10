# 박스 오피스 프로젝트 🍿
> [영화진흥위원회](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice)의 오픈 API를 이용하여 박스 오피스 영화를 소개하는 프로젝트

---
## 목차 📋
1. [팀원 소개](#1-팀원-소개)
2. [타임 라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행화면)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [Reference](#6-reference)

<br/>

## 1. 팀원 소개

|[Hyemory](https://github.com/Hyemory)| [Christy](https://github.com/christy-hs-lee) | 
| :--------: | :--------: |
|<img height="180px" src="https://i.imgur.com/r0PGWW3.png">| <img height="180px" src="https://i.imgur.com/kHLXeMG.png"> |

<br>

## 2. 타임라인
### 프로젝트 진행 기간
> **23.03.20 (월) ~ 23.04.14 (금)** 

### PART 1

| 날짜 | 타임라인 |
| --- | --- |
| 23.03.20 (월) | 프로젝트 시작, 박스 오피스 모델<br/> 디코더 타입 구현 및 유닛 테스트 진행 |
| 23.03.21 (화) | 박스 오피스 모델, 디코더 타입 리팩토링 |
| 23.03.22 (수) | 영화 정보 모델, 네트워크 매니저 모델 타입 구현 |
| 23.03.23 (목) | 네트워크 Mock 유닛 테스트 진행 |
| 23.03.24 (금) | 코드 리팩토링 및 프로젝트 회고 진행 |
| 23.03.27 (월) | Decode 객체 리팩토링 진행 |
| 23.03.28 (화) | Modern Collection View 학습 <br/>Cell 타입 구현 |
| 23.03.29 (수) | URLRequest 사용하여 리팩토링 <br/> refresh 기능 구현 |
| 23.03.30 (목) | 코드 컨벤션 및 extension 파일 개선 |
| 23.03.31 (금) | 영화 정보 상세페이지 레이아웃 구현 |

### PART 2

| 날짜 | 타임라인 |
| --- | --- |
| 23.04.03 (월) | 영화 정보 상세페이지 data fetch 구현 |
| 23.04.04 (화) | 전체 코드 리팩토링, UICalendarView 학습 |
| 23.04.05 (수) | Calendar View 구현 |
| 23.04.06 (목) | Collection View, 상세페이지 리팩토링 |
| 23.04.07 (금) | Calendar View 코드 리팩토링 |

<br>

## 3. 프로젝트 구조
### 폴더 구조
   
```swift
├── BoxOffice
│   ├── Controller
│   │   ├── BoxOfficeViewController.swift
│   │   └── MovieInfoViewController.swift
│   ├── Extension
│   │   ├── Array+extension.swift
│   │   ├── CALayer+extension.swift
│   │   ├── Date+extension.swift
│   │   └── String+extension.swift
│   ├── Model
│   │   ├── BoxOffice.swift
│   │   ├── DailyBoxOfficeItem.swift
│   │   ├── Movie.swift
│   │   ├── MovieInfo.swift
│   │   └── MoviePoster.swift
│   ├── Network
│   │   ├── BoxOfficeURLRequest.swift
│   │   ├── NetworkManager.swift
│   │   ├── NetworkingError.swift
│   │   └── Protocol
│   │       ├── URLSessionDataTaskProtocol.swift
│   │       └── URLSessionProtocol.swift
│   ├── SceneDelegate.swift
│   └── View
│       ├── BoxOfficeCell.swift
│       ├── LoadingVIew.swift
│       ├── Protocol
│       │    └── IdentifierType.swift
│       └── RowStackView.swift
├── BoxOfficeTests
│   ├── BoxOfficeTests.swift
│   ├── DummyBoxOffice.swift
│   ├── MockURLSession.swift
│   ├── MockURLSessionDataTask.swift
│   └── NetworkManagerTests.swift
└── README.md
```

</br>

## 4. 실행화면

| 실행 화면 | 메인 화면 |
| :--------: | :--------: |
| <img src="https://i.imgur.com/QlboZ9K.gif"> | <img src="https://i.imgur.com/8GbhgYR.gif"> |

| 날짜 변경 화면 |  새로고침 화면  |
| :--------: | :--------: |
| <img src="https://i.imgur.com/uv8B9W3.gif"> | <img src="https://i.imgur.com/b0mFteM.gif"> |


<br/>
<br/>

## 5. 트러블 슈팅
### 1️⃣ JSON Decoding 유닛테스트

#### 🔒 문제점 <br/>
sut(decoding)가 정상적으로 실행되지 않을 때 nil을 반환하도록 유닛 테스트를 작성하였는데
타입에 문제가 있는 것인지, data에 문제가 있는 것인지 구별이 되지 않는 문제가 있었습니다.

``` swift
// MARK: - sut 실행 구문
do {
    let result = try decoder.decode(type, from: items.data)

    return result
} catch DecoderError.decodeFailed {
    print("\(name)파일 디코딩에 실패했습니다.")

    return nil
}

// MARK: - Unit test 메서드
func test_디코딩할때_nil을반환하지않는다() {
    // then
    XCTAssertNotNil(sut)
}
```

#### 🔑 해결 방법 <br/>
타입과 data를 각각 잘못된 값을 주입하여 확인해 보는 방법으로 수정하였습니다.

``` swift
func test_잘못된data로_디코딩했을때_decodeFailed에러를던진다() {
    // given
    let invalidData = Data(count: 0)
    let expectation = NetworkingError.decodeFailed
    var result: NetworkingError?

    // when
    XCTAssertThrowsError(try NetworkDecoder().decode(data: invalidData, type: BoxOffice.self).get()) {
        errorHandler in
        result = errorHandler as? NetworkingError
    }

    // then
    XCTAssertEqual(result?.description, expectation.description)
}

func test_잘못정의한Model로_디코딩했을때_decodeFailed에러를던진다() {
        // given
        let expectation = NetworkingError.decodeFailed
        var result: NetworkingError?
        
        // when
        XCTAssertThrowsError(try NetworkDecoder().decode(data: NSDataAsset(name: "box_office_sample")!.data,
                                                          type: DummyBoxOffice.self).get()) {
            errorHandler in
            result = errorHandler as? NetworkingError
        }
        
        // then
        XCTAssertEqual(result?.description, expectation.description)
    }
```

<br/>

### 2️⃣ 확장성있는 Decoder 타입만들기 

#### 🔒 문제점 <br/>
샘플로 사용할 Asset의 JSON 파일은 이후 다루지 않게되고, 들어갈 타입도 계속 변경이 될 것이라 생각했습니다.

```swift
func decode(name: String) throws -> BoxOffice? {
    guard let items = NSDataAsset(name: name) else {
        throw DecoderError.decodeFailed
    }

    do {
        let result = try decoder.decode(BoxOffice.self, from: items.data)

        return result
    } catch DecoderError.decodeFailed {
        print("\(name)파일 디코딩에 실패했습니다.")

        return nil
    }
}
```

#### 🔑 해결 방법 <br/>
data와 type을 매개변수로 받아 제네릭을 이용하여 확장성 있게 수정하였습니다.
또한 성공, 실패 두가지 분류로 나뉘다보니 Result 타입을 이용하여 오류를 던져주는 방식을 채택하였습니다.

``` swift
func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
    if let result = try? JSONDecoder().decode(type, from: data) {
        return .success(result)
    } else {
        return .failure(NetworkingError.decodeFailed)
    }
}
```

<br/>

### 3️⃣ Navigation backButton

#### 🔒 문제점 <br/>

`NavigationController`의 경우 이전 뷰의 navigationTitle의 값을 다음 화면의 navigationBackButton의 title 값으로 사용하고 있습니다. 해당 프로퍼티 내용의 길이에 따라 backButton의 경우 보여지는 값이 달라졌습니다. 제목이 긴 영화 제목의 경우 적당히 길면 `< Back` 으로 나오고 그보다 더 길면 `<` 버튼만 나오게 됩니다. 이는 [공식문서](https://developer.apple.com/documentation/uikit/uinavigationcontroller)에도 적혀있는 내용으로, 해당 프로터티 내용의 길이에 따라 backButton은 상황에 적합한 형태로 변하게 됩니다. 
이와 더불어 MovieInfoViewController가 데이터를 불러오기 위해 로딩하는 과정에서 기존 backButton의 값인 이전 뷰의 navigation Title값이 보여졌다가 공간 부족으로 사라지는 부자연스러운 버그가 발생했습니다.


#### 🔑 해결 방법 <br/>

자연스러운 화면 구성을 위하여 공식문서를 참고하여 이전 뷰에서 backBarButtonItem의 title을 지정하여 어떤 상황이더라도 `<` 버튼만 보여지도록 코드를 리팩토링 했습니다.

```swift
let backBarButtonItem = UIBarButtonItem(title: "",
                                        style: .plain,
                                        target: self,
                                        action: nil)

navigationItem.backBarButtonItem = backBarButtonItem
```

<br/>


### 4️⃣ 확장성있는 EndPoint 타입만들기

#### 🔒 문제점 <br/>

URL을 만들어주는 KobisURLRequest 타입이 아래와 같이 외부에서 addQuery를 받고 request 메서드의 로직을 거쳐 URLRequest 값을 만들도록 구현했는데, 
여러 API를 받아오기 힘들고 encoding에 대응하기 어려운 등 확장성이 떨어지는 코드였습니다. 
또한 타입 분리가 제대로 되어있지 않았습니다.

``` swift
// MARK: - KobisURLRequest type
mutating func addQuery(name: String, value: String) {
    self.queries[name] = value
}

func request() -> URLRequest? {
    var urlComponents = URLComponents(string: baseURL + pagePath)

    urlComponents?.queryItems = [key]

    for (name, value) in queries {
        let queryItem = URLQueryItem(name: name, value: value)

        urlComponents?.queryItems?.append(queryItem)
    }

    guard let url = urlComponents?.url else { return nil }

    return URLRequest(url: url)
}
```

#### 🔑 해결 방법 <br/>

API를 좀 더 세분화하여 enum으로 정의하도록 수정했고, request 메서드에서 분기 처리하는 로직을 최대한 enum과 프로퍼티로 보완하였습니다.
또한 기본 제공 메서드를 활용하여 코드를 정리할 수 있었습니다.

``` swift
typealias HTTPHeaders = [String: String]
typealias Query = [String: String]

enum HTTPMethod: String {
    // ...
}

enum HTTPTask {
    // ...
}

protocol EndpointType {
    // ...
}

// MARK: - EndPoint
enum EndPoint {
    // ...
}

extension EndPoint: EndpointType {
    var baseURL: URL {
        switch self {
        // ...
        }
    }
    
    var path: String? {
        switch self {
        // ...
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        // ...
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        // ...
        }
    }
    
    var queries: Query {
        switch self {
        // ...
        }
    }
    
    func asURLRequest() -> URLRequest {
        var url: URL = baseURL
        var queryItems: [URLQueryItem] = []
        
        for (name, value) in queries {
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        
        url.appendPathComponent(path ?? "")
        url.append(queryItems: queryItems)
        
        var request: URLRequest = .init(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

```

<br/>

### 5️⃣ Stack View 설정하기

#### 🔒 문제점 <br/>
처음 영화 상세 화면의 요구 사항을 보며 포스터의 이미지 뷰와 아래 영화 정보 라벨을 vertical StackView로 구현했습니다.
포스터 이미지 뷰를 stackView에 넣고 constraint를 설정하니, 가장 넓은 포스터의 위치와 사이즈에 맞춰 나머지 뷰가 원하는대로 조정되지 않았습니다. 

#### 🔑 해결 방법 <br/>
이미지 뷰를 별도로 빼고 scrollView에 이미지 뷰와 영화 정보 stackView를 포함시켰습니다.

``` swift
contentScrollView.addSubview(posterImageView)
contentScrollView.addSubview(movieInfoListStackView)
```

<img height="180px" src="https://i.imgur.com/GFfpll2.png"><br/>

이후 포스터 이미지 뷰와 stackView의 spacing이 다르다고 판단하여 포스터 이미지 뷰를 스택뷰에 포함시키지 않고,
constraint를 각각 설정하여 원하는 화면을 구현할 수 있었습니다.

<br/>

### 6️⃣ 선택 가능한 날짜 범위 지정하기

#### 🔒 문제점 <br/>
캘린더에서 오늘 날짜부터는 선택할 수 없도록 구현해야하는 요구 사항이 있어 어떻게 구현해야할지 고민했습니다.

#### 🔑 해결 방법 <br/>
`UICalendarView`에는 선택 가능한 날짜의 범위를 설정할 수 있는 `.availableDateRange` 프로퍼티가 있습니다.
선택 가능 날짜 중 시작 날짜를 어떻게 할까 고민하다가 API의 데이터가 시작되는 날짜를 손수 찾아 2003년 11월 11월을 시작 날짜로 설정하였습니다.

``` swift
let startDateComponent = DateComponents(calendar: Calendar(identifier: .gregorian),
                                        year: 2003,
                                        month: 11,
                                        day: 11)
```

<br/>

### 7️⃣ 선택한 날짜 메인페이지로 넘겨주기

#### 🔒 문제점 <br/>
캘린더에서 날짜를 선택하면 선택한 날짜에 맞게 메인페이지에서 박스오피스 API 정보를 불러와 목록을 구성해야했습니다.
어떻게 캘린더 뷰에서 메인페이지로 날짜를 전달할까 고민하였습니다.

#### 🔑 해결 방법 <br/>
`UICalendarView`에서 선택한 날짜의 영화 정보를 받기 위해선 뷰간 1:1 데이터 전송이 필요했습니다. 이를 구현하기 위해 저희는 delegate 패턴을 사용했습니다. 값을 업데이트하는 프로토콜을 구현하고 이를 `BoxOfficeViewController`를 대리자로 위임하기 위해 프로토콜을 채택하였습니다.

``` swift
protocol DateUpdatableDelegate: AnyObject {
    func updateDate(_ date: Date)
}
```

날짜를 선택하면 updateDate 메서드를 통해 BoxOfficeViewController의 네비게이션 타이틀과 박스오피스 정보를 업데이트 해주었습니다.

``` swift
extension BoxOfficeViewController: DateUpdatableDelegate {
    func updateDate(_ date: Date) {
        navigationItem.title = date.showSelectedDate(formatter: dateFormatterWithHyphen)
        
        guard let targetDate = navigationItem.title?.removeHyphen() else { return }
        
        fetchBoxOffice(targetDate: targetDate)
    }
}
```
<br/>

## 6. Reference
- [Apple Docs - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Docs - URLSessionDataTask](https://developer.apple.com/documentation/foundation/urlsessiondatatask)
- [Apple Docs - UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller)
- [Apple Docs - URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared)
- [Appple Docs - UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
- [iOS Networking and Testing](https://techblog.woowahan.com/2704/)
- [URLSession & Result](https://swiftstudent.com/2020-04-14-urlsession-and-result/)
- [blog - Refresh 구현하기](https://bicycleforthemind.tistory.com/39)
- [Alamofire - ParameterEncoding](https://github.com/Alamofire/Alamofire/blob/master/Source/ParameterEncoding.swift)
- [Alamofire - ParameterEncoder](https://github.com/Alamofire/Alamofire/blob/master/Source/ParameterEncoder.swift)
