# 박스오피스
> 영화진흥위원회 웹 사이트에서 전달받은 데이터를 표시하는 앱
> 
> 프로젝트 기간: 2023.03.20-2023.03.31
> 

## 팀원
| kokkilE | 리지 |
| :--------: |  :--------: | 
| <Img src ="https://i.imgur.com/4I8bNFT.png" width="200" height="200"/>      |<Img src ="https://user-images.githubusercontent.com/114971172/221088543-6f6a8d09-7081-4e61-a54a-77849a102af8.png" width="200" height="200"/>
| [Github Profile](https://github.com/kokkilE) |[Github Profile](https://github.com/yijiye)


## 목차
1. [타임라인](#타임라인)
2. [프로젝트 구조](#프로젝트-구조)
3. [실행 화면](#실행-화면)
4. [트러블 슈팅](#트러블-슈팅) 
5. [핵심경험](#핵심경험)
6. [팀회고](#팀회고)
7. [참고 링크](#참고-링크)


# 타임라인 
- 2023.03.20 : Movie, BoxOffice 타입 구현 및 UnitTest
- 2023.03.21 : Decoder, MovieInformation, NetworkManager 타입 구현 및 step1 refactoring
- 2023.03.22 : Error 처리 구현, URL 관련 프로토콜 구현
- 2023.03.23 : 기존 NetworkManager 타입에서 Enpoint 타입 분리, refactorig
- 2023.03.24 : git merge 오류 해결, 불필요한 코드 삭제, README작성
- 2023.03.27 : ListCell을 활용하여 영화 목록 화면 UI 구현(StackView), viewController 기본 구현
- 2023.03.28 : CustomCollectionCell, collectionView 영화 목록 화면 구현
- 2023.03.29 : 상세 화면으로 전환, 상세화면 구현
- 2023.03.30 : MoviePosterImageView, ScrollView 구현
- 2023.03.31 : imageURL 로직 refactoring, JSON 데이터에서 필요한 데이터 타입 구현 refactoring, README 작성
<br/>


# 프로젝트 구조

## ClassDiagram

<img src="https://i.imgur.com/TphadWn.png">


## File Tree
```typescript
ios-box-office
├── BoxOffic
│   ├── Model
│   │   ├── JSON
│   │   │   ├── DailyBoxOffice.swift
│   │   │   ├── MovieInformation.swift
│   │   │   ├── MoviePosterImage.swift
│   │   │   └── Decoder.swift
│   │   ├── EndPoint
│   │   │   ├── HttpMethod.swift
│   │   │   └── BoxOfficeEndPoint.swift
│   │   └── Network
│   │       ├── NetworkError.swift
│   │       └── NetworkManager.swift
│   ├── View
│   │   ├── DailyBoxOfficeCollectionViewCell.swift
│   │   └── MovieInformationScrollView.swift
│   ├── Controller
│   │   ├── DailyBoxOfficeViewController.swift
│   │   └── MovieInformationViewController.swift
│   ├── Resources
│   │   └── Assets.xcassets
│   └── Application
│       ├── AppDelegate.swift
│       ├── Base.lproj
│       └── SceneDelegate.swift
├── BoxOfficeTests
│   └── BoxOfficeTests.swift
└── NetworkManagerTest
    ├── MockNetworkManager.swift
    ├── MockURLProtocol.swift
    └── NetworkManagerTest.swift
```

 <br/>  

# 실행 화면

|<center>초기화면<br>일일 박스 오피스</center>|<center>당겨서 새로고침</center>|<center>상세 정보 화면으로 전환</center>|
| -- | -- | -- |
| <img src = "https://i.imgur.com/8Uvh2al.gif" width = 250> |<img src = "https://i.imgur.com/d8Boyco.gif" width = 250> |<img src = "https://i.imgur.com/5hNBSol.gif" width = 250> |

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
위 설계에서 느낀 첫 번째 문제는 타입 내에서 `HTTP method`, `HTTP Body` 등 엔드포인트로서 역할을 하기엔 부족한 정보를 담고 있었다는 점이었고, 두 번째 문제는 조회하고자하는 정보가 추가된다면 새로운 타입을 구현해야한다는 점이었습니다.

조회하고자 하는 정보가 추가되어 새로운 형태의 데이터의 추가가 필요할 경우 프로토콜을 정의하고 `EndPoint`가 해당 프로토콜을 채택하여 필요한 메서드를 구현하도록 변경하였습니다.

**1차 수정 후**
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

그러나 이렇게 구현하면 문제점은 viewController에서 너무 많은 정보를 받아야 한다는 문제가 있었습니다.

### ⚒️ 해결방안

viewController에서 endPoint 인스턴스를 만들면 모든 정보가 이미 담아지도록 구현하였습니다.
BoxOfficeEndPoint 타입을 구현하고 extension으로 케이스마다 구현되는 URL을 만들고, URLRequest를 반환하도록 구현하였습니다.
```swift
enum BoxOfficeEndPoint {
    case DailyBoxOffice(tagetDate: String, httpMethod: HttpMethod)
    case MovieInformation(movieCode: String, httpMethod: HttpMethod)
    case MoviePosterImage(query: String, httpMethod: HttpMethod)
}
```
<details>
    <summary> extension 코드 </summary>
    
```swift
extension BoxOfficeEndPoint {
    var baseURL: String {
        switch self {
        case .MoviePosterImage:
            return "https://dapi.kakao.com"
        case .DailyBoxOffice, .MovieInformation:
            return "http://www.kobis.or.kr"
        }
    }
    
    var path: String {
        switch self {
        case .DailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .MovieInformation:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .MoviePosterImage:
            return "/v2/search/image"
        }
    }
    
    var key: String {
        get {
            return "f5eef3421c602c6cb7ea224104795888"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .DailyBoxOffice(let targetDate, _):
            return [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "targetDt", value: targetDate)
            ]
        case .MovieInformation(let movieCode, _):
            return [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "movieCd", value: movieCode)
            ]
        case .MoviePosterImage(let query, _):
            return [
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
    
    var httpMethod: String {
        switch self {
        case .DailyBoxOffice(_, let method):
            return method.description
        case .MovieInformation(_, let method):
            return method.description
        case .MoviePosterImage(_, let method):
            return method.description
        }
    }
    
    func createURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return nil }
        
        return url
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = createURL() else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        switch self {
        case .MoviePosterImage:
            urlRequest.setValue("KakaoAK d470dcea6bc2ede97003aac7b84e2533", forHTTPHeaderField: "Authorization")
            return urlRequest
        case .DailyBoxOffice, .MovieInformation:
            return urlRequest
        }
    }
}
```
</details>

</br>

## 2️⃣ DiffableDataSource에 Hashable을 준수하는 key, value 값 전달하기 (JSON 파싱한 데이터 중 필요한 데이터 전달)
웹에서 받은 데이터를 JSON Decoder로 파싱하여 UICollectionViewCell에 전달하고자 `UICollectionViewDiffableDataSource`를 사용하였습니다.
`DiffableDataSource`는 데이터를 제공하기 위해 snapshot을 사용하는데, 이 `snapshot`은 section과 item의 key, value로 구성되어 있고 이 둘은 `Hashable` 프로토콜을 준수해야하는 조건이 필요합니다.

### 🔍 문제점
처음 구현한 방법은 value에 JSON`DailyBoxOffice` 타입에서 필요한 데이터인 Movie에 `Hashable`을 채택하였습니다.

```swift
struct DailyBoxOffice: Decodable {
   ...
    struct BoxOfficeResult: Decodable {
        ...
        let boxOfficeList: [Movie]
        ...        
        struct Movie: Decodable, Hashable {
            // Movie의 모든 프로퍼티
```
```swift
final class DailyBoxOfficeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice.BoxOfficeResult.Movie>
```

이렇게 `Decodable`을 채택한 모델에 `Hashable`까지 같이 채택을 하게 되니, `DiffableDataSource`의 관심사는 Movie안에서 필요한 몇개의 data 인데 불필요하게 많은 내용까지 알게되는 문제가 있었습니다.

### ⚒️ 해결방안
`DiffableDataSource`에서 필요한 데이터만 따로 타입을 만들고 그 타입이 Hashable을 채택하도록 하여 JSON decoder의 관심사와 `DiffableDataSource`의 관심사를 분리하였습니다.

```swift
struct MovieItem: Hashable {
    init(from movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        self.rank = movie.rank
        self.rankVariance = movie.rankVariance
        self.rankOldAndNew = movie.rankOldAndNew
        self.code = movie.code
        self.name = movie.name
        self.audienceCount = movie.audienceCount
        self.audienceAccumulation = movie.audienceAccumulation
    }

    let identifier = UUID() // uniqueIdentifier를 주기 위해 구현
    let rank: String
    let rankVariance: String
    let rankOldAndNew: String
    let code: String
    let name: String
    let audienceCount: String
    let audienceAccumulation: String
}
```
```swift
final class DailyBoxOfficeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieItem>
    ...
    private func fetchDailyBoxOfficeData() {
        guard let endPoint = boxOfficeEndPoint else { return }
        
        networkManager.request(endPoint: endPoint, returnType: DailyBoxOffice.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                // movieItems 타입의 프로퍼티안에 전달받은 값 중 필요한 값들만 골라 넣어줌
                for index in 0..<result.boxOfficeResult.boxOfficeList.count {
                    self?.movieItems.append(MovieItem.init(from: result.boxOfficeResult.boxOfficeList[index]))
                }
            ...
```
 <br/>

## 3️⃣ URL로 Image 받아오기
영화 포스터 이미지를 받아오기 위해 API를 설계하여 통신을 통해 Image의 URL을 받아왔습니다.
``` swift
enum BoxOfficeEndPoint {
    ...
    // 영화 포스터 이미지를 받아오기 위한 API
    case MoviePosterImage(query: String, httpMethod: HttpMethod)
}
```

통신에 성공해서 받아온 URL로 실제 이미지 데이터를 받아오는 과정이 필요했는데, `Data(contentsOf: )`를 사용하여 이미지를 가져오도록 다음과 같이 구현하였습니다.

``` swift
func load(url: URL, completion: @escaping () -> Void) {
         DispatchQueue.global().async { [weak self] in
             guard let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) else { return }
    ...
}
```
### 🔍 문제점
하지만 리뷰어의 코멘트를 받고 확인해보니, [공식 문서](https://developer.apple.com/documentation/foundation/nsdata/1413892-init)에서는 `Data(contentsOf: )`에 대하여 네트워크 통신에 사용하지 않을 것을 강조하고 있었습니다.

> **Important**
Don't use this synchronous initializer to request network-based URLs. For network-based URLs, this method can block the current thread for tens of seconds on a slow network, resulting in a poor user experience, and in iOS, may cause your app to be terminated.
Instead, for non-file URLs, consider using the dataTask(with:completionHandler:) method of the URLSession class. See Fetching Website Data into Memory for an example.

### ⚒️ 해결방안
공식 문서의 가이드에 따라 `Data(contentsOf: )`를 사용하는 대신 `dataTask(with:completionHandler:)` 메서드를 사용하였습니다.
``` swift
func load(url: URL, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask { ... }
    ...
}
```

## 4️⃣ compositionalLayout으로 화면 회전시 item, group 사이즈 조절

### 🔍 문제점
customCell로 구현했을 때, 세로 화면에서 보여지는 화면이 가로회전 되면 크기가 자동으로 맞춰지지 않는 문제가 있었습니다.
<details>
    <summary> customCell로 구현시 문제된 화면 </summary> 
<img src="https://i.imgur.com/8YG5K4q.gif" width=250><img src="https://i.imgur.com/pMio0Mi.gif" width=250>
</details>

저희가 생각한 문제의 원인은 UICollectionViewLayout을 잡는 곳에서 itemSize와 관련있다고 생각했습니다. 
  - **시도한 방법**
    - `.fractionalHeight(x)`: x 값을 0.1 보다 높여주어 회전했을 때 cell크기가 유지되도록 하였으나 세로 화면일 때 cell크기가 예시화면보다 큰 문제가 발생
    - `absolute(44.0)`, `estimated(44.0)` : 첨부한 첫 번째 화면과 같이 아래로 스크롤 했을 때, cell의 크기가 줄어들어 있거나 화면 회전시 화면을 벗어난 cell의 크기가 다른 cell보다 커지는 현상 발생
```swift
func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
```

### ⚒️ 해결방안
item들이 모여 group이 되기 때문에, group의 Size를 estimate 값으로 조절해 주었습니다. 또한 화면에 따라 view의 크기가 자동으로 맞춰지도록 collectionView와 그 위에 cell을 분리하는 용도인 separatorView의  autoresizingMask를 적용하여 문제를 해결하였습니다.

- `fractionalWidth` & `fractionalHeight`: 컨테이너와의 너비, 높이 비율
- `absolute`: 포인트값으로 지정
- `estimated`: 후에 content의 크기가 바뀌어 크기가 정확하지 않을 때는 estimate 값을 활용

```swift
private func createMovieListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
    ...
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
    
    ...
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    ...
    separatorView.autoresizingMask = .flexibleWidth
```

`NSCollectionLayoutEnvironment` 프로토콜에 접근하여 더 유연한 레이아웃을 잡을 수 있는데, [공식 문서](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayoutsectionprovider) 에 따르면 `UICollectionViewCompositionalLayout`의 `init`을 통해 해당 프로토콜에 접근이 가능합니다. 이번 프로젝트에서는 해당 프로토콜에 접근하는 방법을 적용해보지 않았습니다.

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
    <summary><big>✅ 테스트 케이스 작성 기준</big></summary> 

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
    <summary><big>✅ 새로고침 구현</big></summary> 

당겨서 새로고침 기능을 구현하기 위해 `UIRefreshControl` 타입을 사용했습니다.

새로 고침이 실행되는 도중에 새로고침을 반복할 경우 실행되지 않도록 방어할 필요가 있다고 생각했는데, 확인해보니 추가적인 구현 없이도 새로고침 도중에는  새로고침이 반복 실행되지 않도록 방어되고 있음을 확인했습니다.
`UIRefreshControl.isRefreshing` 을 통해 내부적으로 확인 후 새로고침이 실행되는 것으로 생각됩니다.

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
</details>

# 팀회고
### 우리팀이 잘한 점
- 리뷰어와 소통하여 이번 프로젝트에서 꼭 학습해야 할 내용을 끝까지 학습하였습니다.
- 팀원 모두 열정적으로 많은 시간을 투자했습니다.
- 학습내용을 충분히 이해하면서 프로젝트를 진행하였습니다.

### 서로 칭찬할 점
- 리지가 코낄이에게 🐘
   - 제가 이해하기 어려운 부분을 친절히 그리고 자세히 설명해주어 프로젝트하면서 많은 도움이 되었습니다.
   - 생각하는 부분을 명확히 전달해주고, 또 저의 의견도 적극 수용해주어 서로 좋은 토론을 할 수 있었습니다.
- 코낄이가 리지에게 🦄
   - 모든 주장의 근거를 공식문서에서 찾고자 노력했습니다. 저도 근거를 한번 더 생각하게되어 많은 도움이 되었습니다.
   - 학습할 내용을 이해하기 위해 노력했습니다. 저는 이해가 부족한 상태에서 구현부터 해보기도 했는데, 리지의 이런 점 덕분에 기본기를 많이 배울 수 있었습니다.

----

# 참고 링크
## 블로그
- [Test Double이란](https://jiseobkim.github.io/swift/2022/02/06/Swift-Test-Double(부제-Mock-&-Stub-&-SPY-이런게-뭐지-).html)
- [네트워크에 의존하지 않는 Test](https://velog.io/@leeyoungwoozz/iOS-네트워크에-의존하지-않는-Test)
- [Mock 을 이용한 Network Unit Test](https://sujinnaljin.medium.com/swift-mock-을-이용한-network-unit-test-하기-a69570defb41)
- [TestDouble-Mock](https://medium.com/@dhawaldawar/how-to-mock-urlsession-using-urlprotocol-8b74f389a67a)
- [kodeco-URLSession](https://www.kodeco.com/3244963-urlsession-tutorial-getting-started)

## 공식 문서
- [AppleDevelopment-URLProtocol](https://developer.apple.com/documentation/foundation/urlprotocol)
- [AppleDevelopment-dataTask](https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask)
- [AppleDevelopment-UICompositionalLayoyt](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)  
- [AppleDevelopment-UICollectionViewDiffabledatasource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [AppleDevelopment-NSDiffabledatasourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot#3561976)          
- [AppleDevelopment-UIRefreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
- [AppleDevelopment-autoresizingmask](https://developer.apple.com/documentation/uikit/uiview/1622559-autoresizingmask)

