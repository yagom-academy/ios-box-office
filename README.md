# 박스 오피스 🎥

> 소개: 영화진흥위원회 API를 사용하여 영화정보들을 알려주는 어플

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

<details>
    <summary><big>타임라인</big></big></summary>

### 프로젝트 진행 기간
**23.03.20 (월) ~ 23.04.14 (금)** 

| 날짜 | 타임라인 |
| --- | --- |
|23.03.20 (월)| BoxOffice<br>DailyBoxOffice모델 구현<br>BoxOfficeJsonDecoder 구현 및 테스트케이스 작성 |
|23.03.21 (화)| NetworkManager<br>BoxOfficeAPI, MovieInformation<br> MovieDetail Infomation모델 구현 및 Mock객체를 이용한 테스트 케이스 작성 |
|23.03.22 (수)| Modern Collection View 학습 |
|23.03.23 (목)| Modern Cell API(ContentConfiguration) 학습|
|23.03.24 (금)| URL 만드는 기능에 Http method 추가|
|23.03.25 (토)| BoxOffirceProvide<br> Endpoint 정의 |
|23.03.27 (월)| activityIndicator 구현<br>BoxOfficeItem구조체 구현<br>setupAllViews 메서드 구현<br> BoxOfficeListCell 구현<br> BoxOfficeContentView내 apply구현 |
|23.03.28 (화)| DiffableDataSource, CompositionalLayout 구현<br> BoxOfficeContentView autolayout 구현<br> refreshControl 구현<br> Numberformat 구현|
|23.03.29 (수)| indentifiable 적용, 다이나믹 타입 적용 |
|23.03.30 (목)| DaumAPI 구현<br> Requsetable headers 추가<br> SearchedMovieImageDTO 구현 및 테스트 구현 |
|23.03.31 (금)| MovieDetailViewController 구현<br> MovieDetailInformation 구현<br> CategoryStackView 구현<br> fetchMoviePoster 메서드 구현 |
|23.04.03 (월)| MovieDetailViewController image 로딩 구현<br>AlertManager 싱글톤 구현 |
|23.04.04 (화)| CalendarViewController 구현<br>날짜 선택 navigation item button 구현<br> DataChangeable delegate 구현 |
|23.04.05 (수)| ToolBar 버튼 구현<br>화면 모드변경 클릭 시 actionsheet생성<br>BoxOfficeGridCell 구현<br>|
|23.04.06 (목)| 화면 모드 변경 기능 구현<br> 메인화면 DynamicType 적용 |
|23.04.07 (금)| 영화 상세정보 화면 DynamicType 적용 |
|23.04.10 (월)| colletionView 안 보이던 오류 수정 |
|23.04.11 (화)| URLCacheManger 구현 |
|23.04.13 (목)| URLCache 정책 설정 및 구현 |
|23.04.14 (금)| 영화 상세정보 화면 오토레이아웃 수정 |

