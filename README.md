# 박스오피스 II
> 영화진흥위원회, Daum 검색 OPEN API를 이용하여 박스오피스 목록을 조회하고 영화 상세 정보를 확인할 수 있는 앱입니다. 
> * CalendarView에서 목록 조회 날짜를 선택할 수 있습니다.
> * 사용자 선택에 따라 박스오피스 순위 CollectionView를 목록/아이콘의 형태로 볼 수 있습니다.
> * 주요 개념: `URLSession`, `NSCache`, `UICollectionView`, `Modern CollectionView Implementation` ,`UICalendarView`, `AutoLayout`
> 
> 프로젝트 기간: 2023.04.03 ~ 2023.04.14


## ⭐️ 팀원
| Rowan | 무리 |
| :--------: |  :--------: |
| <Img src = "https://i.imgur.com/S1hlffJ.jpg" width="200" height="200"/>      |<Img src ="https://i.imgur.com/SqON3ag.jpg" width="200" height="200"/>
| [Github Profile](https://github.com/Kyeongjun2) |[Github Profile](https://github.com/parkmuri) 

</br>

## 📝 목차
1. [타임라인](#-타임라인)
2. [프로젝트 구조](#-프로젝트-구조)
3. [실행화면](#-실행화면)
4. [트러블 슈팅](#-트러블-슈팅)
5. [핵심경험](#-핵심경험)
6. [팀 회고](#-팀-회고)
7. [참고 링크](#-참고-링크)

</br>

# 📆 타임라인 
- 2023.04.03 : CalendarViewController 및 Navigation에 BarButtonItem 생성
- 2023.04.04 : CalendarView Layout추가 및 선택 날짜 전달을 위한 Delegate패턴 구현, Modern Collection View 적용을 위한 ListCell, DiffableDataSource 구현
- 2023.04.05 : 중복된 박스오피스 검색 날짜 변경 후 캘린더에 SelectedDate 반영, 중복되는 코드 줄이기 위한 TextMaker 구현, ListCell default configuration에 autoShrink 적용
- 2023.04.06 : CollectionViewMode타입 생성 및 iconMode에 사용할 DailyBoxOfficeIconCell, CompositionalLayout 정의
- 2023.04.07 : CollectionViewMode에 따른 레이아웃 전환 구현
- 2023.04.10 : CalendarViewController 프로퍼티 주입받게 수정 및 접근제어 설정, DailyBoxOfficeIconCell stackView, Label 프로퍼티 설정
- 2023.04.11 : NSCacheManager 타입 생성 및 APIProvider loadImage메서드 추가, MovieDetailsViewController의 loadPosterImage 분리
- 2023.04.12 : NetWorkError case 추가, NSCache countLimit 설정
- 2023.04.13 : MovieDataUpdatable protocol 정의, DailyBoxOfficeViewController 메서드 기능 분리, 코드 컨벤션 정리
- 2023.04.14 : collectionView mode에 따른 layout변경시 animation 개선

</br>


# 🌳 프로젝트 구조
## UML
<img src="https://i.imgur.com/AipaIBT.png" width="100%">

## File Tree

```
├── BoxOffice
│   ├── App
│   │   ├── AppDelegate
│   │   └── SceneDelegate
│   ├── Model
│   │   ├── DailyBoxOfficeCellTextMaker
│   │   └── ResponseModel
│   │       ├── DailyBoxOffice
│   │       ├── MovieDetails
│   │       └── DaumSearchResult
│   ├── View
│   │   ├── CategoryStackView
│   │   ├── DailyBoxOfficeIconCell
│   │   ├── DailyBoxOfficeListCell
│   │   └── Protocol
│   │       └── MovieDataUpdatable
│   └── Controller
│   │   ├── CalendarViewController
│   │   ├── DailyBoxOfficeViewController
│   │   ├── MovieDetailsViewController
│   │   └── Protocol
│   │       └── CalendarViewControllerDelegate
│   ├── Network
│   │   ├── APIProvider
│   │   ├── CacheManager
│   │   ├── DaumImageAPI
│   │   ├── Endpoint
│   │   ├── KobisAPI
│   │   ├── Error
│   │   │   └── NetworkError
│   │   └── Protocol
│   │       ├── API
│   │       ├── DataTaskMakeable
│   │       └── URLRequestGenerator
│   ├── Resource
│   │   ├── Assets
│   │   └── LaunchScreen
│   ├── Storyboard
│   │   └── Main
│   └── Utility
│       ├── AlertController
│       ├── CollectionViewModeManager
│       ├── LoadingIndicator
│       └── Extension
│           ├── extension+CALayer
│           ├── extension+Collection
│           ├── extension+DateFormatter
│           └── extension+String
└── BoxOfficeTests
    ├── APIProviderTests
    │   ├── APIProviderTests
    │   └── TestDoubles
    └── JSONModelTests
        └── JSONModelTests
```

</details>

# 📱 실행화면

|모드 변경|날짜 변경|캐시 저장|
|:---:|:---:|:---:|
|<img src="https://i.imgur.com/zLCkFe4.gif" width="300">|<img src="https://i.imgur.com/5Odr31m.gif" width="300">|<img src="https://i.imgur.com/jmeWql8.gif" width="300">|

<br/>

# 🚀 트러블 슈팅
## 1️⃣ 날짜 변경 후 달력에서 선택된 날짜 변경하기

### 🔍 문제점
날짜를 변경 한 후 다시 날짜선택을 눌러 modal창을 띄우게 되면 어제의 날짜로 선택이 되는 문제가 있었습니다. 

### ⚒️ 해결방안
이를 해결하기위해 `targetDate`라는 프로퍼티를 만들어 CalendarViewController에 전달하여 캘린더 뷰 생성시 init으로 `targetDate`를 가질 수 있게 만들었습니다.

```swift
// DailyBoxOfficeViewController.swift

private var targetDate: Date?
// ...
@objc func showCalendar() {
    let calendarViewController = CalendarViewController(targetDate: targetDate ?? yesterday)
    navigationController?.present(calendarViewController, animated: true)
}
```
```swift
// CalendarViewController.swift

private var targetDate: Date?
// ...
init(targetDate: Date) {
    self.currentDate = targetDate
    super.init(nibName: nil, bundle: nil)
}
// ...
private func configureCalendarView() {
    // ... 
    let selectedDateComponent = createDateComponent(with: targetDate)
    // ...
    dateSelection.selectedDate = selectedDateComponent
}
```

</br>

## 2️⃣ RefreshControl의 indicator
### 🔍 문제점
<img src="https://i.imgur.com/v96HAGH.gif" width="250">

refreshControl이 나타내는 indicator가 자리를 잡지 못하고 collection view의 셀과 겹쳐지는 현상이 있었습니다.

### ⚒️ 해결방안
endRefreshing() 메서드를 reloadData()와 동일한 위치로 옮겨주었습니다.

```swift
private func loadDailyBoxOffice() {
    //...
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
    //...
}
```

</br>

## 3️⃣ reloadData()의 중복된 호출
### 🔍 문제점
`changeCollectionViewMode()`메서드를 통하여 현재 뷰 모드에 따라 새로운 뷰를 호출해주는 `setCollectionViewLayout`을 설정해주었습니다.
직접 실행해보니, 아이콘모드에서 리스트모드로 넘어갈 때 화면에 보이지 않던 9번 항목의 레이아웃이 의도하지 않은 모양으로 나타났습니다🥲

**코드**
```swift
func changeCollectionViewMode() {
    switch collectionViewMode {
    case .icon:
        collectionViewMode = .list
    case .list:
        collectionViewMode = .icon
    }
    
    collectionView.reloadData()
    collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
}
```
**실행화면 - 리스트모드로 넘어올 때 9번 항목 레이아웃 오류**
<img src="https://i.imgur.com/RVUInJC.gif" width="300">

### ⚒️ 해결방안
#### 1. reloadData()를 두 번 호출해주는 방법
해당 문제를 해결하기위하여 `setCollectionViewLayout()`의 completion을 활용하여 후행클로저에서 `reloadData()`를 다시한번 호출해주는 방법으로 위의 오류를 해결할 수 있었습니다.
```swift
func changeCollectionViewMode() {
    // ...
    collectionView.reloadData()
    collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true) { _ in
        self.collectionView.reloadData()
    }
}
```
하지만 이 방법으로 진행할 시, `reloadData()`메서드가 두 번 호출되며 코스트가 비싸질 것 같다고 생각이들었습니다.

#### 2. 분기처리를 이용하여 reloadData()를 호출해주는 방법
분기처리를 통하여 listLayout일 경우 animation효과를 지연시키고 `reloadData()`를 호출하게하여 위의 오류를 해결하며 적절한 상황에서 `reloadData()`를 호출할 수 있었습니다.

```swift
func changeCollectionViewMode() {
    // ...
    if collectionViewMode == .list {
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: false) { _ in
            UIView.animate(withDuration: 0.3) {
                self.collectionView.reloadData()
            }
        }
    } else {
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
    }
}
```

</br>

## 4️⃣ Image Networking
### 🔍 문제점
MovieDetailsViewController 프로퍼티 posterView의 이미지를 다음 순서의 네트워크 통신을 통해 채워넣고 있습니다.

1. 다음 검색 API를 활용해 가장 상위의 검색 결과의 이미지 URL을 fetch
2. fetch한 URL을 통해 Image Data Load

이번 프로젝트의 네트워크는 `URLSession` 객체를 통해 이루어집니다. dataTask 메서드는 비동기적으로 동작하므로 아래와 같은 순서로 `fetchPosterImageURL`, `loadPosterImage` 메서드를 호출하게 되면 URL fetch가 완료되지 않은 상태로 image load를 시작하게 된다는 문제가 있었습니다.

```swift
final class MovieDetailsViewController: UIViewController {

    override func viewDidLoad() {
        fetchPosterImageURL()
        loadPosterImage()
    }
    
    // ...
}
```

### ⚒️ 해결방안
URL fetch 작업을 기다렸다가 작업이 완료되었을 때 `loadPosterImage`를 호출할 수 있도록 Property Observer를 활용하여 해결하였습니다.

```swift
final class MovieDetailsViewController: UIViewController {
    
    private var movieImageURL: URL? {
        didSet {
            loadPosterImage()
        }
    }
    
    private func fetchPosterImageURL() {
        // ...
        apiProvider.startLoad(decodingType: DaumSearchResult.self) { result in
            switch result {
            case .success(let searchedResult):
                guard let document = searchedResult.documents.first,
                      let url = URL(string: document.imageURL) else { return }
                self.movieImageURL = url
        
        // ...    
    }
    
    private func loadPosterImage() {
        guard let movieImageURL else { return }
        
        let apiProvider = APIProvider()
        LoadingIndicator.showLoading(in: posterView)
        apiProvider.loadImage(url: movieImageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.posterView.image = image
        // ...
    }
                                             
    // ...
}
```

</br>

# ✨ 핵심경험

<details>
    <summary><big>✅ CalendarView 활용</big></summary>
    
`iOS 16+`을 요구하는 `CalendarView`를 이용하여 날짜 선택, 선택한 날짜 반환 및 다양한 기능을 사용해볼 수 있었습니다. 

### 1️⃣ Calendar 만들기

```swift
// CalendarViewController.swift 
    
final class CalendarViewController: UIViewController {
    private let calendar = Calendar(identifier: .gregorian)
    private let calendarView = UICalendarView()
    // ...
    
    private func configureCalendarView() {
        guard let targetDate = self.targetDate else { return }
        
        calendarView.calendar = calendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .rounded
    // ...
    }
}    
```

### 2️⃣ 선택할 수 있는 날짜 범위 지정하기
    
```swift
// CalendarViewController.swift 
    private func configureCalendarView() {
        // ...
        let fromDateComponent = DateComponents(calendar: calendar, year: 2003, month: 11, day: 11)
        let toDateComponent = createDateComponent(with: yesterday)
        
        guard let fromDate = fromDateComponent.date,
              let toDate = toDateComponent.date else { return }
        
        calendarView.visibleDateComponents = toDateComponent
        calendarView.availableDateRange = DateInterval(start: fromDate, end: toDate)
    // ...
    }
}    
```

### 3️⃣ 날짜 선택하기 및 (날짜변경 후) 선택된 날짜 바꾸기 
    
```swift
// CalendarViewController.swift 
    
final class CalendarViewController: UIViewController {
    // ...
    private var targetDate: Date?
    
    private func configureCalendarView() {
        let selectedDateComponent = createDateComponent(with: targetDate)

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.selectedDate = selectedDateComponent
        
        calendarView.selectionBehavior = dateSelection
    // ...
    }
}    
```

</details>

<details>
    <summary><big>✅ ModernCollectionView 활용</big></summary>

### UICollectionViewDiffableDataSource
```swift
// DailyBoxOfficeViewController
private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeMovie>
    
private func configureDataSource() {
    let listCellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeListCell, DailyBoxOfficeMovie> { cell, indexPath, item in
        cell.updateData(with: item)
    }

    let iconCellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeIconCell, DailyBoxOfficeMovie> { cell, indexPath, item in
        cell.updateData(with: item)
    }

     dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
         switch self.collectionViewMode {
         case .icon:
             let cell = collectionView.dequeueConfiguredReusableCell(using: iconCellRegistration, for: indexPath, item: itemIdentifier)

             return cell
         case .list:
             let cell = collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: itemIdentifier)

             return cell
         }
     }
}
```
</br>
    
### NSDiffableDataSourceSnapshot
```swift
// DailyBoxOfficeViewController    
private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeMovie>
    
private func applySnapshot() {
    guard let dailyBoxOfficeList = self.dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList else { return }

    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(dailyBoxOfficeList)

    dataSource.apply(snapshot)
}
```
    
</br>
    
### UICollectionViewCompositionalLayout
```swift
enum CollectionViewMode {
    case list
    case icon
}

struct CollectionViewModeManager {
    private var collectionViewLayoutList = [CollectionViewMode: UICollectionViewCompositionalLayout]()
    
    init() {
        createIconLayout()
        createListLayout()
    }
    
    func layout(mode: CollectionViewMode) -> UICollectionViewCompositionalLayout {
        guard let layout = collectionViewLayoutList[mode] else {
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            
            return UICollectionViewCompositionalLayout.list(using: configuration)
        }
        
        switch mode {
        case .icon:
            return layout
        case .list:
            return layout
        }
    }
    
    private mutating func createListLayout() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionViewLayoutList[.list] = layout
    }
    
    private mutating func createIconLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 30, trailing: 5)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionViewLayoutList[.icon] = layout
    }
}
```
    
</details>
    
<details>
<summary><big>✅ 여러 개의 CellRegistraion 활용</big></summary>
    
사용자가 선택한 모드에 따라 List형태, Icon형태의 Layout을 사용해주어야 했습니다. 
Layout에 따라 다른 Cell을 사용하기 위해 CellRegistration을 미리 만들어두고 `dataSource`가 collectionViewMode에 따라 다른 Cell을 사용할 수 있도록 정의했습니다.     

```swift
private func configureDataSource() {
    let listCellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeListCell, DailyBoxOfficeMovie> { cell, indexPath, item in
        cell.updateData(with: item)
    }

    let iconCellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeIconCell, DailyBoxOfficeMovie> { cell, indexPath, item in
        cell.updateData(with: item)
    }

     dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
         switch self.collectionViewMode {
         case .icon:
             let cell = collectionView.dequeueConfiguredReusableCell(using: iconCellRegistration, for: indexPath, item: itemIdentifier)

             return cell
         case .list:
             let cell = collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: itemIdentifier)

             return cell
         }
     }
}
```

</details>

<details>
<summary><big>✅ NSCache 활용</big></summary>
    
NSCache를 활용해 URL에서 받아온 image에 캐싱을 적용했습니다.
- 캐시 정책은 화면에 보여지는 DailyBoxOffice 영화 정보가 상위 10개만 나타나므로 이미지 캐시의 count를 10으로 설정하여 캐시된 이미지가 10개를 초과하면 먼저 캐시된 이미지를 삭제하도록 설정하였습니다.
- NSCache는 in-memory 캐싱만 가능하기 때문에 잔존 기한은 앱이 실행 중인 동안입니다. 앱을 종료하면 캐시가 삭제되도록 의도했습니다.
    
```swift!
final class CacheManager {
    static let shared = CacheManager()
    private let storage = NSCache<NSString, UIImage>()
    
    private init() {
        storage.countLimit = 10
    }
    
    func store(image: UIImage, urlString: String) {
        let key = NSString(string: urlString)
        self.storage.setObject(image, forKey: key)
    }
    
    func cachedImage(urlString: String) -> UIImage? {
        let cachedKey = NSString(string: urlString)
        if let cachedImage = storage.object(forKey: cachedKey) {
            return cachedImage
        }
        return nil
    }
}
```
    
</details>
 
---
# 🥹 팀 회고 
### 우리팀이 잘한 점
- 저번 주 보다는 깃허브와 많이 친해졌다.
- 유동적인 시간약속으로 개인일정을 소화할 수 있었다. ~~배려에 감사드립니다🙇‍♂️~~ 👍
    
### 우리팀이 노력할 점
- 컨디션관리 잘하기!
- 리뷰 일정 협의 미리 계획해보기
    
---
    

</br>

# 📚 참고 링크

* [🍎 apple developer 공식문서 - UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
* [🍎 apple developer 공식문서 - UICalendarSelectionSingleDate](https://developer.apple.com/documentation/uikit/uicalendarselectionsingledate)
* [🍎 apple developer 공식문서 - UICollection View](https://developer.apple.com/documentation/uikit/uicollectionview)
* [🍎 apple developer 공식문서 - implementing modern collection views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
* [🍎 apple developer 공식문서 - UICollectionLayoutListConfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
* [🍎 apple developer 공식문서 - NSDiffableDatasourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot)
* [🍎 apple developer 공식문서 - UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
* [🍎 apple developer 공식문서 - setCollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionview/1618017-setcollectionviewlayout)
* [🍎 apple developer 공식문서 - UINavigationController(Configuring custom toolbars)](https://developer.apple.com/documentation/uikit/uinavigationcontroller#1654748)
* [🍎 apple developer 공식문서 - toolbarItems](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621867-toolbaritems)
* [🍎 apple developer 공식문서 - NSCache](https://developer.apple.com/documentation/foundation/nscache)
* [🍎 WWDC - 2019 Advances in UI Data Sources](https://developer.apple.com/videos/play/wwdc2019/220)
