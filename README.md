# 박스오피스[STEP3]

> 📌 네트워킹을 활용하여 박스오피스 데이터를 불러와 정보를 화면에 표기하고 리스트를 잡아끌면 새로고침할 수 있도록 하는 기능이 있는 앱입니다.

## 📚 목차</br>
- [팀원소개](#-팀원-소개)
- [파일트리](#-파일트리)
- [시각화된 프로젝트 구조](#시각화된-프로젝트-구조)
- [타임라인](#-타임라인)
- [실행화면](#-실행화면)
- [트러블 슈팅](#-트러블-슈팅)
- [참고자료](#-참고자료)

## 🧑‍💻 팀원 소개</br>
| <img src="https://hackmd.io/_uploads/H11K3alon.png" width="200" height="200"/> | <img src="https://github.com/devKobe24/BranchTest/blob/main/IMG_5424.JPG?raw=true" width="200" height="200"/> |
| :-: | :-: |
| [**yyss99(와이)**](https://github.com/yy-ss99) | [**Kobe**](https://github.com/devKobe24) |

## 🗂️ 파일트리</br>
```
.
.
├── BoxOffice
│   ├── API_KEY.plist
│   ├── Model
│   │   ├── BoxOffice.swift
│   │   ├── EndPoint.swift
│   │   ├── Item.swift
│   │   ├── NetworkConfigurable.swift
│   │   ├── NetworkManager.swift
│   │   ├── Section.swift
│   │   └── URLSession.swift
│   ├── View
│   │   ├── Base.lproj
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── CustomListCell.swift
│   │   └── ItemListCell.swift
│   ├──  Controller
│   │   └── ViewController.swift
│   ├── Error
│   │   ├── NetworkConfigurableError.swift
│   │   ├── NetworkManagerError.swift
│   │   └── URLRequestError.swift
│   ├── Extension
│   │   ├── Bundle+.swift
│   │   ├── UICellConfigurationState+.swift
│   │   └── UIConfigurationStateCustomKey+.swift
│   ├── Info.plist
│   ├── Resource
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
├── BoxOfficeTests
│   ├── BoxOfficeTestPlan.xctestplan
│   └── BoxOfficeTests.swift
└── README.md
```

## 🗺️ 시각화된 프로젝트 구조</br>
<img src = "https://github.com/devKobe24/images/blob/main/BoxOffice_Step3.png?raw=true">

## ⏰ 타임라인</br>
프로젝트 진행 기간 | 23.07.10.(월) ~ 23.07.14.(금)

| 날짜 | 진행 사항 |
| -------- | -------- |
| 23.07.25.(월)     |  BoxOffice 모델 객체 생성 및 구현. <br/> JSON 객체 추가 및 BoxOffice 모델 생성 및 구현. <br/> BoxOfficeModel에 코딩키 추가. <br/> BoxOffice Model Unit Test 생성 및 실행.<br/> refactor: MVC 패턴으로 폴더링.<br/> |
| 23.07.26.(화)     | 인덴트 수정.<br/>
| 23.07.27.(수)     | NetworkManager 구현 및 MakeURLRequestError 오류 타입 구현.<br/>
| 23.08.01(화)     | NetworkConfigurable 프로토콜 구현 및 확장.<br/> NetworkConfigurable에 generateURL 메서드 추가.<br/> NetworkConfigurableError 타입 구현.<br/> App Transport Security Settings Key를 추가. <br/> API_KEY gitignore 추가.<br/> Bundle 확장 및 내부 구현. <br/> BoxOffice 데이터 출력을 위한 함수 구현.<br/>
| 23.08.01(화)     | 리드미 업데이트.<br/> NetWorkManagerError 생성. <br/>
| 23.08.06(일)     | Section 모델 구현.<br/>  UIConfigurationStateCustomKey 확장 및 구현. <br/> UICellConfigurationState 확장. <br/>
| 23.08.08(화)     |UICellConfigurationState에 Item 추가. <br/>  boxOffice 구조체에 Hashable 포로토콜 채택. <br/>  UICellConfigurationState에 Item 추가. <br/> CustomListCell 생성. <br/> ItemListCell로 파일명 변경. <br/> CustomListCell 구현. <br/> configureDataSource, creatLayout 함수 구현
| 23.08.10(목)     | Item 타입 생성.<br/> Item 타입으로 수정.<br/> generateURL 함수 수정.<br/> fetchBoxOfficeData 함수 생성, Item으로 수정.<br/> CustomListCell Layout 수정. <br/> ViewController refresh 기능 구현, navigationController 추가.

## 📺 실행화면</br>
- STEP3 BoxOffice 시뮬레이터 실행화면 🎬 </br>
<img src = "https://github.com/devKobe24/images/blob/main/BOXOFFICE_STEP3.gif?raw=true">

## 🔨 트러블 슈팅 
### 1️⃣ **오늘 날짜로 targetDt를 parameter로 설정하고 GET을 SEND했을 경우 데이터가 빈값으로 들어옵니다.**</br>
### 🔒 **문제점** 🔒</br>
<img src = "https://github.com/devKobe24/images/blob/main/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202023-08-11%20%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB%2011.41.50.png?raw=true"></br>

**🚨 `postman`으로 확인해본 결과 `targetDt`를 오늘 날자로 설정하고 `GET`으로 요청을 보냈을 경우 빈 데이터가 돌아오는 것을 확인 할 수 있었습니다.**</br>

### 🔑 **해결방법** 🔑</br>
**🙋‍♂️ 그러므로 화면 상단 네비게이션 타이틀에는 현재 날짜를 보여주게 만들고</br>실제 통신하여 가져오는 데이터는 오늘로부터 24시간 전</br>전날의 데이터를 가져와서 화면에 보여지게 만들려고 계획중이며 코드는 아래와 같이 구성할 예정입니다.**

<details> 
<summary> FetchDateable Model </summary>

```swift!
import Foundation

protocol FetchDateble {
    
}

extension FetchDateble {
    func fetchDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fetchDate = dateFormatter.string(from: currentDate)
        
        return fetchDate
    }
    
    func fetchDateForTargetDt() throws -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyyMMdd"
        let calener = Calendar.current
        let yesterDay = calener.date(byAdding: .day, value: -1, to: currentDate)
        guard let yesterDay = yesterDay else {
            throw FetchDateForTargetDtError.unwrap
        }
        let fetchDate = dateFormatter.string(from: yesterDay)
        
        return fetchDate
    }
}

enum FetchDateForTargetDtError: Error {
    case unwrap
}
```
</details>

<details> 
<summary> ViewController </summary>

```swift!
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHierarchy()
        self.initRefreshControl()
        
        fetchBoxOfficeData {
            DispatchQueue.main.async {
                self.configureDataSource()
                self.setupNavigationTitle()
            }
        }
    }
}
```
</details>

<details> 
<summary> ViewController Extension </summary>

```swift!
extension ViewController: FetchDateble {
    private func setupNavigationTitle() {
        navigationItem.title = fetchDate()
    }
}
```
</details>
<br>

### 2️⃣ **화면을 새로고침을 할 때 새로운 데이터가 들어올 경우 데이터를 업데이트 해주는 방법.**</br>
### 🔒 **문제점** 🔒</br>
**🚨 화면을 땅겨서 새로고침 액션을 실행할 경우, 새로운 데이터가 들어오는 경우에도 불구하고 화면에 새로운 데이터가 새롭게 업데이트 되지 않는 문제점이 있었습니다.**

### 🔑 **해결방법** 🔑</br>
`UICollectionView.CellRegistration` 타입의 `CellRegistration`을 만들고 커스텀하게 `UICollectionViewListCell` 타입의 `ItemListCell` 이름으로 클래스를 만들어 줍니다.</br>

`ItemListCell` 내부에 `updateWithItem(_:)` 함수를 구현하여 이 함수로 새로운 데이터가 들어올 경우 아이템을 업데이트하게 합니다.</br>

`UICollectionViewDiffableDataSource` 타입의 데이터소스를 만들고 `return` 값으로 `collectionView`의 `dequeueConfiguredReusableCell(using:for:item:)`을 활용하여 각각의 `parameter`에 맞는 값을 넣어줍니다.</br>

특히 `using` 파라미터에는 위에서 만든 `cellRegistration`을 넣어줍니다.</br>

이후 `NSDiffableDataSourceSnapshot` 타입의 스냅샷을 만들어 `SectionIdentifierType`에는 미리 만들어 놓은 `Seciotn` 열거형을 넣어주고 `ItemIdentifierType`에는 `Item` 구조체를 넣어주어 `snapshot` 인스턴스를 만듭니다.</br>

`snapshot.append(Item.all)`을 구현하고 `snapshot` 인스턴스와 `dataSource` 인스턴스를 활용하여 `dataSource.apply(snapshot)`을 구현하여 새로운 데이터가 들어올 경우 데이터를 업데이트해 줄 수 있도록 하였습니다.</br>

### 3️⃣ CollectionListView에서 임의로 높이를 주기</br>
### 🔒 **문제점** 🔒</br>

셀의 위아래 여백을 주기 위해 cell의 constraint를 잡았으나 Layout 오류가 발생 했습니다. 높이를 따로 지정해 주지 않았는데도 불구하고 Height의 값이 44로 잡혀 있다는 오류가 발생했습니다. 검색 결과, 자동적으로 cell 높이를 부여해준다는 사실을 알았습니다. 

```swift!
NSLayoutConstraint.activate([
        listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
        listContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
        listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
        movieRankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        movieRankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
        movieRankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
```
### 🔑 **해결방법** 🔑</br>

1. 첫번째 해결 방법 - `listContentView` 위 아래 공백에 더 큰 `priority`주기
    
     `cell`의 자동적으로 정해져 있는 `height`보다 `listContentView`의 아래 공백을 조정하는 `constraint`에 높은 `priority`를 줍니다. 이런 식으로 하면 자동적으로 잡혀있던 `cell`의 `height` 값이 무시되면서 강제로 `listContentView` 위 아래로 공백을 잡아주어서 코드로 잡아준 `layout`이 적용됩니다.

```swift!
let listContentViewBottomConstraint = listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        listContentViewBottomConstraint.priority = .defaultHigh
        let movieRankStackViewBottomConstraint = movieRankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        movieRankStackViewBottomConstraint.priority = .defaultHigh
               
        NSLayoutConstraint.activate([
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listContentViewBottomConstraint,
            
            movieRankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            movieRankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            movieRankStackViewBottomConstraint
        ])
```
2. 두번째 해결 방법 - `cell` 자체의 `height`를 고정해주기
    `cell`에 접근해서 `cell` 자체의 `height`를 결정해주고 이 `cell`의 `height`에 높은 `priority`를 줍니다. 자동적으로 잡혀있던 `cell`의 `height`보다 `code`로 준 `height`가 적용됩니다.

```swift!
let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 100)
        contentViewHeightConstraint.priority = .defaultHigh
     
        NSLayoutConstraint.activate([
            contentViewHeightConstraint,
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            listContentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            movieRankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            movieRankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
```

## 📑 참고자료
- [📃 snapshot()](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource/3255141-snapshot)
- [📃 UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [📃 UICollectionView.CellRegistration](https://developer.apple.com/documentation/uikit/uicollectionview/cellregistration)
- [📃 UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [📃 UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout)
- [📃 UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [📃 UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
    - [🎦 Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
    - [🎦 Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
    - [📃 Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