</details>
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
│   │   ├── MovieDetailInformationItem.swift
│   │   ├── Alertmangaer.swift
│   │   └── LayoutType.swift
│   ├── Network
│   │   ├── BoxOfficeAPI.swift
│   │   ├── BoxOfficeProvider.swift
│   │   ├── DaumAPI.swift
│   │   ├── Endpoint.swift
│   │   ├── HttpMethod.swift
│   │   ├── Requestable.swift
│   │   ├── URLSessionDataTaskProtocol.swift
│   │   ├── URLSessionProtocol.swift
│   │   └── URLCacheManager.swift
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   │   └── box_office_sample.dataset
│   │   │       └── box_office_sample.json
│   │   └── LaunchScreen.storyboard
│   ├── View
│   │   ├── BoxOfficeContentView.swift
│   │   ├── BoxOfficeListCell.swift
│   │   ├── BoxOfficeGridCell.swift
│   │   ├── CategoryStackView.swift
│   │   └── MovieInformationStackView.swift
│   └── ViewController
│       ├── BoxOfficeViewController.swift
│       ├── CalendarViewController.swift
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
![](https://i.imgur.com/TWLVwgt.png)

### Network Layer
![](https://i.imgur.com/OF0Hs5Z.png)

</details>

</br>


## 4. 실행 화면

| 앱 시작후 로딩 | 메인 | 스크롤 했을 시 새로고침 |
| :--------: | :--------: | :--------: |
| ![](https://i.imgur.com/r9jLxBF.gif) | ![](https://i.imgur.com/sTsfKnC.gif)| ![](https://i.imgur.com/Q1nICDr.gif) |


| 목록 클릭시 화면 이동 | 날짜 선택 및 선택한 날짜 표시| 날짜 선택 스크롤시 새로고침 |
| :--------: |:---:| :---: |
| ![](https://i.imgur.com/1wQ5Z8R.gif) | ![](https://i.imgur.com/OiNHjKa.gif) | ![](https://i.imgur.com/bF8khC8.gif) |


| 화면 모드 전환 | 아이콘 클릭 | 캐시 후 속도 향상 |
| :--------: | :--------: | :--------: |
| ![](https://i.imgur.com/QRCoB3R.gif) | ![](https://i.imgur.com/APhSgfo.gif) | ![](https://i.imgur.com/HHRl8cA.gif) |


| 가로화면 1 <br/> 일일 박스 오피스 |
| :--------: |
| <img src="https://i.imgur.com/1cC6Jzv.gif" width="500" height="250"> |

| 가로화면 2 <br/> 영화 상세 정보 |
| :---: |
| <img src="https://i.imgur.com/VtOFUY9.gif" width="500" height="250"> |




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
> URL을 생성해주는 객체뿐만 아니라 URLRequest를 만들어내는 객체를 정의했습니다.
### ⚒️ 특정 API에 사용되는 URL을 만드는 객체 생성
초기에는 api를 호출할 때 하드코딩 된 url을 통째로 넣어서 요청했습니다. 
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
<br/>
<br/>


### ⚒️ URLRequest를 만드는 EndPoint객체 생성
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

### 3️⃣ Cell 재사용 문제
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


### 4️⃣ UICollectionViewListCell, ContentConfiguration의 사용
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

이와 같이 역할을 분리함으로써 상태에 따른 모든 코드를 같은 객체에 정의하는 것을 피했습니다.

<br>

### 5️⃣ ClipsToBound사용을 통한 이미지 뷰 짤리는 현상 해결
이미지 뷰를 오토레이아웃해서 `width`의 값을 루트 view의 0.9배율로 설정해주었는데 정해준 width를 넘어가는 일이 발생했었습니다.
처음에는 이미지의 contentMode 중 하나인 `scaleToFill`을 사용하면 이미지의 크기가 이미지 뷰를 넘어가지 않고 나머지 모드에서는 넘어갔기 때문에 이것이 문제의 원인이라고 생각했습니다.

하지만 `scaleAspectFit`, `scaleAspectFill`, `scaleToFill`은 이미지 뷰 비율을 유지하면서 이미지를 늘리거나 이미지를 꽉 채우는 등의 행동을 할 뿐이고 정해진 이미지 뷰가 `contentMode`에 따라 커질 수 있다는 내용은 찾아볼 수 없었습니다. 
그리고 viewHierachy에서도 imageView자체는 0.9배율로 잘 설정된 것을 볼 수 있었습니다.

그러던 중 `clipsToBound`라는 속성을 찾아보게 되었습니다. 

#### clipsTobound
> subview들이 view의 bound에 제한이 될지 말지를 결정하는 Bool 값.

이 값이 true라면 서브뷰들이 뷰의 bound 내로 잘리게 됩니다. 그렇지 않으면 서브뷰들의 프레임이 뷰의 bound를 넘어도 잘리지 않게 됩니다. 
이는 기본값이 false이기 때문에 따로 설정해주지않으면 이미지가 뷰의 bound를 넘어간다면 설정한 뷰의 제약사항보다 더 큰 subView인 이미지가 화면에 보여지게 됩니다.

따라서 이미지 뷰의 이 속성을 true로 설정함으로써 이미지가 뷰의 bound내로 설정되어 이미지 뷰 만큼 이미지가 보여지게 할 수 있었습니다.

<br>

### 6️⃣ 하나의 DataSource 내에 두 개의 셀을 등록함으로써 두 개의 레이아웃 구성
토글 버튼을 통해 리스트 형식의 레이아웃을 그리드 형식으로 변환해야 했습니다.

처음에는 리스트 형식의 셀과 그리드 형식의 셀이 다르기 때문에 토글버튼을 통해 레이아웃이 변경될 때 데이터소스에 새로운 셀을 등록시켜야 한다고 생각했습니다.
```swift
private func updateLayout() {
    self.layoutType = self.layoutType == .list ? .grid : .list
    self.configureDataSource(for: self.layoutType)
    self.collectionView.setCollectionViewLayout(self.createLayout(for: self.layoutType),
                                                animated: false)
    self.dataSource.apply(self.snapshot, animatingDifferences: true)
}

private func configureDataSource(for layout: LayoutType = .list) {
    let listCellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, BoxOfficeItem> {
        (cell, indexPath, item) in
        cell.item = item
    }

    let gridRegistration = UICollectionView.CellRegistration<BoxOfficeGridCell, BoxOfficeItem> {
        (cell, indexPath, item) in
        cell.configure(boxOfficeItem: item)
    }

    dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeItem.ID>(collectionView: collectionView) {
        (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeItem.ID) -> UICollectionViewCell? in

        let boxOfficeItem = self.boxOfficeItems.filter { $0.id == identifier }.first
        switch layout {
        case .list:
            let cell = collectionView.dequeueConfiguredReusableCell(using: listCellRegistration,
                                                                    for: indexPath,
                                                                    item: boxOfficeItem)
            return cell
        case .grid:
            let cell = collectionView.dequeueConfiguredReusableCell(using: gridRegistration,
                                                                    for: indexPath,
                                                                    item: boxOfficeItem)
            return cell
        }
    }
}
```
이를 구현하기 위해 레이아웃 타입을 변경한 후에 변경된 레이아웃 타입을 기반으로 셀이 구성되고 이를 데이터소스에서 등록하는 함수를 호출했습니다.

하지만 토글이 되더라도 셀에 사용되는 데이터는 같은데 데이터소스 인스턴스가 새롭게 생성되고 할당되는 것이 비효율적인 비용이라고 생각했습니다. 

이 고민을 하면서 컬렉션 뷰에는 cell을 새롭게 구성할 수 있는 `reloadData`가 있는 것을 알게되었습니다.

이 메서드는 현재 컬렉션 뷰의 보여지는 셀을 제거한 후에 dataSource 객체의 현재 상태에 따라 재생성하는 메서드입니다.

레이아웃타입을 변경한 후 이 메서드를 직접 호출함으로써 현재 데이터소스의 레이아웃 타입 상태변경으로 인해 셀을 새롭게 등록해서 변경해주었습니다. 

이후 컬렉션뷰의 `setCollectionViewLayout`을 사용함으로써 토글버튼에 따라 레이아웃이 변경되도록 만들었습니다.
```swift
private func updateLayout() {
    self.layoutType = self.layoutType == .list ? .grid : .list
    self.collectionView.reloadData()
    self.collectionView.setCollectionViewLayout(self.createLayout(for: self.layoutType),
                                                animated: true)
}
```
<br/>
<br/>

### 7️⃣ URLCache를 통한 네트워크 데이터 응답 캐시
네트워크에 여러번 접근하는 비용을 줄이기 위해 어떤 종류의 캐시를 이용해야 현재 상황에 알맞은 지에 대한 고민이 있었습니다.

관련된 캐시방법으로는 `NSCache`와 `URLCache`가 존재했는데요 `NSCache`대신 `URLCache`를 사용한 이유는 다음과 같았습니다.

NSCache는 in-memory에서 데이터를 가져오기 때문에 on-disk를 사용하는 URLCache보다 빠르다는 장점이 있습니다.
하지만 NSCache는 비휘발성이기에 앱을 종료하고 다시 들어온다면 네트워크와의 연결을 재시도해야합니다. 또한 in-memory는 메모리 청크에 할당하기 때문에 메모리에 많은 데이터들이 올라와있는 상황이라면 성능이 저하될 수 있습니다.

반면에 URLCache는 in-memory와 on-disk방식 둘 다 사용할 수 있고 on-disk의 경우 디스크를 사용하기 때문에 메모리 청크를 할당하지않습니다. 또한 디스크의 크기를 정할 수 있다는 점에서 유연합니다.

그리고 네트워크를 통해 받아온 데이터의 크기는 약 6000바이트로 상당히 크기에 NSCache로 구현한 경우 메모리가 금방 초과되어 제거될 가능성이 높다고 생각했습니다. 따라서 on-disk방식의 URLCache를 사용하는 것으로 결정했습니다.

`URLCache.shared`에 중복해서 접근하기 보다는 `URLCacheManager`라는 싱글톤 객체를 만들어 디스크 용량부터 정책까지 커스텀 된 타입을 정의해서 관리했습니다. 
이를 통해 가독성과 활용성을 향상시켰습니다.

#### 
```swift
struct URLCacheManager {
    static let shared = URLCacheManager()
    private var urlCache: URLCache
    
    private init() {
        urlCache = URLCache(memoryCapacity: 0, diskCapacity: 100 * 1024 * 1024)
    }
    
    func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        guard let response = urlCache.cachedResponse(for: request) else {
            return nil
        }
        
        return response
    }
    
    func createCachedResponse(response: URLResponse?, data: Data) throws -> CachedURLResponse {
        guard let response else {
            throw NetworkError.invalidResponseError
        }
        
        return CachedURLResponse(response: response,
                                 data: data,
                                 storagePolicy: .allowed)
    }
    
    func storeCachedResponse(for cachedResponse: CachedURLResponse, request: URLRequest) {
        urlCache.storeCachedResponse(cachedResponse, for: request)
    }
}
```
<br/>
<br/>

### 8️⃣ Query 순서 보장
처음 구현할 때 저희는 query의 순서를 고려하지 않고 forEach문을 사용하여 query를 추가하였습니다.
```swift
self.queries.forEach { queryItem in
    let queryItem = URLQueryItem(name: queryItem.key, value: queryItem.value)
    queriesItem.append(queryItem)
}
```
위에 코드로 인해 쿼리의 순서가 무작위로 더해져 cache를 할때 cache를 저장하는 값이 달라져 같은 데이터임에도 다른 캐시를 저장할때가 있었습니다. 이러한 문제점을 해결하고자 저희는 sorted메서드를 사용하여 순서를 보장하도록 만들어 동일한 캐시를 저장할 수 있게 하였습니다.
```swift
self.queries.sorted(by:<).forEach { queryItem in
    let queryItem = URLQueryItem(name: queryItem.key, value: queryItem.value)
    queriesItem.append(queryItem)
}
```

<br/>

<details>
    <summary><big>팀 회고</big></big></summary>

### 잘한 점
- 특정 주제에 대해 계속 파고들면서 얘기를 나눠, 더 깊은 이해를 가졌다.(ex. 캐시정책은 무엇이고 iOS에서는 어떻게 사용되면서 만료된 데이터들은 어떤 시점에 제거해주는 게 효율적일까)
- 서로의 의견을 존중해주고 적극적으로 코드에 녹여냈다.
- 서로의 개인적인 시간을 잘 이해해줬다.


### 아쉬운 점
- rebase를 진행하면서 commit이 한 사람에게 몰린 branch가 존재한다.
- 다이나믹 타입을 적용하면서 해결하지 못한 부분이 존재하고 이 부분에 대해 원인을 정확하게 파악하지 못했다.

</details>

<br/>

## 6. 참고 링크
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Article - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Apple Docs - UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [Apple Docs - contentConfiguration](https://developer.apple.com/documentation/uikit/uitableviewcell/3601057-contentconfiguration)
- [Apple Docs - reloadData](https://developer.apple.com/documentation/uikit/uicollectionview/1618078-reloaddata)
- [Apple Docs - ClipsToBound](https://developer.apple.com/documentation/uikit/uiview/1622415-clipstobounds)
- [Apple Docs - ImageView ContentMode](https://developer.apple.com/documentation/uikit/uiview/contentmode)
- [Apple Docs - URLCache](https://developer.apple.com/documentation/foundation/urlcache)
- [Apple Docs - NSCache](https://developer.apple.com/documentation/foundation/nscache)
- [WWDC - Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [To NSCache or not to NSCache, what is the URLCache](https://medium.com/@master13sust/to-nscache-or-not-to-nscache-what-is-the-urlcache-35a0c3b02598)
- [Closure](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [우아한 형제들 - iOS Networking and Testing](https://techblog.woowahan.com/2704/)
- [네트워크와 무관한 URLSession Unit Test](https://wody.tistory.com/10)
- [mock 이용한 URLSession Unit Test](https://sujinnaljin.medium.com/swift-mock-%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-network-unit-test-%ED%95%98%EA%B8%B0-a69570defb41)
- [info.plist api키 가리기](https://velog.io/@loopbackseal/Swift-Plist%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%B4%EC%84%9C-API-key%EB%AF%BC%EA%B0%90%EC%A0%95%EB%B3%B4-%EA%B0%80%EB%A6%AC%EA%B8%B0)
- [UICollectionView List with Custom Cell and Custom Configuration](https://swiftsenpai.com/development/uicollectionview-list-custom-cell/)
- [Moya github](https://github.com/Moya/Moya)
---
