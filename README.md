# 박스오피스🎬
## 소개
> 영화진흥위원회와 Daum 검색 API를 통해 날짜별 박스오피스, 영화 상세정보를 불러오는 앱입니다.

**프로젝트 기간 : 23/07/24~23/08/18**
</br>

## 목차
1. [팀원 소개](#1.)
2. [타임 라인](#2.)
3. [시각화 구조](#3.)
4. [실행 화면](#4. )
5. [핵심 경험](#5.)
6. [트러블 슈팅](#6.)
7. [참고 자료](#7.)
8. [팀 회고](#8.)

</br>

<a id="1."></a></br>
## 팀원 소개
|<Img src =  "https://hackmd.io/_uploads/rJj1EtKt2.png" width="200" height="200">|<Img src="https://hackmd.io/_uploads/rk62zRiun.png" width="200">|
|:-:|:-:|
|[**Yetti**](https://github.com/iOS-Yetti)|[**maxhyunm**](https://github.com/maxhyunm)|

<a id="2."></a></br>
## 타임 라인
|날짜|내용|
|:--:|--|
|2023.07.24.| json 파일 파싱을 위한 BoxOfficeEntity 타입 생성, 디코딩 유닛테스트 진행 |
|2023.07.25.| DecodingManager에서 디코딩만 진행할 수 있도록 기능 분리 |
|2023.07.26.| NetworkingManager, BoxOfficeError, MoviewDetailEntity 타입 생성 |
|2023.07.27.| extension으로 중첩타입 분리, URLNamespace 타입 생성 |
|2023.07.31.| 프로젝트 진행을 위한 개인 공부시간 |
|2023.08.01.| 프로젝트 진행을 위한 개인 공부시간 |
|2023.08.02.| CollectionView세팅, BoxOfficeRankingCell 생성 및 셀 구성 세팅,  DiffableDataSource 세팅 및 연결, 랭킹 증감분 AttributedString 처리, collectionView에 refreshControl 추가 |
|2023.08.07.| 리뷰에 따른 리팩토링 진행  |
|2023.08.08.|DaumImageEntity 파일 추가 및 DAUM_API_KEY 추가, MovieDetailViewController 파일 추가 및 view 전환 메서드 추가, MoviewDetailViewController에 MoviewDetail 네트워크 연결 |
|2023.08.09.|프로젝트 진행을 위한 개인 공부시간|
|2023.08.10.|스택뷰의 text설정메서드 기능 분리 및 Namespace 생성, MovieDetailView 로딩화면 수정 |
|2023.08.11.|README 작성|
|2023.08.14.|url 호출 실패시 completion으로 에러처리 추가, MovieDetailViewController에서 isDataLoading, isImageLoading 호출 위치 변경|
|2023.08.15.|프로젝트 진행을 위한 개인 공부시간|
|2023.08.16.|화면 모드 변경 버튼 추가 BoxOfficeRankingIconCell 타입 생성, 화면 모드 변경시 CollectionView의 레이아웃 설정을 바꾸는 기능 구현, 텍스트에 다이나믹 타입 적용 및 auto layout 수정|
|2023.08.17.|APIKey 검증과정 및 에러처리 추가, 날짜 변경시 컬렉션뷰 레이아웃 틀어지는 오류 수정|
|2023.08.18.|README 작성|

<a id="3."></a></br>
## 시각화 구조
### File Tree
    ├── BoxOffice
    │   ├── Extension
    │   │   ├── DateFormatter+.swift
    │   │   └── String+.swift
    │   ├── Model
    │   │   ├── BoxOfficeEntity.swift
    │   │   ├── MovieDetailEntity.swift
    │   │   ├── DaumImageEntity.swift
    │   │   ├── DecodingManager.swift
    │   │   ├── Error.swift
    │   │   ├── NetworkingManager.swift
    │   │   └── URLSessionProtocol.swift
    │   ├──View
    │   │   ├── BoxOfficeRankingListCell.swift
    │   │   ├── BoxOfficeRankingIconCell.swift
    │   │   └── MovieDetailStackView.swift
    │   ├── Controller
    │   │   ├── BoxOfficeViewController.swift
    │   │   ├── CalendarViewController.swift
    │   │   └── MovieDetailViewController.swift
    │   ├── Resource
    │   │   ├── AppDelegate.swift
    │   │   ├── SceneDelegate.swift
    │   │   ├── NetworkConfiguration.swift
    │   │   ├── Assets.xcassets
    │   │   └── box_office_sample.json
    │   └──Info.plist
    ├── BoxOffice.xcodeproj
    ├── BoxOfficeTests
    │   ├── BoxOffice.xctestplan
    │   ├── BoxOfficeDecodingTests.swift
    │   ├── BoxOfficeNetworkingTest.swift
    │   └── TestDouble.swift
    └── README.md

### UML
#### 박스오피스 화면
<img src="https://hackmd.io/_uploads/S1FsUShn3.png"><br>

#### 영화 상세정보 화면
<img src="https://hackmd.io/_uploads/SkGRUHhhh.png">
<br>

<a id="4."></a></br>
## 실행 화면

| 영화 상세정보 | 날짜 변경 | 화면 모드 변경 |
|:--------:|:--------:|:--------:|
|<img src="https://file.notion.so/f/s/381a37e3-8fac-46d9-988f-bc65a6b2c618/boxoffice.gif?id=07a404ad-ba68-4422-9c17-aae2e1ab04dd&table=block&spaceId=26c8d86e-7094-42a2-9751-594e7aa0a176&expirationTimestamp=1692410400000&signature=aITy02Giq1_hYjSPyupBQbBn8cwPbdCFrOtaF-0ISXI" width="250">|<img src="https://file.notion.so/f/s/6444c61f-e00c-4d42-8314-85a7259cb144/boxoffice_datechange.gif?id=a4fc2b9d-9dcf-48d6-b247-dd1df05572ff&table=block&spaceId=26c8d86e-7094-42a2-9751-594e7aa0a176&expirationTimestamp=1692410400000&signature=sMktJU4AZmvRlbZ7Ln9aHYcotN7N3ydImJ2K_LU4ypI" width="250">|<img src="https://file.notion.so/f/s/df1a49e1-c359-43d4-a782-2e759bad427d/boxoffice_modechange.gif?id=0f186811-05ed-4a04-85db-0a430761d7ae&table=block&spaceId=26c8d86e-7094-42a2-9751-594e7aa0a176&expirationTimestamp=1692410400000&signature=AhIyobnGXMb-LCQHIB0gSXFthoOh3o5QBtmhlQz2Ln0" width="250">|




<a id="5."></a></br>
## 핵심 경험
#### 🌟 xcconfig, info.plist를 활용한 api key 설정
환경 파일을 활용해 원격 저장소에 공유되지 않아야 하는 key 정보를 관리하였습니다.

#### 🌟 CodingKeys와 Nested Type Enum을 활용한 중첩 json 파싱
`Nested Type`을 활용하여 여러 단계로 중첩된 형태의 json을 파싱할 수 있도록 하였고, `CodingKeys`를 활용해 이해하기 어려운 파라미터명을 변경하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">

```swift
extension BoxOfficeEntity {
    struct BoxOfficeResult: Decodable {
        let boxOfficeType, showRange: String
        let dailyBoxOfficeList: [DailyBoxOffice]

        enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case showRange, dailyBoxOfficeList
        }
    }
}
```
</div>
</details>

#### 🌟 Generic을 활용한 범용 메서드 구현
다양한 타입의 Entity를 반환해야 하는 `DecodingManager`의 메서드를 `Generic`으로 구현하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">

```swift
func decode<T: Decodable>(_ data: Data?) throws -> T {
    guard let data = data,
          let decodedData = try? decoder.decode(T.self, from: data) else {
        throw DecodingError.decodingFailure
    }
    return decodedData
}
```
    
</div>
</details>

#### 🌟 Modern Collection View 구현
`Modern Collection View`를 통해 박스오피스 랭킹 리스트를 구현하기 위하여 `Diffable Data Source`와 `Collection View List Cell`를 활용하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
private let collectionView: UICollectionView = {
    let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
...
}
    
private var dataSource: UICollectionViewDiffableDataSource<NetworkNamespace, BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice>?
...
    
```
    
</div>
</details>
    
#### 🌟 UICalendarView 활용
`UICalendarView`를 활용해 `Calendar`를 구현하고 과거 날짜의 데이터를 불러올 수 있도록 활용하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
private let calendarView: UICalendarView = {
        var calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .systemBackground
        
        let endDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        let calendarViewDateRange = DateInterval(start: Date(timeIntervalSince1970: 0), end: endDate)
        calendarView.availableDateRange = calendarViewDateRange
        
        return calendarView
    }()
```
    
</div>
</details>
    
#### 🌟 UIActivityIndicatorView를 활용한 로딩 구현
데이터 fetch 상태에 따라 `UIActivityIndicatorView`의 상태값을 변경하여 로딩 마크가 활성화/비활성화 되도록 구현하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
private let indicatorView: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorView.style = .large
    indicatorView.translatesAutoresizingMaskIntoConstraints = false

    return indicatorView
}()

private var isLoading: Bool = true {
    willSet(newValue) {
        if newValue == true {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        } else {
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }
    }
}
```
    
</div>
</details>

#### 🌟 UIRefreshControl를 활용한 새로고침 구현
`Collection View`에 `UIRefreshColtrol` 객체를 추가하여, 아래로 당겼을 때 새로고침을 진행할 수 있도록 하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
collectionView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
```
    
</div>
</details>
    
#### 🌟 UIToolBar 활용
`UIToolBar`와 `flexibleSpace`를 활용하여 화면 하단 버튼을 구현하였습니다.
    
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
let modeChangeButton = UIBarButtonItem(title: "화면 모드 변경", style: .plain, target: self, action: #selector(hitChangeModeButton))
let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
...
self.toolbarItems = [flexibleSpace, modeChangeButton, flexibleSpace]
```
    
</div>
</details>

#### 🌟 UIAlertController 활용
화면 모드 변경시 `UIAlertController`의 `actionSheet`스타일로 아이콘 모드와 리스트 모드 화면을 선택적으로 적용할 수 있도록 구현하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
@objc func hitChangeModeButton() {
    let mode: String = isListMode == true ? "아이콘" : "리스트"
    let alert = UIAlertController(title: "화면 모드 변경", message: nil, preferredStyle: .actionSheet)
    let modeChangeAction = UIAlertAction(title: mode, style: .default) { _ in
        self.isListMode.toggle()
    }
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
    alert.addAction(modeChangeAction)
    alert.addAction(cancelAction)
    present(alert, animated: true)
}
```
    
</div>
</details>
    

#### 🌟 Attributed String 활용
하나의 레이블 안에서 여러 가지 색상을 표시하기 위하여 `Attributed String`을 활용하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (fixedIntensity as NSString).range(of: "▲"))
```
    
</div>
</details>

#### 🌟 DynamicType 적용
`preferredFont`를 활용하여 폰트에 `DynamicType`을 적용하였고, `adjustsFontSizeToFitWidth` 설정을 통해 가로 너비에 맞춰 텍스트 크기를 자동 조절할 수 있도록 구현하였습니다.
<details>
<summary>상세코드</summary>
<div markdown="1">
    
```swift
private let audienceLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true

    return label
}()
```
    
</div>
</details>

<a id="6."></a></br>
## 트러블 슈팅
### 1️⃣ 네트워크 연결시 URL 전달 방식
**🚨 문제점**</br>
기존에는 `dataTask` 메서드에 `URL` 타입을 전달하여 네트워크 연결을 진행하도록 구현했었습니다. 하지만 이번에 `Daum API`가 추가되면서 `Authorization` 헤더를 추가해야 했기 때문에 해당 정보를 어떻게 전달할지 고민하였습니다.

**💡 해결 방법**</br>
`URLRequest`를 활용하면 `setValue`를 통해 헤더 정보를 추가할 수 있음을 확인하였습니다. 이에 따라 기존 테스트더블 및 테스트코드 모두 `URLRequest`에 맞게 수정을 진행하였습니다.

```swift
var request = URLRequest(url: url)
request.setValue("KakaoAK \(NetworkNamespace.daumApiKey)", forHTTPHeaderField: "Authorization")
```

또한 `Daum API`에 전달할 쿼리 내용에는 띄어쓰기가 추가되어 있어, `URL`에 붙여서 보내기보다는 `URLComponents`를 사용해 필요한 쿼리 아이템을 추가하는 게 좋겠다는 생각이 들었습니다.
해당 내용은 아래와 같이 구현하였습니다.
```swift
var urlComponents = URLComponents(string: NetworkNamespace.daumImage.url)
urlComponents?.queryItems = [URLQueryItem(name: "query", value: "\(movieName) 영화 포스터")]
```

### 2️⃣ dataTask 메서드로 받아온 데이터 처리
**🚨 문제점**</br>
`NetworkingManager`의 `load()` 메서드를 호출한 위치에서 `dataTask`를 통해 받아 온 데이터를 활용할 수 있는 방법에 대해 고민이 있었습니다.
처음에는 두 타입을 델리게이트로 연결하여 전달하는 등의 방법을 생각했습니다. 하지만 데이터 처리를 위해 네트워킹을 사용하는 모든 타입을 델리게이트로 연결하는 것은 권장되는 방식도 아니고, 효율적이지 못한 것 같았습니다.

**💡 해결 방법**</br>
`@escaping` 클로저와 `Result`타입을 활용하여 해결하였습니다. `Result`는 성공/실패 두 가지 가능성에 대한 데이터타입을 따로 지정해줄 수 있어 `CompletionHandler`에 활용하기에 적절하다고 판단했습니다.
```swift
func load(_ urlString: String, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }

    let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
            completion(.failure(BoxOfficeError.connectionFailure))
            return
        }
        ...
```

### 3️⃣ ATS를 통한 네트워크 설정
**🚨 문제점**</br>
API를 받아와야 하는 도메인이 `https`가 아닌 `http`를 활용하고 있어 네트워크 연결시에 오류가 발생하였습니다.</br>
<img src="https://hackmd.io/_uploads/BkwWly-jn.png"></br>

**💡 해결 방법**</br>
해당 도메인 및 하위 도메인 정보를 ATS에 `Exception Domains`로 추가하여 정상적으로 네트워킹이 가능하도록 구현하였습니다.</br>
<img src="https://hackmd.io/_uploads/Hkj4Tsgjh.png"></br>

### 4️⃣ 로딩과 새로고침 종료 위치 설정
**🚨 문제점**</br>
네트워킹을 통해 받아 온 데이터를 처리하는 과정에서 성공한 경우에만 로딩을 끝내고 빠져나갈 수 있도록 처리하였더니, 에러가 났을 때는 아래와 같이 계속 로딩이 돌아가고 있는 것처럼 보이는 것을 확인했습니다.</br>
<img src="https://hackmd.io/_uploads/HkMVV0Yon.png" width="200"></br>
또한 RefreshControl의 종료 처리를 아래와 같이 진행하니, 데이터 로딩이 완료되기 전에 비동기로 다음 호출이 진행되어 새로고침이 바로 끝나버리는 오류가 발생했습니다.
```swift
@objc private func refresh() {
    passFetchedData()
    refreshControl.endRefreshing()
}
```

**💡 해결 방법**</br>
네트워킹과 디코딩 여부에 상관없이 로딩과 새로고침을 완료할 수 있도록 해당 호출부를 switch문 밖으로 이동하였으며,
isLoading 변수가 false일 때 endRefreshing도 호출할 수 있도록 변경해주었습니다.
```swift
networkingManager?.load(url) { [weak self] (result: Result<Data, NetworkingError>) in
    switch result {
    case .success(let data):
        ...
    case .failure(let error):
        ...
}

DispatchQueue.main.async {
    self?.isLoading = false
    self?.refreshControl.endRefreshing()
}
```

### 5️⃣ 셀 재활용으로 인한 문제 해결
**🚨 문제점**</br>
Collection View에서 셀을 재사용하면서, 검은 색으로 들어가야 하는 순위 텍스트가 빨간색으로 잘못 들어가는 문제가 있었습니다.
<img src="https://hackmd.io/_uploads/HkS1_Shhh.png" width="300"></br>
**💡 해결 방법**</br>
`PrepareForReuse()`를 통해 아래와 같이 폰트 색상을 초기화해 주었습니다.
```swift
override func prepareForReuse() {
    rankIntensityLabel.textColor = .black
}
```
### 6️⃣ Test Double 생성
**🚨 문제점**</br>
인터넷 연결이 없는 상태에서 네트워크 통신을 테스트하기 위해 `Test Double`을 생성하였습니다. 이 과정에서 테스트용 `Stub Session`과 실제 `Session` 사이에 호환이 가능하도록 하기 위해 `URLSessionProtocol`을 구현하였는데, `URLSession`에서 이를 상속하려 하니 아래와 같은 경고가 발생하였습니다.</br>
<img src="https://hackmd.io/_uploads/BJeZG3lin.png" width="1000"></br>

**💡 해결 방법**</br>
`CompletionHandler typealias`에 `@Sendable`을 채택하여 해결하였습니다.
```swift
typealias CompletionHandler = @Sendable (Data?, URLResponse?, Error?) -> Void
```


### 7️⃣ 다양한 네트워크에 대한 Test 환경 구성 
**🚨 문제점**</br>
세 가지 다른 API를 호출하는 프로그램이다 보니, 각 API 내용에 따라 매번 새로운 테스트 환경을 만들어주어야 해서 번거로웠습니다.

**💡 해결 방법**</br>
아래와 같이 테스트 타입을 파라미터로 전달받아 각 타입에 맞는 테스트환경을 구성할 수 있도록 구현하였습니다. 
```swift
func setUpSUT(isSuccess: Bool, apiType: NetworkNamespace) {
    ...
        switch apiType {
    case .boxOffice:
        urlString = String(format: NetworkNamespace.boxOffice.url, NetworkNamespace.apiKey, "20230801")
        asset = "box_office_sample"
    case .movieDetail:
        urlString = String(format: NetworkNamespace.movieDetail.url, NetworkNamespace.apiKey, "20230801")
        asset = "movie_detail_sample"
    case .daumImage:
        urlString = String(format: NetworkNamespace.daumImage.url)
        asset = "daum_image_sample"
    }
    ...

    if isSuccess {
        ...
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        ...
    } else {
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        ...
    }
}
```

<a id="7."></a></br>
## 참고 자료
- [URLSession 공식문서 🍎](https://developer.apple.com/documentation/foundation/urlsession)
- [Fetching Website Data into Memory 공식문서 🍎](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [UICollectionView 공식문서 🍎](https://developer.apple.com/documentation/uikit/uicollectionview)
- [UICollectionViewListCell 공식문서 🍎](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [UICollectionViewDiffableDataSource 공식문서 🍎](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [URLRequest 공식문서 🍎](https://developer.apple.com/documentation/foundation/urlrequest)
- [URLComponents 공식문서 🍎](https://developer.apple.com/documentation/foundation/urlcomponents)
- [AttributedString 공식문서 🍎](https://developer.apple.com/documentation/foundation/attributedstring)
- [UIRefreshControl 공식문서 🍎](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
- [UIActivityIndicatorView 공식문서 🍎](https://developer.apple.com/documentation/uikit/uiactivityindicatorview)
- [UICalendarView 공식문서 🍎](https://developer.apple.com/documentation/uikit/uicalendarview)
- [UIAlertController 공식문서 🍎](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [야곰 닷넷 - Unit Test](https://yagom.net/courses/unit-test-%ec%9e%91%ec%84%b1%ed%95%98%ea%b8%b0/)
</br>

<a id="8."></a></br>
## 팀 회고
[일일 스크럼](https://github.com/iOS-Yetti/ios-box-office/wiki)

</br>
