# 🎥 박스오피스 🍿

## 📖 목차

1. [📢 소개](#1.)
2. [👤 팀원](#2.)
3. [⏱️ 타임라인](#3.)
4. [📊 UML & 파일트리](#4.)
5. [📱 실행 화면](#5.)
6. [🧨 트러블 슈팅](#6.)
7. [🔗 참고 링크](#7.)

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
>     - 사용할 데이터만으로 이루어진 `Entity` 객체 구현
> - **CollectionView**
>   - `CollectionView`를 활용한 UI구현
>   - `CompositionalLayout`를 활용한 `Layout` 설정
>   - `DiffableDataSource`를 활용한 UI 업데이트
> - **MVC**
>   - `MVC`패턴을 활용하여 객체를 역할에 알맞게 분리하여 프로젝트 구현
> - **NSCache**
>   - `NSCache`를 활용하여 받아온 이미지를 재사용
> - **UICalendarView**
>   - `UICalendarView`를 활용하여 달력 구현

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
| **2023.07.31** |▫️ `CollectionViewCell` 구현 <br>|
| **2023.08.01** |▫️ `CollectionView`로 UI 구현 <br> ▫️ `BoxOffice`의 데이터를 가져와 관리하는 `BoxOfficeManager`구현 <br> ▫️ 실제 사용할 데이터만으로 이루어진 `Entity` 객체 `DailyBoxOffice` 구현 <br> ▫️ `refreshControl`을 이용한 데이터 리로드 로직 구현 <br>|
| **2023.08.02** |▫️ 데이터 로드에 실패했을 때 `Alert`가 뜨도록 구현 <br>|
| **2023.08.03** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.08.04** |▫️ 코드 개선을 위한 리펙토링 <br> ▫️ README 작성 <br>|
| **2023.08.05** |▫️ `MoiveDetailView` 및 `Controller` 구현 <br> ▫️`BoxOfficeManager`에 `fetchPosterImage`추가 <br>|
| **2023.08.08** |▫️ 이미지 캐싱을 위한 `CacheManager` 구현 <br> ▫️ `CalendarView`및 `Controller` 구현 <br>|
| **2023.08.09** |▫️ 코드 개선을 위한 리펙토링 <br> |
| **2023.08.11** |▫️ 코드 개선을 위한 리펙토링 <br> ▫️ README 작성 <br>|

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
├── Model
│   ├── DTO
│   │   ├── BoxOffice.swift
│   │   ├── Movie.swift
│   │   └── PosterImageInformation.swift
│   ├── DailyBoxOffice.swift
│   ├── Manager
│   │   ├── BoxOfficeManager.swift
│   │   ├── CacheManager.swift
│   │   └── DataManager.swift
│   ├── MovieInformation.swift
│   └── TestDouble
│       ├── StubURLSession.swift
│       └── URLSessionProtocol.swift
├── Controller
│   ├── BoxOfficeViewController.swift
│   └── CalendarViewController.swift
├── View
│   ├── BoxOfficeCollectionViewCell.swift
│   ├── MovieDetailScrollView.swift
│   └── MovieDetailViewController.swift
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
| 박스오피스 데이터 로드 | 화면을 당겨 데이터 리로드 | 데이터 로드에 실패했을 때 알림화면 |
| :--------------: | :-------: |  :-------: | 
| <Img src = "https://hackmd.io/_uploads/BJdHyz9i3.gif" width="225"/> | <Img src = "https://hackmd.io/_uploads/ByZ1xfqi2.gif" width="225"/>  | <Img src = "https://hackmd.io/_uploads/H12xlf5jn.gif" width="225"/> |
| **영화 상세화면** | **날짜선택** |
| <Img src = "https://hackmd.io/_uploads/HJd7lDQ2n.gif" width="225"/> | <Img src = "https://hackmd.io/_uploads/r1FOxvQ3n.gif" width="225"/>  |

<br>

<a id="6."></a>
## 6. 🧨 트러블 슈팅

### [📎 Step3 트러블 슈팅 보러가기](https://github.com/h-suo/ios-box-office/blob/step3/README.md#6--트러블-슈팅)

<br>

### 1️⃣ VC의 기능 분리

#### 🔥 문제점
많은 기능들을 구현하다 보니 `Model`쪽으로 기능 분리를 많이 했음에도 불구하고 `VC`의 코드가 길어져 가독성이 떨어지는 문제가 있었습니다.

#### 🧯 해결방법
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

### 2️⃣ Hashable

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

### 3️⃣ URLRequest

#### 🔥 문제점
영화 포스터 이미지를 가져올 때 [다음 이미지 검색 API](https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide#search-image) 이용해야 했습니다.
기존 `API`는 `URLRequest`를 설정할 필요 없이 `URL`의 `QureyItem`만을 설정하여 데이터를 요청할 수 있었지만 `다음 이미지 검색 API`는 `Request Header`에 `Key`를 담아서 보내야 했습니다.

#### 🧯 해결방법
`NetworkManager`에 `URLRequest`를 받을 수 있도록 `requestData(from urlRequest:, completion:)` 메서드를 추가하였습니다.

```swift
func requestData(from urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
    let task = urlSession.dataTask(with: urlRequest) { data, response, error in
        // ...
    }
    // ...
}
```

### 4️⃣ NSCache

#### 🔥 문제점
데이터가 큰 이미지를 계속해서 네트워킹을 통해 받아오는 것은 효율적이지 못하다고 생각하였습니다.

```swift
func fetchPosterImage(_ movieName: String, completion: @escaping (Bool) -> Void) {
        
        // ...
        networkManager.requestData(from: urlRequest) { [weak self] result in
            
            // ...
            }
        }
    }
```
- `fetchPosterImage`를 호출하면 무조건 `requestData`로 네트워킹을 하여 이미지를 가져옵니다.

#### 🧯 해결방법
데이터가 큰 이미지는 한번 받아온 후 재사용할 수 있도록 `CacheManager`를 만들어 관리해주었습니다.

```swift
final class CacheManager {
    static let shared = CacheManager()
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func setCacheImage(_ image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: forKey as NSString)
    }
    
    func cacheImage(forKey: String) -> UIImage? {
        return imageCache.object(forKey: forKey as NSString)
    }
}
```
- `NSString`을 키값으로 `UIImage`를 저장하는 `NSCache`를 싱글톤 패턴을 이용하여 구현했습니다.

```swift
func fetchPosterImage(_ movieName: String, completion: @escaping (Bool) -> Void) {
    if let cacheImage = CacheManager.shared.cacheImage(forKey: movieName) {
        posterImage = cacheImage
        completion(true)
        return
    }
    
    // ...
    networkManager.requestData(from: urlRequest) { [weak self] result in
        // ...
        switch result {
        case .success(let data):
            do {
                // ...
                CacheManager.shared.setCacheImage(image, forKey: movieName)
                self.posterImage = image
                completion(true)
            } catch {
                // ...
            }
        case .failure(let error):
            // ...
        }
    }
}
```
- 실제 캐싱을 하는 위치는 `BoxOfficeManager`의 `fetchPosterImage`에서 이미지를 받아오기 전에 `movieName`을 `cacheKey`로 캐싱된 이미지가 있다면 `requestData`를 호출하지 않고 캐싱된 이미지를 사용합니다.
- 캐싱된 이미지가 없다면 `requestData`로 이미지를 받아와 캐싱하도록 구현했습니다.

### 5️⃣ 날짜선택

#### 🔥 문제점
`UICalendarView`를 사용하여 달력을 구현하였습니다.
이 때 처음 달력이 보였을 때 선택된 날짜 달력에 표시하고, 사용자가 선택한 날짜를 `BoxOfficeViewController`로 보내기 위해 고민했습니다.

#### 🧯 해결방법
`BoxOfficeViewContorller`에서는 선택된 날짜를 `init`의 파라미터로 주입하여 전달하고, `CalendarViewController`에서는 `Delegate` 패턴을 사용하여 사용자가 선택한 날짜를 `BoxOfficeViewController`에서 사용할 수 있도록 했습니다.

```swift
private func setupCalendarView() {
    
    // ...
    let dateSelection = UICalendarSelectionSingleDate(delegate: self)
    dateSelection.selectedDate = selectedDate
    calendarView.selectionBehavior = dateSelection
}
```
- `BoxOfficeViewController`에서 `init`을 통해 받아온 `selectedDate`를 선택된 날짜로 선택하도록 했습니다.
- `UICalendarSelectionSingleDate`로 단일 선택만 가능하도록 설정했습니다.

```swift
protocol CalendarViewControllerDelegate: AnyObject {
    func calendarViewController(_ calendarViewController: UIViewController, didSelectDate dateComponents: DateComponents?)
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        delegate?.calendarViewController(self, didSelectDate: dateComponents)
        dismiss(animated: true)
    }
}
```
- `UICalendarSelectionSingleDateDelegate`를 채택하여 날짜가 선택되었을 때 `Delegate` 패턴을 이용하여 선택된 `DateComponents`를 넘겨주었습니다.

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

<a id="7."></a>
## 7. 🔗 참고 링크
- [🍎Apple: UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [🍎Apple: NSDiffableDataSourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot)
- [🍎Apple: Hashable](https://developer.apple.com/documentation/swift/hashable)
- [🍎Apple: UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview#3992448)
- [📗Velog: You don’t (always) need [weak self]](https://velog.io/@haanwave/Article-You-dont-always-need-weak-self)
