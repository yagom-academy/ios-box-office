# 박스오피스
> 영화진흥위원회, Daum 검색 OPEN API를 이용하여 하루 전의 박스오피스 목록을 조회하고 영화 상세 정보를 확인할 수 있는 앱입니다.
> 
> 프로젝트 기간: 2023.03.20 ~ 2023.03.31

## ⭐️ 팀원
| Rowan | 무리 |
| :--------: |  :--------: | 
| <Img src = "https://i.imgur.com/S1hlffJ.jpg" width="200" height="200"/>      |<Img src ="https://i.imgur.com/SqON3ag.jpg" width="200" height="200"/>
| [Github Profile](https://github.com/Kyeongjun2) |[Github Profile](https://github.com/parkmuri)


## 📝 목차
1. [타임라인](#-타임라인)
2. [프로젝트 구조](#-프로젝트-구조)
3. [실행화면](#-실행화면) 
4. [트러블 슈팅](#-트러블-슈팅) 
5. [핵심경험](#-핵심경험)
6. [참고 링크](#-참고-링크)


# 📆 타임라인 
- 2023.03.20 : JSON 모델타입, DataManager 및 BoxOfficeResult 타입 정의, UnitTest작성
- 2023.03.21 : DataManager 객체 정의, Refactoring (컨벤션, 네이밍)
- 2023.03.22 : TestDouble타입 생성 및 DataManager, URLMaker Test 작성
- 2023.03.23 : DataManager Test case 추가, Refactoring(Test 전반)
- 2023.03.24 : DataManager->APIProvider로 리네이밍, URLMaker삭제, KobisAPI가 url관리하도록 변경, EndPoint 타입 생성, API프로토콜 구현, APIProvider Test 작성
- 2023.03.27 : DailyBoxOfficeCell생성 및 Modern Collection View 구현 시도, refreshControl 추가
- 2023.03.28 : Modern Collection View코드 삭제 후 CustomCollectionVeiwCell 구현 및 UICollectionViewDataSource 구현
- 2023.03.29 : MovieDetails 화면구성 및 DaumImageAPI, SearchedImage Model추가
- 2023.03.30 : imageView LoadingIndicator 추가 및 코드 전반 Refactoring
- 2023.03.31 : File Tree 수정

<br/>


# 🌳 프로젝트 구조
## UML
<img src="https://i.imgur.com/hiSZdnQ.png" width="100%">

## File Tree

```
├── BoxOffice
│   ├── App
│   │   ├── AppDelegate
│   │   └── SceneDelegate
│   ├── Model
│   │   └── ResponseModel
│   │       ├── DailyBoxOffice
│   │       ├── MovieDetails
│   │       └── SearchedImage
│   ├── View
│   │   ├── CategoryStackView
│   │   └── DailyBoxOfficeCell
│   └── Controller
│   │   ├── DailyBoxOfficeViewController
│   │   └── MovieDetailsViewController
│   ├── Network
│   │   ├── APIProvider
│   │   ├── DaumImageAPI
│   │   ├── EndPoint
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
│       ├── LoadingIndicator
│       ├── NumberFormat
│       ├── extension+CALayer
│       └── extension+DateFormatter
└── BoxOfficeTests
    ├── APIProviderTests
    │   ├── APIProviderTests
    │   └── TestDoubles
    └── JSONModelTests
        └── JSONModelTests
```

</details>

   
# 📱 실행화면

|시작 시 로딩화면|Daily Box Office|영화 상세정보 화면|
|:---:|:---:|:---:|
|<img src="https://i.imgur.com/bwqW11Z.gif" width="300">|<img src="https://i.imgur.com/SnttuaD.gif" width="300">|<img src="https://i.imgur.com/ZyM18Fq.gif" width="300">|

<br/>

# 🚀 트러블 슈팅
## 1️⃣ startLoad 메서드 모든 오류 Test하기

### 🔍 문제점
처음 Test case 작성 시, test할 메서드에서 던져지는 모든 Error가 처리되지 않고 네트워크 통신이 실패하는 경우 던져지는 Error만 처리하는 문제가 있었습니다.

```swift 
// TestDouble.swift

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, kobisAPI: KobisAPI = .dailyBoxOffice) {
        self.makeRequestFail = makeRequestFail
        self.kobisAPI = kobisAPI
    }
    
     func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
         // 생략
         sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(JokesAPI.randomJokes.sampleData, successResponse, nil)
            }
        }
         //생략
    }
```

### ⚒️ 해결방안
`makeServerError` 프로퍼티를 추가하여 실패 case를 제어할 수 있도록 수정하였습니다.

* `makeServerError` 프로퍼티가 true일 시 NetworkError.server 처리
* `makeRequestFail` 프로퍼티가 true일 시 NetworkError.request 처리

```swift 
class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var makeServerError: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, makeServerError: Bool = false, kobisAPI: KobisAPI = .dailyBoxOffice) {
        self.makeRequestFail = makeRequestFail
        self.makeServerError = makeServerError
        self.kobisAPI = kobisAPI
    }
    
     func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

         // 생략
         sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, nil, NetworkError.request)
            } else if self.makeServerError {
                completionHandler(nil, failureResponse, nil)
            } else {
                switch self.kobisAPI {
                case .dailyBoxOffice:
                    completionHandler(KobisAPI.dailyBoxOffice.sampleData, successResponse, nil)
                case .movieDetails:
                    completionHandler(KobisAPI.movieDetails.sampleData, successResponse, nil)
                }
            }
        }
         //생략
    }
```
</br>

## 2️⃣ `viewDidLoad()` 이후 CollectionView가 나타나지 않던 문제
### 🔍 문제점
DataSource와 Delegate를 통해 CollectionView layout과 Cell 데이터를 채워주었는데도 앱 실행 시 CollectionView가 나타나지 않는 문제점이 있었습니다.

### ⚒️ 해결방안
`loadDailyBoxOffice()` 메서드에서 collectionView의 `reloadData()` 메서드를 호출하여 데이터의 로딩이 완료되면 UI를 업데이트 할 수 있도록 수정하였습니다.
```swift
apiProvider.startLoad(decodingType: DailyBoxOffice.self) { result in
    switch result {
    case .success(let dailyBoxOffice):
        self.dailyBoxOffice = dailyBoxOffice
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            LoadingIndicator.hideLoading()
        }
    case .failure(let error):
        DispatchQueue.main.async {
            self.makeAlert(to: error)
            LoadingIndicator.hideLoading()
        }
    }
}
```

</br>

## 3️⃣ cell 사이 border
### 🔍 문제점
Modern Collection View의 `list()`를 사용할 때와는 다르게 FlowLayout을 사용하여 List형식으로 구현하니, cell 사이를 구분짓는 선이 없어 보는데 불편함이 있었습니다.
이를 해결하기 위해 다음과 같은 방법을 사용해보았습니다.

### 💭 시도 1. background color + spacing
```swift
// DailyBoxOfficeViewController.swift
collectionView.backgroundColor = .systemGray5

private func createListLayout() -> UICollectionViewFlowLayout {
    let configuration = UICollectionViewFlowLayout()
// ...
    configuration.minimumLineSpacing = 0
// ...
}
```
- collectionView의 `backgroundColor`를 원하는 border의 색으로 정한 뒤 레이아웃의 `minimumLineSpacing`을 설정해보았지만 의도한대로 적용이 되지않아 이 방법은 사용하지 않았습니다.

### 💭 시도 2. border 직접 그리기 + spacing
CALayer 타입의 extension을 통해 구분선을 그려주는 메서드를 정의하였습니다.
```swift
extension CALayer {
    func addBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
```
이때, UICollectionViewDelegateFlowLayout 프로토콜 채택 후 cell 사이 간격이 떨어져있는 것을 확인했습니다.

#### 2-a. minimumItemSpacing(vertical scroll 일 때)
- 1번 방법을 시도한 뒤에 DelegateFlowLayout의 `collectionView(_:layout:minimumItemSpacingForSectionAt:)`메서드를 이용하여 기본적으로 주어진 spacing을 지워주려고했습니다... 생각했던대로라면 리스트에 들어있는 cell 하나하가 item이기때문에 적용이 되었어야 했는데 spacing이 적용되지 않아 코드를 다시 살펴보게되었습니다.
`ItemSpacing`은 grid에서 cell 사이, 가로의 spacing을 의미하여 한 섹션에 아이템이 가로로 여러개 놓여있을 때 적용되는 spacing이었습니다. 현재 저희는 한개의 섹션에 아이템이 여러개 들어가있지만 아이템의 가로길이를 view의 크기와 맞춰주었기 때문에 적용되지 않았습니다.

#### ⚒️ 해결방안 2-b. minimumLineSpacing(vertical scroll 일 때)
- 따라서 `collectionView(_:layout:minimumLineSpacingForSectionAt:)`메서드를 사용해주었습니다. 해당 메서드는 grid에서 cell 사이, 세로의 spacing을 의미하고 기본값이 존재하여 0으로 설정 해 준 뒤 border를 그려주어 원하는대로 구현을 할 수 있었습니다.

----

</br>

# ✨ 핵심경험 

<details>
    <summary><big>✅ TestDouble</big></summary>
    
구현해놓은 DataManager 타입을 test하기 위해서는 네트워크 호출을 해야했습니다. 네트워크의 상태와 무관하게 로직을 테스트하기 위해 **Test Double**을 사용해보았습니다.
    
- Test Double 중 Mock를 이용하여 테스트를 원하는 객체의 behavior 테스트를 진행했습니다.
- `MockURLSessionDataTask`를 구현하고 `MockURLSession`의 `resume()`이 호출되면 프로퍼티로 선언된 클로저가 호출됩니다. 
- `MockURLSession`에서는 테스트를 실패하게 만들기 위한 프로퍼티를 생성 후, 초기값으로 false를 설정합니다.
- `dataTask()`에서 결과에 따라 넘겨줄 `failureResponse`, `successResponse`를 만든 후 성공, 실패 제어에 따라 해당하는 response를 전달할 수 있도록 하였습니다.
    
```swift
// TestDoubles 
class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
}
    
class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var makeServerError: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, makeServerError: Bool = false, kobisAPI: KobisAPI = .dailyBoxOffice) {
        self.makeRequestFail = makeRequestFail
        self.makeServerError = makeServerError
        self.kobisAPI = kobisAPI
    }
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)

        let failureResponse = HTTPURLResponse(url: url,
                                              statusCode: 410,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)
        
        let sessionDataTask = MockURLSessionDataTask()
        
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, nil, NetworkError.request)
            } else if self.makeServerError {
                completionHandler(nil, failureResponse, nil)
            } else {
                switch self.kobisAPI {
                case .dailyBoxOffice:
                    completionHandler(KobisAPI.dailyBoxOffice.sampleData, successResponse, nil)
                case .movieDetails:
                    completionHandler(KobisAPI.movieDetails.sampleData, successResponse, nil)
                }
            }
        }
        self.sessionDataTask = sessionDataTask
        
        return sessionDataTask
    }
}

```

    
</details>

<details>
    <summary><big>✅ URLSession</big></summary>

URLSession 객체를 통해 dataTask를 만들어 서버와 통신을 구현했습니다.
    
completionHandler를 통해 전달되는 data, response, error를 사용하여 네트워크 통신 성공/실패 경우를 처리하였습니다. 

```swift
let task = kobisUrlSession.dataTask(with: url) { data, response, error in
    if let error = error {
        completion(.failure(error))
            
        return
    }
            
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        completion(.failure(NetworkError.server))
                
        return
    }
            
    if let data = data,
       let decodedData = try? JSONDecoder().decode(decodingType, from: data) {
        completion(.success(decodedData))
                
        return
    }
    completion(.failure(NetworkError.decoding))
}
```

</details>



<details>
    <summary><big>✅ Modern CollectionView 사용하기</big></summary>

먼저 STEP3 진행 전 요구사항을 살펴보다 **핵심경험** 부분을 읽게되었습니다. 그 중 하나가 `Modern Collection View 활용`이어서 Modern Collection View를 공부하고 사용해보기로 했습니다.
    
- **Modern Collection View**는 `iOS 13.0+`으로, 기존 CollectionView에서 사용하던 `DataSource`와 `Delegate`을 사용하지 않고, 새로운 기능인 `DiffableDataSource`, `CompositionalLayout`을 이용하여 CollectionView를 만들어내는 방법이었습니다.
컬렉션 뷰로 테이블 뷰(처럼 생긴 뷰)를 만들어야 했기 때문에, `CompositionalLayout`의 `list`메서드를 이용하여 목록 형태의 View를 만들게 되었습니다. 또한, `list`메서드와 `collectionViewListCell`이 모두 `iOS 14.0+`을 요구했기 때문에 프로젝트 minimum deployments를 14.0으로 설정하여 구현해보았습니다.

### ✓ Modern Collection View
* [DailyBoxOfficeViewController](https://github.com/Kyeongjun2/ios-box-office/blob/step03/BoxOffice/Controller/DailyBoxOfficeViewController.swift)
* [DailyBoxOfficeCell](https://github.com/Kyeongjun2/ios-box-office/blob/step03/BoxOffice/View/DailyBoxOfficeCell.swift)   
    
</details>

<details>
    <summary><big>✅ CollectionView 사용하기</big></summary>

</br>

## 1️⃣ Cell Customizing

### 1-a. TableViewCell과 같은 모양으로 만들기
```swift!
// Layout Constraint 설정
private var isConstraintNeeded = true

private func setSubviewConstraints() {
    if isConstraintNeeded {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),

            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 10),
            movieStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            accessoryView.leadingAnchor.constraint(equalTo: movieStackView.trailingAnchor),
            accessoryView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            accessoryView.widthAnchor.constraint(equalToConstant: 10),
            accessoryView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    isConstraintNeeded = false
}

// cell의 border 설정
func setBorder() {
    layer.addBorder(color: .systemGray5, width: 1)
}
    
```
모던 컬렉션 뷰의 CollectionViewListCell과는 다르게 CollectionView의 cell을 커스텀으로 사용할 경우 테이블 뷰의 리스트 형식의 셀처럼 모양을 잡아줄 필요가 있었습니다.
데일리 박스 오피스의 랭크와 등락순위/신작을 표시하는 Label을 rankStackView로, 영화 제목과 관객수를 표시하는 Label을 contentStackView로, ListCell에서의 AccessoryView를 accessoryView로 설정한 뒤 constraint를 주어 레이아웃을 설정했습니다.

위와같이 레이아웃만 적용하게되면 cell끼리의 구분이 어려웠고 이를 해결하고자 🚀트러블슈팅-3️⃣번을 거쳐 layer에 boder를 추가할 수 있게 메서드로 만들어주었습니다.
    
</br>

### 1-b. 셀 선택 효과 추가하기
```swift
override var isSelected: Bool {
    didSet {
        if isSelected {
            backgroundColor = .systemGray6
        } else {
            backgroundColor = .clear
        }
    }
}
```
해당 프로퍼티는 코드로 직접 바꾸게 되면 효과가 적용되지 않습니다.
따라서 셀을 선택 해제 상태로 만들어주기 위해 `collectionView(_:didSelectedItemAt:)` 메서드 내부에서 화면 전환 코드 이후에 collectionView의 `deselectItem(at:animated:)`를 이용하여 cell state를 변경했습니다.

</br>

### 1-c. 데이터 채우기
```swift 
func fillLabels(with data: DailyBoxOfficeMovie) {
    fillRankLabel(with: data)
    fillRankDifferenceLabel(with: data)
    fillMovieTitleLabel(with: data)
    fillAudienceCountLabel(with: data)
}
```
Cell의 메서드로 외부에서 데이터를 주입받아 subview를 채울 수 있도록 하였습니다.

## 2️⃣ UICollectionViewDelegateFlowLayout
UICollectionViewFlowLayout 객체를 통해 List 형태의 Layout을 만들었습니다. 해당 객체의 프로퍼티를 직접 수정하지 않고 ViewController가 `UICollectionViewDelegateFlowLayout` 프로토콜을 채택하도록 하여 delegate 메서드를 통해 Layout을 수정했습니다.

```swift
extension DailyBoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    // cell 크기 설정
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height / 10)
    }
    
    // Cell LineSpacing 설정
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // ...
}
```

</br>
    
## 3️⃣ UICollectionViewDataSource
```swift
extension DailyBoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let dailyBoxOffice = self.dailyBoxOffice else { return 0 }
        
        return dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCell.identifier,
                                                            for: indexPath) as? DailyBoxOfficeCell,
              let movieData = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        // cell 구현
        cell.setBorder()
        cell.configureSubviews()
        cell.fillLabels(with: movieData)
        
        return cell
    }
}
```
`collectionView(numberOfItemInSection:)`으로 화면에 표시할 목록의 총 갯수를 반환해주었습니다.

`collectionViewCell(cellForItemAt:)`을 통하여 리스트에 넣어줄 cell을 구현해주었습니다. 



</details>
----


# 📚 참고 링크

* [🍎 apple developer 공식문서 - fetching website data into memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
* [🍎 apple developer 공식문서 - dataTask](https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask)
* [🍎 apple developer 공식문서 - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
* [🍎 apple developer 공식문서 - URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
* [🍎 apple developer 공식문서 - UICollection View](https://developer.apple.com/documentation/uikit/uicollectionview)
* [🍎 apple developer 공식문서 - implementing modern collection views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
* [🍎 apple developer 공식문서 - UICollectionLayoutListConfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
* [🍎 apple developer 공식문서 - NSDiffableDatasourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot)
* [🍎 apple developer 공식문서 - UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)
* [🍎 WWDC - 2019 Advances in UI Data Sources](https://developer.apple.com/videos/play/wwdc2019/220)
* [yeahg_dev 블로그 - URLRequest 만드는 방법](https://velog.io/@yeahg_dev/URLRequest-%EB%A7%8C%EB%93%9C%EB%8A%94-%EB%B0%A9%EB%B2%95-feat.-HTTP)
* [우아한형제들 기술블로그 - iOS Networking and Testing](https://techblog.woowahan.com/2704/)
