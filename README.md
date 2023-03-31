# 박스오피스 🎬

> **소개: 영화진흥위원회 오픈 API, 카카오 이미지 검색 API를 사용하여 영화 정보를 조회할 수 있는 앱**


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

|[Harry](https://github.com/HarryHyeon)| [kaki](https://github.com/kak1x) |
| :--------: | :--------: |
|<img height="180px" src="https://i.imgur.com/BYdaDjU.png">| <img height="180px" src="https://i.imgur.com/KkFB7j3.png"> |

<br>

## 2. 타임라인
### 프로젝트 진행 기간
**23.03.20 (월) ~ 23.03.31 (금)** 

| 날짜 | 타임라인 |
| --- | --- |
|23.03.20 (월)| 박스오피스 모델 타입, 영화 상세정보 모델 타입 구현, 모델 테스트 |
|23.03.21 (화)| 원격 서버와 Http 통신을 위한 NetworkManager 타입 구현 |
|23.03.22 (수)| Endpoint를 생성가능한 BoxOfficeEndpoint 구현 |
|23.03.23 (목)| NetworkManager 테스트(MockURLSession, MockURLSessionDataTask 활용) |
|23.03.24 (금)| 코드 컨벤션 수정, Pull Request 컨플릭 해결, README 작성, CollectionView CompositionalLayout / Identifying 프로토콜 구현 |
|23.03.27 (월)| JSON 모델 분리 및 사용하지 않는 프로퍼티 삭제, CollectionViewListCell / Activity Indicator / Refresh Control 구현 |
|23.03.28 (화)| CollectionViewListCell 오토레이아웃 수정 및 셀 데이터 할당 기능 구현 |
|23.03.29 (수)| URLRequest 요청으로 로직 변경, MovieInfoViewController / ScrollView / 포스터 이미지 및 영화 상세정보 fetch 기능 구현 |
|23.03.30 (목)| 코드 컨벤션 수정, DataFormatter 타입 프로퍼티 사용으로 변경 |
|23.03.31 (금)| 사용 API 변경 (네이버 영화 -> 카카오 이미지), MovieInfoViewController 오토레이아웃 수정, Activity Indicator 구현 |

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
    |    │    ├── BoxOfficeEndpoint
    |    │    ├── URLSessionProtocol
    |    │    └── URLSessionDataTaskProtocol
    |    └── JSONModel
    |         ├── BoxOffice
    |         │    ├── BoxOffice
    |         │    ├── BoxOfficeResult
    |         │    ├── DailyBoxOffice
    |         │    └── RankOldAndNew
    |         │── Movie
    |         │    ├── Movie
    |         │    ├── MovieInfoResult
    |         │    ├── MovieInfo
    |         │    ├── Actor
    |         │    ├── Audit
    |         │    ├── Director
    |         │    ├── Genre
    |         │    └── Nation
    |         └── MoviePoster
    |              └── MoviePoster
    ├── View
    |    ├── Main
    |    ├── LaunchScreen
    |    ├── BoxOfficeCollectionViewListCell.xib
    |    └── BoxOfficeCollectionViewListCell.swift
    ├── Controller
    |    ├── BoxOfficeViewController
    |    └── MovieInfoViewController
    ├── Etc
    |    ├── AppDelegate
    |    ├── SceneDelegate
    |    ├── Identifying
    |    ├── Array+Subscript
    |    ├── String+DecimalFormatter
    |    ├── DateFormmatter+HyphenFormat
    |    └── UIViewController+showFailAlert
    ├── Assets
    ├── Info
    └── UnitTests
         ├── BoxOfficeTests
         │    └── BoxOfficeTests
         ├── MovieTests
         │    └── BoxOfficeTests
         └── NetworkManagerTests
              ├── NetworkManagerTests
              ├── SampleData
              └── Mocks
                   ├── MockURLSessionDataTask
                   └── MockURLSession
```

</details>

</br>

## 4. 실행 화면

|박스오피스 조회 화면|화면 정보 새로 고침|영화 상세 정보 페이지 이동|
|:-----:|:-----:|:-----:|
| <img src = "https://user-images.githubusercontent.com/51234397/229131236-f60a5e28-51d2-4cb5-b404-8b7c05d00fdc.gif" width = "300">|<img src = "https://user-images.githubusercontent.com/51234397/229131247-ddb94683-f139-41a3-956d-7547e165fee4.gif" width = "300"> |<img src = "https://user-images.githubusercontent.com/51234397/229131249-fb7f5665-9f3f-4dc2-94f4-992a40f2ee35.gif" width = "300">|

<br>

## 5. 트러블 슈팅

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

### 3️⃣ Endpoint를 관리하는 타입
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
- 2가지 api의 url을 쿼리를 통해 정보를 가져와야 하기 때문에 Endpoint를 관리하고 url을 생성해주는 타입이 필요하다고 생각했습니다.
- 박스오피스 순위 조회를 위한 url, 영화 상세정보 보기를 위한 url을 각각 다른 메서드를 사용해서 url을 만들어 주는 방식을 사용하고 있었습니다.



### ⚒️ 해결방법

``` swift
enum BoxOfficeEndpoint {
    case fetchDailyBoxOffice(targetDate: String)
    case fetchMovieInfo(movieCode: String)
}

extension BoxOfficeEndpoint {
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
- enum 타입으로 정의하여 2가지 조회 방법이 필요하게되는 경우를 각각 case로 지정하고 switch문을 사용하여 case에 따라 경로와 쿼리가 달라지도록 하여 URLRequest을 생성해 주는 방식으로 변경하였습니다.

<br>

### 4️⃣ 컬렉션뷰 셀에 accessory 뷰 추가하기
<img src="https://i.imgur.com/8z4N5m7.png" width="300">

- UICollectionViewCell은 accessories를 달기위해서 따로 이미지뷰를 활용해 직접 레이아웃을 설정해주어야 합니다.


### ⚒️ 해결방법
``` swift
private func createListLayout() -> UICollectionViewCompositionalLayout {
    var config = UICollectionLayoutListConfiguration(appearance: .plain)
        
    return UICollectionViewCompositionalLayout.list(using: config)
}
```

-  기본으로 제공하는 UICollectionLayoutListConfiguration을 사용하기 위해 재사용하는 셀의 타입도 UICollectionViewListCell로 설정해 주었습니다.

``` swift
final class BoxOfficeCollectionViewListCell: UICollectionViewListCell {    
    override func awakeFromNib() {
    super.awakeFromNib()

    self.accessories = [
        .disclosureIndicator()
    ]
}
```
- UICollectionViewListCell에서 accesories 프로퍼티를 활용해 추가해주고 싶은 accessory를 추가해줄 수 있습니다.

<br>

### 5️⃣ Separator Inset
<img src="https://i.imgur.com/0tKZ0Nf.png" width="300">

- 처음엔 ListCell의 Separator Inset을 조절해주기 위해 `updateConstraints` 메서드를 사용해주었습니다.
```swift
// BoxOfficeCollectionViewListCell

override func updateConstraints() {
    super.updateConstraints()
    
    separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
}
```
- 이를 통해 Separator Inset을 조절해줄 수 있었지만, 다음과 같은 에러를 발생시켰습니다.

<img src="https://i.imgur.com/t9fnQ76.png" width="500">

### ⚒️ 해결방법
- `separatorConfiguration.bottomSeparatorInsets` 프로퍼티를 사용하는 것으로 방법을 변경해주었고 이를 사용하기 위해 프로젝트의 버전을 14.5로 올려주게 되었습니다.
```swift
// BoxOfficeViewController

private func createListLayout() -> UICollectionViewCompositionalLayout {
    var config = UICollectionLayoutListConfiguration(appearance: .plain)
    config.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    return UICollectionViewCompositionalLayout.list(using: config)
}
```

<br>

### 6️⃣ 영화 포스터 이미지와 영화 정보 레이블 동시에 표시하기
- 영화 상세정보(영화진흥위원회 API), 영화 포스터 이미지(카카오 이미지 API) 불러오기 2가지 작업이 각각 비동기로 작업이 진행됩니다.
- 둘 중 특정 한가지 작업이 끝났을 때, Activity Indicator의 애니메이션을 종료시키는 것이 적절치 못하다고 생각했습니다.


### ⚒️ 해결방법

``` swift
fetchMovieInfo(completion: checkFetchComplete)
```

``` swift
private func fetchMovieInfo(completion: @escaping () -> ()) {
    guard let movieCode = movieCode else { return }

    let endPoint: BoxOfficeEndPoint = .fetchMovieInfo(movieCode: movieCode)

    networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) {
        [weak self] result in
        guard let self = self else { return }

        switch result {
        case .success(let data):
            self.movieInfo = data
        case .failure(let error):
            print(error.localizedDescription)
            self.showFailAlert(error: error)
        }
        completion()
    }
}
```
- fetchMovieInfo(상세정보 불러오기)와 fetchMovieFoster(영화포스터 이미지 불러오기) 메서드에 completion 핸들러를 추가하여 각각 completion이 실행될 때마다 데이터가 존재하는지 검사하는 로직을 추가했습니다. 

```swift
private var movieInfo: Movie?
private var posterImage: UIImage?

private func checkFetchComplete() {
    guard posterImage != nil && movieInfo != nil,
          let movieInfo = movieInfo else { return }
    
    DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        
        self.activityIndicator.stopAnimating()
        self.posterImageView.image = self.posterImage
        self.configureLabels(data: movieInfo)
        self.contentStackView.isHidden = false
    }
}
```
- fetchMovieInfo, fetchMovieFoster 메서드를 통해 데이터를 모두 받았는지 확인하고
- 2가지 작업이 모두 끝났을 때, Activity Indicator의 애니메이션을 중지시키고 화면에 이미지와 정보를 동시에 표시할 수 있도록 구현하였습니다.

<br>

## 6. 참고 링크
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Docs - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Wiki - HTTP](https://ko.wikipedia.org/wiki/HTTP)
- [Apple Docs - UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [Apple Docs - UICollectionLayoutListConfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
- [WWDC2020 - Modern Cell Configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
