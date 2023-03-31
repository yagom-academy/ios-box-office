# 박스 오피스 🎥

> 소개: API를 사용하여 데이터들을 표시하는 어플

</br>

## 목차
1. [팀원](#1-팀원)
2. [타임라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행-화면)
5. [트러블슈팅](#5-트러블-슈팅)
6. [참고링크](#6-참고-링크)

<br>

## 1. 팀원

|[vetto](https://github.com/gzzjk159) | [Brody](https://github.com/seunghyunCheon)|
| :--------: | :--------: |
|<img height="180px" width="180" src="https://cdn.discordapp.com/attachments/535779947118329866/1055718870951940146/1671110054020-0.jpg"> | <img height="180px" width="200" src="https://i.imgur.com/fPPz155.jpg">|


<br>

## 2. 타임라인
### 프로젝트 진행 기간
**23.03.20 (월) ~ 23.03.31 (금)** 

| 날짜 | 타임라인 |
| --- | --- |
|23.03.20 (월)| BoxOffice, DailyBoxOffice모델 구현, BoxOfficeJsonDecoder 구현 및 테스트케이스 작성 |
|23.03.21 (화)| NetworkManager, BoxOfficeAPI, MovieInformation, MovieDetail Infomation모델 구현 및 Mock객체를 이용한 테스트 케이스 작성 |
|23.03.22 (수)| Modern Collection View 학습 |
|23.03.23 (목)| Modern Cell API(ContentConfiguration) 학습|
|23.03.24 (금)| URL 만드는 기능에 Http method 추가|
|23.03.25 (토)| BoxOffirceProvide, Endpoint 정의 |
|23.03.27 (월)| activityIndicator 구현<br>BoxOfficeItem구조체 구현<br>setupAllViews 메서드 구현<br> BoxOfficeListCell 구현<br> BoxOfficeContentView내 apply구현 |
|23.03.28 (화)| DiffableDataSource, CompositionalLayout 구현<br> BoxOfficeContentView autolayout 구현<br> refreshControl 구현<br> Numberformat 구현|
|23.03.29 (수)| indentifiable 적용, 다이나믹 타입 적용 |
|23.03.30 (목)| DaumAPI 구현<br> Requsetable headers 추가<br> SearchedMovieImageDTO 구현 및 테스트 구현 |
|23.03.31 (금)| MovieDetailViewController 구현<br> MovieDetailInformation 구현<br> CategoryStackView 구현<br> fetchMoviePoster 메서드 구현 |

<br>

## 3. 프로젝트 구조

<details>
    <summary><big>폴더 구조</big></big></summary>

### BoxOffice
```swift
BoxOffic
├── BoxOffice
│   ├── Application
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Error
│   │   ├── DataAssetError.swift
│   │   └── NetworkError.swift
│   ├── Extension
│   │   ├── Date+.swift
│   │   └── String+.swift
│   ├── Info.plist
│   ├── Model
│   │   ├── BoxOfficeContentConfiguration.swift
│   │   ├── BoxOfficeItem.swift
│   │   ├── BoxOfficeJsonDecoder.swift
│   │   ├── DTO
│   │   │   ├── BoxOfficeDTO.swift
│   │   │   ├── MovieInformationDTO.swift
│   │   │   └── SearchedMovieImageDTO.swift
│   │   ├── DailyBoxOffice.swift
│   │   ├── MovieDetailInformation.swift
│   │   └── MovieDetailInformationItem.swift
│   ├── Network
│   │   ├── BoxOfficeAPI.swift
│   │   ├── BoxOfficeProvider.swift
│   │   ├── DaumAPI.swift
│   │   ├── Endpoint.swift
│   │   ├── HttpMethod.swift
│   │   ├── Requestable.swift
│   │   ├── URLSessionDataTaskProtocol.swift
│   │   └── URLSessionProtocol.swift
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   │   └── box_office_sample.dataset
│   │   │       └── box_office_sample.json
│   │   └── LaunchScreen.storyboard
│   ├── View
│   │   ├── BoxOfficeContentView.swift
│   │   ├── BoxOfficeListCell.swift
│   │   └── CategoryStackView.swift
│   └── ViewController
│       ├── BoxOfficeViewController.swift
│       └── MovieDetailViewController.swift
├── BoxOfficeJsonDecoderTests
│   └── BoxOfficeJsonDecoderTests.swift
├── NetworkManagerTests
│   ├── BoxOfficeProviderTests.swift
│   ├── JsonLoader.swift
│   ├── MockURLSession.swift
│   └── MockURLSessionDataTask.swift
└── SearchedMovieImageDTOTests
    └── SearchedMovieImageDTOTests.swift
```

</details>

</br>

<details>
    <summary><big>UML</big></big></summary>
    
### 일일 박스오피스화면, 영화상세정보 화면
![](https://i.imgur.com/LMOlUfI.png)

### Network Layer
![](https://i.imgur.com/q5hUvNT.png)

</details>

</br>


## 4. 실행 화면

| 앱 시작후 로딩 | 메인 | 스크롤 했을 시 새로고침 |
| :--------: | :--------: | :--------: |
| ![](https://i.imgur.com/r9jLxBF.gif) | ![](https://i.imgur.com/sTsfKnC.gif)| ![](https://i.imgur.com/Q1nICDr.gif) |


| 목록 클릭시 화면 이동 |
| :--------: |
| ![](https://i.imgur.com/1wQ5Z8R.gif) |


</br>

## 5. 트러블 슈팅

### 1️⃣ parsing한 데이터 유닛테스트
json의 담긴 데이터를 가져오기 위해 jsonDecoder를 사용하여 데이터를 파싱하였습니다. 정확한 비교를 하기 위해서는 예상한 데이터들과 파싱한 데이터들을 하나하나 비교해야하는데 그렇게 하는 것은 데이터의 양이 너무 많아 테스트 하는 코드가 기존의 코드보다 길어진다는 것과 코드가 길어지면서 휴먼에러가 발생한다는 문제가 발생하였습니다.

이것을 정확히 해결하는 방법은 아니지만 일부의 데이터를 비교했을 때 데이터들이 일치한다고 하면 파싱한 데이터가 전부 일치한다고 생각하여 일부만 비교하여 일치하는지 확인하는 테스트를 진행하였습니다.

```swift
    // given
        let assetName = "box_office_sample"
        let expectedBoxOfficeType = "일별 박스오피스"
        let expectedFirstMovieName = "경관의 피"
        
    // when, then
        do {
            let result = try sut.loadJsonData(name: assetName, type: BoxOffice.self)
            XCTAssertEqual(expectedBoxOfficeType, result.boxOfficeResult.boxOfficeType)
            XCTAssertEqual(
                expectedFirstMovieName,
                result.boxOfficeResult.dailyBoxOfficeList[0].movieName
            )
        } catch {
            XCTFail("The loadJsonData was not supposed to throw an Error")
        }
```

### 2️⃣ URL Endpoint관리
api를 호출할 때 하드코딩 된 url을 통째로 넣어서 요청했습니다. 
하지만 이는 url에 쿼리 파라미터를 추가하는 경우에 보일러 플레이트 코드가 발생하기에 URL을 만들어주는 객체가 있으면 좋겠다는 생각이 들었습니다.

* ### BoxOfficeAPI의 사용
```swift
enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    case detailMovieInformation(movieCode: String)
    
    static let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    
    static func makeForEndpoint(_ endpoint: String) -> URL? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        
        return url
    }
}
```
case별로 분류하고 쿼리파라미터에 해당하는 값을 받아 `도메인+경로+api키+엔드포인트`에 해당하는 URL을 반환하는 객체를 만들었습니다. 

하지만 이 경우 현재 요청하는 URL의 HttpMethod는 명시되어있지 않기 때문에 이와 같은 헤더부분 또한 넣어줘서 URLReqeust를 만들어 반환해주는 객체를 만들어야겠다고 생각했습니다.

### 3️⃣ URL Endpoint관리2
위 관리방법은 Get요청에 대해서만 URL을 만들어주는 방식이었습니다.
Get중에서도 header나 body가 필요한 요청이 존재하고, 추후 Post요청까지 할 것을 대비해 Moya 라이브러리를 살펴보면서 확장성을 개선했습니다. 

먼저 하나의 프로젝트에서 여러가지 API를 이용할 수 있기 때문에 API의 역할을 띄는(하나의 서버안에서 경로에 따라 다른 자원을 요청할 수 있는) 프로토콜을 정의한 뒤 채택해서 구체화 시켰습니다.
```swift
protocol Requestable {
    var urlComponents: URLComponents? { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
}

enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    case detailMovieInformation(movieCode: String)
}

// BoxOfficeAPI
extension BoxOfficeAPI: Requestable {
    // ...
}


enum DaumAPI {
    case searchImage(movieName: String)
}

// DaumAPI
extension DaumAPI: Requestable {
}
```

endPoint는 url, header, httpMethod, task(작업의 종류)에 따라 다양한 종류의 urlRequest를 만들어주는 역할이라고 생각했습니다. 
본래 이 공간에는 encode하는 작업도 있지만 이번 프로젝트에서는 post요청을 하지않아 아래처럼 단순한 구조로 구현했습니다.

```swift
final class Endpoint {
    let url: String
    let method: HttpMethod
    let headers: [String: String]?
    
    init(url: String, method: HttpMethod, headers: [String: String]?) {
        self.url = url
        self.method = method
        self.headers = headers
    }
}

extension Endpoint {
    func urlRequest() -> URLRequest? {
        guard let requestURL = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        headers?.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
}
```

마지막으로 위에 정의한 API와 Endpoint를 이용해 실제로 Session에게 작업을 요청하는 부분을 담고있는 타입을 `BoxOfficeProvider`클래스로 정의했습니다. 

BoxOffice에서 사용하는 API에 대한 메서드를 제공하고 있기에 네이밍을 다음과 같이 정의했고 이는 `Provider`프로토콜을 채택함으로써 API를 제공하는 타입의 역할을 명확하게 했습니다.

```swift
protocol Provider {
    // associatedtype: 사용시점에 정해지는 타입.
    associatedtype Target
    func fetchData<T: Decodable>(_ target: Target,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
}

// 제네릭으로 Target을 받고있기 때문에 외부에서 주입한 타입이 Target이 된다.
struct BoxOfficeProvider<Target: Requestable>: Provider {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    // BoxOfficeProvider정의 당시에 제네릭으로 Target을 받고있기 때문에 호출할 때 편의성 제공
    func fetchData<T>(_ target: Target,
                      type: T.Type,
                      completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        // 현재 들어온 target(API의 종류)를 통해 Endpoint를 생성, Endpoint에서 URLRequest생성
        guard let endPoint = self.makeEndpoint(for: target),
              let request = endPoint.urlRequest() else {
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.checkError(with: data, response, error)
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(type, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NetworkError.failToParse))
                }
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
// ...   
}
```

사용법 
```swift
let boxOfficeProvider = BoxOfficeProvider<DaumAPI>()
boxOfficeProvider.fetchData(.searchImage(movieName: "메이플스토리"), type: SearchedMovieImageDTO.self) { result in
}
```

### 4️⃣ Cell 재사용 문제
tableView와 마찬가지로 collectionView에서도 cell을 재사용하여 UI를 그려주게 됩니다. 따라서 스크롤을 움직여서 몇몇의 cell이 안보이게 한 후 다시 그려주는 작업을 수행하게 하면 cell의 속성 값이 그대로 남아 적용되는 것을 확인하였습니다.

처음에는 prepareForReuse메서드를 사용하려 했지만 저희의 코드 상 cell이 UI적 요소들을 가지고 있는게 아닌 item이라는 프로퍼티를 가지고 있었기에 prepareForReuse를 사용하기가 어려웠습니다.
```swift
final class BoxOfficeListCell: UICollectionViewListCell {
    var item: BoxOfficeItem?
    
    override func updateConfiguration(using state: UICellConfigurationState) {}
}
```

저희가 해결한 방식은 UI를 그리기 전 재사용되던 속성 값들을 초기화 한 후 다시 UI를 그리는 방법으로 해결하였습니다.

```swift
rankIncrementLabel.text = nil
rankIncrementLabel.textColor = .black
```


### 5️⃣ UICollectionViewListCell, ContentConfiguration의 사용
요구사항의 뷰를 보고 테이블 뷰로 구현할 지, 컬렉션 뷰로 구현할 지, CollectionListCell을 이용해서 구현할 지 고민했습니다.

테이블 뷰와 컬렉션 뷰로 충분히 구현이 가능해보였지만 ContentConfiguration의 이점으로 상태에 따른 셀의 외형, 외형, 데이터 주입을 분리할 수 있다는 점에서 CollectionViewListCell을 이용했습니다.

하지만 평범한 UICollectionViewListCell은 text, secondaryText 등의 기본적인 프로퍼티만 존재했습니다.
이번 프로젝트에서는 랭킹이 어제에 비해 얼만큼 증가 혹은 감소하였는가와 같은 레이블이 필요했고 추후 셀의 레이아웃에 무언가 추가가 되었을 때 기존에 존재하는 text같은 요소들은 사용하지 않을 수 있기 때문에(다른 무언가 요소로 대체가 되는 경우가 있을 것 같습니다) UICollectionViewListCell를 상속받은 커스텀 ListCell을 만들게 되었습니다.

ListCell을 커스텀하게 만들게 되면 셀에 보여지는 데이터(ContentView)또한 만들어야 합니다. 만약 ContentView를 직접 만들지 않는다면 UICollectionViewListCell을 상속받은 기본 레이아웃에서 원하는 View를 추가하는 경우만 가능할 것이라고 생각했습니다.

이 때문에 BoxOfficeListCell, BoxOfficeContentView, BoxOfficeContentConfiguration 세 개의 커스텀 타입을 정의했습니다.

### BoxOfficeListCell
```swift
final class BoxOfficeListCell: UICollectionViewListCell {
    var item: BoxOfficeItem?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = BoxOfficeContentConfiguration().updated(for: state)
        newConfiguration.rank = item?.rank
        newConfiguration.rankIncrement = item?.rankIncrement
        newConfiguration.rankOldAndNew = item?.rankOldAndNew
        newConfiguration.title = item?.title
        newConfiguration.audienceCount = item?.audienceCount
        newConfiguration.audienceAccumulationCount = item?.audienceAccumulationCount
        
        contentConfiguration = newConfiguration
    }
}
```
### BoxOfficeContentView
```swift
final class BoxOfficeContentView: UIView, UIContentView {
    private var currentConfiguration: BoxOfficeContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            return currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? BoxOfficeContent else {
                return
            }
            
            apply(configuration: newConfigureation)
        }
    }
    
    let rankLabel: UILabel
    // ...
    
    func setupAllViews() {
        // 오토레이아웃 설정
    }
    
    func apply(configuration: BoxOfficeContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        
        currentConfiguration = configuration
        
        rankLabel.text = configuration.rank
        // configuration에 담긴 데이터, 스타일 설정
    }
}
```
### BoxOfficeContentConfiguration
```swift
struct BoxOfficeContentConfiguration: UIContentConfiguration, Hashable {
    var rank: String?
    var rankIncrement: String?
    var rankColor: UIColor?
    
    func makeContentView() -> UIView & UIContentView {
        return BoxOfficeContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        guard let state = state as? UICellConfigurationState else {
            return self
        }
        
        let updatedConfiguration = self
        
        if state == .isSelected {
            // ...
        } else {
            // ...
        }
        
        return updatedConfiguration
    }
}
```

BoxOfficeListCell에서는 데이터를 주입하고, BoxOfficeContentConfiguration에서는 현재 상태에 맞는 구성을 제공해줍니다. 그리고 BoxOfficeContentView에서는 화면에 보여지는 셀의 요소들을 보여주는 역할을 합니다.

이와 같이 역할을 분리함으로써 상태에 따른 모든 코드를 같은 객체에 정의하는 것을 피했습니다

<br>

## 6. 참고 링크
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Article - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Closure](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [우아한 형제들 - iOS Networking and Testing](https://techblog.woowahan.com/2704/)
- [네트워크와 무관한 URLSession Unit Test](https://wody.tistory.com/10)
- [mock 이용한 URLSession Unit Test](https://sujinnaljin.medium.com/swift-mock-%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-network-unit-test-%ED%95%98%EA%B8%B0-a69570defb41)
- [info.plist api키 가리기](https://velog.io/@loopbackseal/Swift-Plist%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%B4%EC%84%9C-API-key%EB%AF%BC%EA%B0%90%EC%A0%95%EB%B3%B4-%EA%B0%80%EB%A6%AC%EA%B8%B0)
- [Apple Docs - UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [Apple Docs - contentConfiguration](https://developer.apple.com/documentation/uikit/uitableviewcell/3601057-contentconfiguration)
- [WWDC - Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [UICollectionView List with Custom Cell and Custom Configuration](https://swiftsenpai.com/development/uicollectionview-list-custom-cell/)
- [Moya github](https://github.com/Moya/Moya)
---
