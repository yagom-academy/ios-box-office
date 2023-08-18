# 🎥 박스오피스 🍿

## 📖 목차

1. [📢 소개](#1.)
2. [👤 팀원](#2.)
3. [⏱️ 타임라인](#3.)
4. [📊 UML & 파일트리](#4.)
5. [📱 실행 화면](#5.)
6. [🧨 트러블 슈팅](#6.)
7. [👬 팀 회고](#7.)
8. [🔗 참고 링크](#8.)

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
> - **DTO**
>   - `JSON` 데이터를 디코딩할 `DTO` 객체 구현
>     - 사용할 데이터만으로 이루어진 `Model` 객체 구현
> - **CollectionView**
>   - `CollectionView`를 활용한 UI구현
>   - `CompositionalLayout`를 활용한 `Layout` 설정
>   - `DiffableDataSource`를 활용한 UI 업데이트
>   - `Grid` 모드 구현
> - **MVC**
>   - `MVC`패턴을 활용하여 객체를 역할에 알맞게 분리하여 프로젝트 구현
> - **NSCache**
>   - `NSCache`를 활용하여 받아온 이미지를 재사용
> - **UICalendarView**
>   - `UICalendarView`를 활용하여 달력 구현
> - **UIAlertController**
>   - `actionSheet` 활용

<br>

<a id="2."></a>

## 2. 👤 팀원

| [kyungmin 🐼](https://github.com/YaRkyungmin) | [Erick 🐶](https://github.com/h-suo) |
| :--------: | :--------: | 
| <Img src = "https://cdn.discordapp.com/attachments/1100965172086046891/1108927085713563708/admin.jpeg" width="350"/>| <Img src = "https://user-images.githubusercontent.com/109963294/235300758-fe15d3c5-e312-41dd-a9dd-d61e0ab354cf.png" width="350"/>|

<br>

<a id="3."></a>
## 3. ⏱️ 타임라인

> 프로젝트 기간 :  2023.07.24 ~ 2023.08.18

|날짜|내용|
|:---:|---|
| **2023.07.24** |▫️ `JSON` 데이터를 디코딩할 `Entity` 객체 구현 <br>|
| **2023.07.25** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.07.26** |▫️ 네트워킹 작업을 할 `NetworkManager` 구현 <br>|
| **2023.07.27** |▫️ `TestDouble`을 이용한 테스트 생성 <br> |
| **2023.07.28** |▫️ 코드 개선을 위한 리펙토링 <br> ▫️ README 작성 <br>|
| **2023.07.31** |▫️ `CollectionViewCell` 구현 <br>|
| **2023.08.01** |▫️ `CollectionView`로 UI 구현 <br> ▫️ `BoxOffice`의 데이터를 가져와 관리하는 `BoxOfficeManager`구현 <br> ▫️ 실제 사용할 데이터만으로 이루어진 `Entity` 객체 `DailyBoxOffice` 구현 <br> ▫️ `refreshControl`을 이용한 데이터 리로드 로직 구현 <br>|
| **2023.08.02** |▫️ 데이터 로드에 실패했을 때 `Alert`가 뜨도록 구현 <br>|
| **2023.08.03** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.08.04** |▫️ 코드 개선을 위한 리펙토링 <br> ▫️ README 작성 <br>|
| **2023.08.05** |▫️ `MoiveDetailView` 및 `Controller` 구현 <br> ▫️`BoxOfficeManager`에 `fetchPosterImage`추가 <br>|
| **2023.08.08** |▫️ 이미지 캐싱을 위한 `CacheManager` 구현 <br> ▫️ `CalendarView`및 `Controller` 구현 <br>|
| **2023.08.09** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.08.11** |▫️ 코드 개선을 위한 리펙토링 <br> ▫️ README 작성 <br>|
| **2023.08.15** |▫️ `CollectionView`의 `listMode`와 `gridMode` 구현 <br> ▫️ `actionSheet`으로 사용자가 `listMode`와 `gridMode`를 선택할 수 있도록 구현 <br> ▫️ `listMode` 및 `DetailView`의 다이나믹 타입 구현 <br>|
| **2023.08.17** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.08.18** |▫️ README 작성 <br> |

<br>

<a id="4."></a>
## 4. 📊 UML & 파일트리

### UML

<Img src = "https://hackmd.io/_uploads/BypKlumh3.png" width=""/>

<br>

### 파일트리
```
BoxOffice
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Controller
│   ├── BoxOfficeViewController.swift
│   ├── CalendarViewController.swift
│   └── MovieDetailViewController.swift
├── Model
│   ├── Manager
│   │   ├── BoxOfficeManager.swift
│   │   ├── CacheManager.swift
│   │   └── DataManager.swift
│   ├── DTO
│   │   ├── BoxOffice.swift
│   │   ├── Movie.swift
│   │   └── PosterImageInformation.swift
│   ├── DailyBoxOffice.swift
│   ├── MovieInformation.swift
│   └── TestDouble
│       ├── StubURLSession.swift
│       └── URLSessionProtocol.swift
├── View
│   ├── BoxOfficeCollectionViewGridCell.swift
│   ├── BoxOfficeCollectionViewListCell.swift
│   └── MovieDetailScrollView.swift
├── Extension
│   ├── Date+.swift
│   ├── DateFormatter+.swift
│   ├── NumberFormatter+.swift
│   ├── UIAlertController+.swift
│   ├── UILabel+.swift
│   ├── URL+.swift
│   ├── URLRequest+.swift
│   └── URLSession+.swift
├── Error
│   ├── DataError.swift
│   └── NetworkError.swift
├── NetWork
│   └── NetworkManager.swift
└── Util
    └── Path.swift
```

<br>

<a id="5."></a>
## 5. 📱 실행 화면
| 박스오피스 데이터 로드 | 화면을 당겨 데이터 리로드 |
| :--------------: | :-------: |
| <Img src = "https://hackmd.io/_uploads/BJdHyz9i3.gif" width="300"/> | <Img src = "https://hackmd.io/_uploads/ByZ1xfqi2.gif" width="300"/>  |
| **데이터 로드에 실패했을 때 알림화면** | **영화 상세화면** |
| <Img src = "https://hackmd.io/_uploads/H12xlf5jn.gif" width="300"/> | <Img src = "https://hackmd.io/_uploads/HJd7lDQ2n.gif" width="300"/> |
| **날짜선택** | **화면 모드 변경** |
| <Img src = "https://hackmd.io/_uploads/r1FOxvQ3n.gif" width="300"/>  | <Img src = "https://hackmd.io/_uploads/r1PEKBh3n.gif" width="300"/> |

<br>

<a id="6."></a>
## 6. 🧨 트러블 슈팅

### 1️⃣ 객체 분리

#### 🔥 문제점
`Controller`나 하나의 `Model`에서 많은 로직을 처리하는 것보단 자신의 역할을 가진 객체들을 잘 구현하여 필요할때만 불러 사용한다면 객체간의 의존성도 낮추고 코드를 재사용하는 측면에 좋을 것 같아 객체 분리에 대한 고민을 많이 했습니다.

많은 기능들을 구현하다 보니 `Model`쪽에서 기능 분리를 많이 했음에도 불구하고 `VC`의 코드가 길어져 가독성이 떨어지는 문제가 있었습니다.

#### 🧯 해결방법
**1. Model의 기능 분리**
다음과 같이 자신의 역할을 가진 객체를 만들어 프로젝트를 구현하였습니다.

> - **DTO** : 서버로부터 받은 `Data`를 `Decode`할때 쓰는 타입
> - **Model Data** : 실제 `App`에서 사용할 `Data` 타입
> - **DataManager** : `DTO`를 `Model Data`로 변환해주는 역활
> - **NetworkManager** : 서버로부터 `Data`를 받아오는 역할
> - **BoxOfficeManager** : `Controller`에서 필요한 데이터를 받아 관리하는 타입
> - **Extension**
>   - URLSession : 테스트를 위해 `URLSeesionProtocol`을 채택하기 위한 `extension`
>   - URLRequest : `Header`값을 지정한 `URLRequest`를 반환해주는 `kakaoURLRequest` 메서드 추가
>   - URL : `URL`을 생성하는 `kobisURL`, `kakaoURL` 메서드 추가
>   - UILabel : `attributedText`의 부분 색을 변경해주는 `convertColor`메서드 추가
>   - UIAlertController : 커스텀한 `UIAlertController`을 반환하는 `customAlert` 메서드 추가
>   - Date : `Date`를 반환해주는 `date`메서드 추가
>   - DateFormatter : 오늘로부터 원하는 만큼 떨어진 날짜를 원하는 포멧으로 반환하는 `dateString` 메서드 추가
>   - NumberFormatter : 숫자로 이루어진 `String`을 받아 `Decimal`스타일로 포멧해주는 `decimalString` 메서드 추가


**2. VC 기능 분리**
`extension`과 `MARK`를 이용해 기능 분리를 해서 코드의 가독성을 높였습니다.

>#### 🔺extension 하지 않은 부분
>- stored property
>- initializer
>- viewDidLoad
>#### 🔺extension-setupComponents
>- component관련 세팅
>#### 🔺extension-configureUI
>- 각각의 UI객체의 addSubview
>#### 🔺extension-setupConstraint
>- 각각의 UI객체의 constraint
>#### 🔺extension-buttonAction
>- 버튼 메서드
>#### 🔺그 외 기능
>- 델리게이트, 데이터소스 등..

<br>

### 2️⃣ Test Double

#### 🔥 문제점
네트워크가 연결되어 있지 않은 상황에서도 `NetworkManager`의 `startLoad` 로직이 잘 작동하는지 테스트를 하고 싶었습니다. 하지만 `URLSession`의 `dataTask` 메서드를 사용하고 있었기 때문에 네트워크가 연결되어 있지 않은 상황에서는 테스트가 어려웠습니다.

#### 🧯 해결방법
테스트가 어려운 경우 사용할 수 있는 `Test Double` 객체 `StubURLSession`을 구현하여 테스트를 진행하였습니다. `StubURLSession`는 실제 `dataTask`의 역할을 수행하진 않지만 껍데기 `dataTask`를 가지고 있어 넣어준 `Dummy Data`를 반환하는 객체입니다.

**💉 의존성 주입**
```swift
protocol URLSessionProtocol {
    func dataTask(with urlRequest: URLRequest,  completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}
```

```swift
struct NetworkManager {
    private let urlSession: URLSessionProtocol
    
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
sut = NetworkManager(urlSession: stubURLSession)

// when
sut?.requestData(from: url, completion: { result in
    // then
    // startLoad로 받아온 데이터는 DummyData의 데이터
    XCTAssertEqual(data, dataAsset.data)
    expectation.fulfill()
})
```
- `StubURLSession`는 `DummyData`를 가지고 `dataTask` 메서드를 실행시 `StubURLSessionDataTask`을 이용해서 `DummyData`만 던져주도록 구현했습니다.

<br>

### 3️⃣ Closure Capture

#### 🔥 문제점
`BoxOfficeManager`의 `fetchBoxOffice`에서 `requestData`로 네트워킹을하여 데이터를 받아오는 로직에 클로져 내에서 `BoxOfficeManager`의 프로퍼티인 `dailyBoxOffices`로 접근하여 프로퍼티를 변경하는 로직이 있었습니다. 이때 클로져가 `self`를 캡쳐하면서 RC가 올라가 메모리 해제가 안되는 강한참조순환이 발생할 수 있다는 문제가 있었습니다.

```swift
final class BoxOfficeManager {
    private(set) var dailyBoxOffices: [DailyBoxOffice] = []
    
    // ...
    func fetchBoxOffice(completion: @escaping (Bool) -> Void) {
        
        // ...
        networkManager.requestData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let boxOffice = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self.dailyBoxOffices = DataManager.boxOfficeTransferDailyBoxOfficeData(boxOffice: boxOffice)
                    completion(true)
                } // ...
            }
        }
    }
}
```

#### 🧯 해결방법
클로져의 캡쳐로 `self`의 RC가 올라가는 것을 막아주기 위해 `[weak self]`로 클로져를 캡쳐하여 강한순환참조를 예방하였습니다.

```swift
final class BoxOfficeManager {
    private(set) var dailyBoxOffices: [DailyBoxOffice] = []
    
    // ...
    func fetchBoxOffice(completion: @escaping (Bool) -> Void) {
        
        // ...
        networkManager.requestData(from: url) { [weak self] result in
            guard let self else {
                return
            }
                                               
            switch result {
            case .success(let data):
                do {
                    let boxOffice = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self.dailyBoxOffices = DataManager.boxOfficeTransferDailyBoxOfficeData(boxOffice: boxOffice)
                    completion(true)
                } // ...
            }
        }
    }
}
```

<br>

### 4️⃣ endRefreshing

#### 🔥 문제점
화면을 위로 드레그하여 데이터를 리로드할 때 데이터 로드에 실패하면 `alert`이 뜨는데 이때 `refreshControl?.endRefreshing()`이 안되는 문제가 있었습니다.

<Img src = "https://hackmd.io/_uploads/Hyq_Iz9o3.gif" width="300"/>

#### 🧯 해결방법
`endRefreshing`의 애니메이션 효과와 `present`의 애니메이션 효과를 동시에 처리하지 못하여 발생하는 에러였습니다.
`present`의 `animated`를 `false`로 설정하여 해결하였습니다.

```swift
present(alert, animated: false)
```
<Img src = "https://hackmd.io/_uploads/rkRtvMqi3.gif" width="300"/>

<br>

### 5️⃣ Hashable

#### 🔥 문제점
기존의 `CollectionView`에 `CompositionalLayout`와 `DiffableDataSource`를 적용하는 과정에서 `DailyBoxOffice` 객체가 `Hashable`을 채택해야 했습니다.
그리고 `Hashalbe`을 채택할 때 `struct`의 모든 프로퍼티는 `Hashable`을 준수해야 한다고 나와있었지만 `rankStateColor`는 `typealias` 타입이라 `Hashable`을 준수하지 않았습니다.
> For a struct, all its stored properties must conform to Hashable.

#### 🧯 해결방법
`rankStateColor`는 `rankState property`를 통해서 만들어지는 `property`이기 때문에
`hash value`를 비교할때 필요하지 않는 값이라고 생각해서 `hash`함수에서 빼줬습니다.

```swift
typealias RankStateColor = (targetString: String, color: UIColor)

struct DailyBoxOffice: Hashable {
    let movieCode: String
    let rank: String
    let rankState: String
    let movieTitle: String
    let dailyAndTotalAudience: String
    let rankStateColor: RankStateColor
    
    static func == (lhs: DailyBoxOffice, rhs: DailyBoxOffice) -> Bool {
        return lhs.movieCode == rhs.movieCode
            && lhs.rank == rhs.rank
            && lhs.rankState == rhs.rankState
            && lhs.movieTitle == rhs.movieTitle
            && lhs.dailyAndTotalAudience == rhs.dailyAndTotalAudience
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movieCode)
        hasher.combine(rank)
        hasher.combine(rankState)
        hasher.combine(movieTitle)
        hasher.combine(dailyAndTotalAudience)
    }
}
```

<br>

### 6️⃣ Delegate패턴 순환참조

#### 🔥 문제점
`Delegate` 패턴을 사용할 때 순환참조가 일어나 메모리 해제가 되지 않을 가능성이 있었습니다.

**예시코드**
```swift
protocol ModelDelegate: AnyObject {}

class Model {
    var delegate: ModelDelegate?
        deinit {
        print("deinit Model")
    }
}

class ViewController: ModelDelegate {
    var model: Model?
    
    deinit {
        print("deinit ViewController")
    }
    
    func start() {
 
        model = Model()
        model?.delegate = self
    }
}

var viewController: ViewController? = ViewController()
viewController?.start()
viewController = nil
```
- `model?.delegate = self`로 `delegate` 프로퍼티가 `ViewController`를 참조하고, `ViewController`에서 `Model`을 프로퍼티로 가지고 있어 참조하게 됩니다.
- 따라서 `ViewController = nil`을 하여 `ViewController`를 해제 시키려고 해도 강한순환참조가 일어나 메모리 해제가 되지 않습니다.

#### 🧯 해결방법
순환참조가 일어나는 것을 방지해주기 위해서 `delegate` 프로퍼티를 `weak var`로 선언하도록 하였습니다.

**예시 코드**
```swift
protocol ModelDelegate: AnyObject {}

class Model {
    weak var delegate: ModelDelegate?
        deinit {
        print("deinit Model")
    }
}

class ViewController: ModelDelegate {
    var model: Model?
    
    deinit {
        print("deinit ViewController")
    }
    
    func start() {
 
        model = Model()
        model?.delegate = self
    }
}

var viewController: ViewController? = ViewController()
viewController?.start()
viewController = nil

// deinit ViewController
// deinit Model
```
- `delegate` 프로퍼티를 `weak var`로 약한 참조하여 `viewController = nil`을 하여도 강한 순환 참조가 일어나지 않고 메모리 해제가 됩니다.

**프로젝트 코드**
```swift
final class CalendarViewController: UIViewController {
    weak var delegate: CalendarViewControllerDelegate?
    
    // ...
}
```

<br>

### 7️⃣ 화면 모드 변경 애니메이션

#### 🔥 문제점
처음에는 모드 변경을 할 때 `collectionView.reloadData()`로 모든 셀을 다시 로드하였습니다. 
이럴 경우 애니메이션 없이 화면이 바로 바껴 사용자 경험을 저하시킬 수 있다는 단점이 있었습니다.

<Img src = "https://hackmd.io/_uploads/rkA6tFnnn.gif" width="300"/>

#### 🧯 해결방법
`setCollectionViewLayout`과 `reloadSections`을 사용하여 `layout`이 바뀌는 순간과 `section`이 리로드 되는 순간에 애니메이션 효과를 주었습니다.

**layout이 업데이트 될 때 애니메이션**
```swift
switch collectionViewMode {
case .list:
    collectionView.setCollectionViewLayout(listLayout(), animated: true)
case .grid:
    collectionView.setCollectionViewLayout(gridLayout(), animated: true)
}
```

**reloadSections와 apply를 사용하여 section이 업데이트 될 때 애니메이션**
```swift
var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
snapshot.appendSections([.main])
snapshot.appendItems(boxOfficeManager.dailyBoxOffices, toSection: .main)
snapshot.reloadSections([.main])

dailyBoxOfficeDataSource.apply(snapshot, animatingDifferences: true)
```

<br>

### 8️⃣ dynamic type과 label의 너비

#### 🔥 문제점
`DetailView`에 `dynamic type`을 적용했을때 글씨가 커질 경우 감독, 제작년도, 개봉일 등의 `titleLabel`의 크기가 동일한 비율을 유지하며 커지지 않는 문제가 있었습니다.

<Img src = "https://hackmd.io/_uploads/H1QcsYn33.png" width="300"/>

#### 🧯 해결방법
`titleLabel`의 `widthAnchor`를 `heightAnchor`의 3배로 설정하여 비율을 주고 `setContentCompressionResistancePriority`로 높이가 우선적으로 늘어날 수 있게 하여 글씨가 커질 경우에도 비율에 맞게 `label`의 너비가 늘어날 수 있도록 하였습니다.

```swift
let titleLabelConstraint = titleLabel.widthAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 3)
titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
```

<Img src = "https://hackmd.io/_uploads/Hy5JhYhn2.png" width="300"/>

<br>

<a id="7."></a>
## 7. 👬 팀 회고
### 😃 잘한 점
- 객체분리에 대해 많이 고민했습니다. 다른 객체와의 결합도를 낮추는데 집중했고, 이로인해 가독성과 유지보수성이 높은 코드를 작성했습니다. 
- 이해되지 않는 부분은 시간이 걸리더라도 최대한 이해하려고 노력했습니다.
- 새로운 기술 스택을 사용할 때, 해당 기술의 공식 문서를 꼼꼼히 읽고 사용했습니다.
- 프로젝트 진행 중 문제가 발생하거나 버그를 해결할 때 공식문서를 잘 활용했습니다.

### 😢 아쉬웠던 점
- `Protocol`을 많이 활용하지 못한 부분이 아쉬웠습니다.
- `POP`에 대한 고민을 하지 못한 점이 아쉬웠습니다.

<br>

<a id="8."></a>
## 8. 🔗 참고 링크
- [🍎Apple: CodingKey](https://developer.apple.com/documentation/swift/codingkey)
- [🍎Apple: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎Apple: Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎Apple: Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Capturing-Values)
- [🍎Apple: UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [🍎Apple: UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [🍎Apple: NSDiffableDataSourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot)
- [🍎Apple: Hashable](https://developer.apple.com/documentation/swift/hashable)
- [🍎Apple: UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview#3992448)
- [🍎Apple: estimated(_:)](https://developer.apple.com/documentation/uikit/nscollectionlayoutdimension/3199057-estimated)
- [🍎Apple: setCollectionViewLayout(_:animated:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618086-setcollectionviewlayout)
- [🍎Apple: reloadSections(_:)](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot/3375784-reloadsections)
- [🐻야곰닷넷: Unit Test](https://yagom.net/courses/unit-test-작성하기/)
- [📗Velog: You don’t (always) need [weak self]](https://velog.io/@haanwave/Article-You-dont-always-need-weak-self)
