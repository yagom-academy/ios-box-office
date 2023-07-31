# 🎥 박스오피스 🍿

## 📖 목차

1. [📢 소개](#1.)
2. [👤 팀원](#2.)
3. [⏱️ 타임라인](#3.)
4. [📊 UML & 파일트리](#4.)
5. [🧨 트러블 슈팅](#5.)
6. [🔗 참고 링크](#6.)

<br>

<a id="1."></a>

## 1. 📢 소개
`일별 박스오피스 API`를 이용해서 박스오피스 정보를 받아오고 원하는 영화의 정보를 보여드립니다!

> **핵심 개념 및 경험**
> 
> - **Networking**
>   - `URLSession`을 이용한 네트워킹
> - **TestDouble**
>   - `TestDouble` 객체를 이용하여 네트워크가 연결되어 있지 않은 경우에도 테스트
> - **Entity**
>   - `JSON` 데이터를 디코딩할 `Entity` 객체 구현

<br>

<a id="2."></a>

## 2. 👤 팀원

| [kyungmin 🐼](https://github.com/YaRkyungmin) | [Erick 🐶](https://github.com/h-suo) |
| :--------: | :--------: | 
| <Img src = "https://cdn.discordapp.com/attachments/1100965172086046891/1108927085713563708/admin.jpeg" width="350"/>| <Img src = "https://user-images.githubusercontent.com/109963294/235300758-fe15d3c5-e312-41dd-a9dd-d61e0ab354cf.png" width="350"/>|

<br>

<a id="3."></a>
## 3. ⏱️ 타임라인

> 프로젝트 기간 :  2023.07.24 ~ 2023.08.04

|날짜|내용|
|:---:|---|
| **2023.07.24** |▫️ `JSON` 데이터를 디코딩할 `Entity` 객체 구현 <br>|
| **2023.07.25** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.07.26** |▫️ 네트워킹 작업을 할 `NetworkManager` 구현 <br>|
| **2023.07.27** |▫️ `TestDouble`을 이용한 테스트 생성 <br> |
| **2023.07.28** |▫️ 코드 개선을 위한 리펙토링 <br> ▫️ README 작성 <br>|

<br>

<a id="4."></a>
## 4. 📊 파일트리


### 파일트리
```
BoxOffice
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Model
│   ├── DataManager.swift
│   ├── Entity
│   │   ├── BoxOffice.swift
│   │   └── Movie.swift
│   ├── NetworkManager.swift
│   └── TestDouble
│       ├── StubURLSession.swift
│       └── URLSessionProtocol.swift
├── Controller
│   └── ViewController.swift
├── View
│   └── Main.storyboard
├── Error
│   ├── DataError.swift
│   └── NetworkError.swift
├── Extension
│   ├── URL+.swift
│   └── URLSession+.swift
└── Util
    └── Path.swift

```

<br>

<a id="5."></a>
## 6. 🧨 트러블 슈팅
### 1️⃣ Multiple Variable Declaration ⁉️

#### 🔥 문제점
`Entity` 객체의 프로퍼티를 관련된 프로퍼티끼리 `Multiple Variable Declaration` 해주었습니다.
하지만 프로퍼티끼리 `Multiple Variable Declaration` 해줘도 괜찮은지 나중에 수정이 생긴다면 어떻게 해야할지 고민이 있습니다.

```swift
struct DailyBoxOfficeList: Codable {
    let number: String
    let rank, rankIntensity: String
    let rankOldAndNew: String
    let movieCode, movieName: String
    let openDate: String
    let salesAmount, salesShare, salseIntensity, salesChange, salesAccumulation: String
    let audienceCount, audienceIntensity, audienceChange, audienceAccumulation: String
    let screenCount: String
    let showCount: String
}
```

#### 🧯 해결방법
추후 `JSON` 데이터의 타입이 변동이 되거나, 데이터 자체의 정보가 바뀔 경우를 고려하여 `Multiple Variable Declaration` 되어 있을 경우 수정이 용이하지 않기 때문에 프로퍼티 하나하나를 선언해주었습니다.

```swift
struct DailyBoxOfficeList: Codable {
    let number: String
    let rank: String
    let rankIntensity: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salseIntensity: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
```

<br>

### 2️⃣ NetworkManager 타입 설계

#### 🔥 문제점
처음 `NetworkManager`타입을 설계할 때  
>1. `URL`을 만들어 주는 기능
>2. `URL`받아 데이터를 받아와 데이터를 반환해주는 기능
>3. `Data`를 받아 `JSON`으로 디코딩 해주는 기능

위와 같이 3가지 기능을 분리하여 `NetworkManager`가 가지고 있게 구현 했습니다. 하지만 `Data`를 받아 `JSON`으로 디코딩 해주는 기능을 `NetworkManager`가 가지고 있는것이 맞지 않다고 판단했습니다.

#### 🧯 해결방법
`URL`을 만들어 주는 기능
> `URL` `extension`을 통해 `scheme`, `host`, `path`, `queryItems`로 URL을 반환해주는 static 메서드로 분리 했습니다.
> 
`Data`를 받아 `JSON`으로 디코딩 해주는 기능
> `DataManager`타입으로 분리하여 `JSON`으로 디코딩 해주는 기능을 static메서드로 가지고 있게 분리했습니다.

위의 2가지 기능을 분리해서 `NetworkManager`는 네트워크로부터 데이터를 받아오는 기능만 하도록 해결 했습니다.

<br>

### 3️⃣ Test Double

#### 🔥 문제점
네트워크가 연결되어 있지 않은 상황에서도 `NetworkManager`의 `startLoad` 로직이 잘 작동하는지 테스트를 하고 싶었습니다.
하지만 `URLSession`의 `dataTask` 메서드를 사용하고 있었기 때문에 네트워크가 연결되어 있지 않은 상황에서는 테스트가 어려웠습니다.

#### 🧯 해결방법
테스트가 어려운 경우 사용할 수 있는 `Test Double` 객체 `StubURLSession`을 구현하여 테스트를 진행하였습니다.
`StubURLSession`는 실제 `dataTask`의 역할을 수행하진 않지만 껍데기 `dataTask`를 가지고 있어 넣어준 `Dummy Data`를 반환하는 객체입니다.

**💉 의존성 주입**
```swift
protocol URLSessionProtocol {
    func dataTask(with url: URL,  completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}
```

```swift
struct NetworkManager {
    var urlSession: URLSessionProtocol
    
    // ...
}
```
- `URLSessionProtocol`을 만들어 `NetworkManager`가 프로퍼티로 해당 타입을 가지고 있도록 하여 `URLSession`뿐만 아니라 `StubURLSession`을 주입할 수 있도록 하여 테스트했습니다.

**✅ 테스트**
```swift
// given
// 받아올 데이터를 임의로 생성
let dummy = DummyData(data: data, response: response, error: nil)
let stubUrlSession = StubURLSession(dummy: dummy)
sut?.urlSession = stubUrlSession

// when
sut?.startLoad(url!, completion: { data in
    // then
    // startLoad로 받아온 데이터는 DummyData의 데이터
    XCTAssertEqual(data, dataAsset.data)
    expectation.fulfill()
})
```
- `StubURLSession`는 `DummyData`를 가지고 `dataTask` 메서드를 실행시 `StubURLSessionDataTask`을 이용해서 `DummyData`만 던져주도록 구현했습니다.

<br>

<a id="6."></a>
## 8. 🔗 참고 링크
- [🍎Apple: CodingKey](https://developer.apple.com/documentation/swift/codingkey)
- [🍎Apple: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎Apple: URL](https://developer.apple.com/documentation/foundation/url)
- [🍎Apple: Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🐻야곰닷넷: Unit Test](https://yagom.net/courses/unit-test-작성하기/)
