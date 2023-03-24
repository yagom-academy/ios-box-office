# 박스오피스 프로젝트 🎬
> 영화진흥위원회 OPEN API를 사용한 오늘의 박스오피스와 영화 상세정보를 보여주는 앱

---
## 목차 📋
1. [팀원 소개](#1-팀원-소개)
2. [타임 라인](#2-타임라인)
3. [폴더 구조](#3-폴더-구조)
4. [실행화면](#4-실행화면)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [Reference](#6-reference)

---
## 1. 팀원 소개
|레옹아범|Andrew|
|:--:|:--:|
|<img src="https://github.com/hyemory/ios-bank-manager/blob/step4/images/leon.jpeg?raw=true" width="150">|<img src="https://github.com/hyemory/ios-exposition-universelle/blob/step2/images/Andrew.png?raw=true" width="200">|

## 2. 타임라인
|날짜|진행 내용|
|---|---|
|2023-03-20|API 통신을 위한 모델 타입 구현|
|2023-03-21|URLSession 동작 타입 및 메소드 구현|
|2023-03-22|Error 타입 및 APIType 구현|
|2023-03-23|전체 코드 리팩토링|
|2023-03-24|테스트 코드 리팩토링|

## 3. 폴더 구조

<details>
    <summary><big>폴더 구조</big></summary>

``` swift
BoxOffice
    │
    └── Protocol
       └── Fetchable
    └── Extension
       └── String+extension
       └── Bundle+extension
    └── Model
       └── APIType
       └── BoxofficeError
    └── DTO
        └── MovieDTO
            └──MovieInfoObject
            └──MovieInfoResultObject
            └──MovieInfoDescObject
        └── BoxofficeDTO
            └──DailyBoxofficeObject
            └──BoxofficeResultObject
            └──InfoObject
    ├── BoxofficeInfo
    ├── Main
    ├── Assets
    ├── launchScreen
    ├── AppDelegate
    ├── SceneDelegate
    ├── ViewController
    └── MovieInfoTests
       ├── MovieInfoTests
    
```

<br>    
    
</details>

## 4. 실행화면
- *프로젝트 완성 후 업데이트 예정*

## 5. 트러블 슈팅

### 1️⃣ 특정 DTO만을 사용할 수 있는 네트워크 모델 만들기

#### ❓문제점

```swift
struct BoxofficeInfo<T: Decodable> {
    mutating func search(completion: @escaping (Result<T, BoxofficeError>) -> Void)
}
```

* 기존 `Decodable`만을 채택한 모델을 받을 경우 가장 상위 DTO인 `DailyBoxofficeObject` 이외의 `InfoObject`, `BoxofficeResultObject` 등 하위 DTO를 인자로 줄 경우 `decodingError`가 발생하므로 이를 사전에 따로 프로토콜을 생성하여 방지하고자 하였습니다.

#### 📖해결한 점

```swift
protocol Fetchable: Decodable { }

struct DailyBoxofficeObject: Fetchable { }
struct MovieInfoObject: Fetchable { }

struct BoxofficeInfo<T: Fetchable> {
    mutating func search(completion: @escaping (Result<T, BoxofficeError>) -> Void)
}
```

* 상위객체에만 `Fetchable`을 채택함으로 해당 객체가 아닌 다른 객체 타입으로는 `BoxofficeInfo`를 만들지 못하도록 만들었습니다.

### 2️⃣ 열거형 Associated Values의 사용

#### ❓문제점
```swift
enum APIType {
    case movie
    case boxoffice
    
    func receiveUrl(interfaceValue: String) -> URL? {
        let key = Bundle.main.apiKey
        //...
    }
}
```

* 기존 URL에서 일일박스오피스(날짜), 영화(영화코드) 데이터를 받기위해 한가지의 `interfaceValue`가 필요했습니다.
* 하지만 이렇게 작성할 경우 `interfaceValue`가 필요하지 않거나, 여러개의 `interfaceValue`가 필요한 경우에는 해당 메소드를 사용하지 못하는 문제가 있었습니다.

#### 📖해결한 점
```swift
enum APIType {
    case movie(String)
    case boxoffice(String)
    
    func receiveUrl() -> URL? {
        //...
    }
}
```

* 위와 같이 열거형 케이스마다 연관 값을 부여하여 해당 케이스가 고유의 `interfaceValue`를 가지게하고 URL에서 쉽게 사용하도록 만들었습니다.

### 3️⃣ URLProtocol 사용하여 Unit Test

#### ❓문제점
<img src=https://i.imgur.com/XQgkUmO.png width="500">

![](https://i.imgur.com/8BhSorS.png)

- URLSessionDataTask의 init이 iOS 13 버전부터 deprecated가 되었습니다.
- 실제로 사용해보니 컴파일 경고가 나왔고 추후에 나올 버전에서도 테스트하기 어렵다고 판단
- 다른방법을 찾다가 URLProtocol을 사용하게 되었습니다

#### 📖해결한 점
```swift
class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ( (URLRequest) throws -> (HTTPURLResponse, Data) )?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("handler를 응답 받지 못하였습니다")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
    }
    
    override func stopLoading() {
        
    }
    
}
```
- URLProtocol을 사용하여 네트워크의 요청 결과에 따른 코드 동작을 테스트를 하였습니다
- MockURLProtocol을 구현하여 네트워크를 수행하는 객체(BoxofficeInfo)에 의존성 주입으로 URLSession을 넣어 구현하였습니다

## 6. Reference
- [Apple Developer: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Developer: Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Apple Developer: UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [Apple Developer: Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [Apple Developer: Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
- [Apple Developer: Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [Apple Developer: Entering data](https://developer.apple.com/design/human-interface-guidelines/patterns/entering-data/)
- [Apple Developer: UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [Apple Developer: URLProtocol](https://developer.apple.com/documentation/foundation/urlprotocol)
