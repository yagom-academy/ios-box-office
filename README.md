## 박스오피스
> 프로젝트 기간: 23/07/24 ~ 23/08/18

URLSession을 이용해 API에서 영화정보를 받아와 CollectionView를 이용하여 List 및 Icon의 형태로 보여주는 프로그램입니다.

## 📂 목차
1. [팀원](#1.)
2. [타임 라인](#2.)
3. [시각화구조](#3.)
4. [실행 화면](#4.)
5. [트러블 슈팅](#5.)
6. [팀 회고](#6.)
7. [참고 문서](#7.)

<a id="1."></a>

## 1. 팀원
| Jusbug | Redmango |
| :--------: | :--------: |
| <Img src = "https://github.com/JusBug/ios-box-office/assets/125210310/549c2726-aa5a-48cc-a39a-7c10d10bdda5" width="200" height="200"> | <Img src = "https://github.com/JusBug/ios-box-office/assets/125210310/c1a12752-eda0-4c4d-8a58-0cc8dccd7707"  width="200" height="200"> |
|[Github Profile](https://github.com/JusBug) |[Github Profile](https://github.com/redmango1447) |
- - -
<a id="2."></a>

## 2. 타임라인

<details>
<summary>타임 라인</summary>
<div markdown="1">
    
### 2023.07.24.(월)
- `BoxOffice` 데이터 타입 구현
- `JSONDecodingHelper` 구현

### 2023.07.25.(화)
- `Unit Test` 케이스 구현

### 2023.07.26.(수)
- API서버와 통신하는 `APIManager` 타입 구현
- `fetchData()`` 구현
- Completion Handler 생성

### 2023.07.27.(목)
- `Movie` 데이터 타입 구현
- Test Double 공부

### 2023.07.28.(금)
- 조회할 대상인 `Service` 타입 구현
- `URLrequest` 생략
- `fetchData()`에 Service type에 따른 분기처리
- 제네릭 `DecodeJSON()`` 메서드 생성

### 2023.07.31.(월)
- `APIError` 타입 구현
- `APIService`로 타입 이름 수정
- `JSONDecodingHelper` 삭제
- `fetchData()`의 `completion` 클로저의 결과 반환 타입을 `Result` 타입을 수정

### 2023.08.01.(화)
- if let으로 `completion(error)` 처리, 불필요한 print 삭제

### 2023.08.02.(수)
- `UICollectionView` 및 `UICollectionViewCell` 구현
- `fetchData()`를 호출해서 decode처리하는 `callAPIManager()`` 구현
- `UIRefreshControl()`을 이용해 당겨서 새로고침 기능 구현
- 어제의 날짜를 받아오는 `DateProvider`와 URLComponents로 URLString을 반환하는 `configureURLSession()`` 구현

### 2023.08.03.(목)
- `NavigationItem.title`에 어제 날짜 표기
- `APIKey` 숨김처리
- `UICollectionViewListCell`을 이용해 Accessory 구현

### 2023.08.04.(금)
- README 작성

### 2023.08.07.(월)
- 개인 공부

### 2023.08.08.(화)
- `CalenderView`를 이용한 날짜선택 기능 구현
- 선택된 날짜를 저장할수 있게 처리

### 2023.08.09.(수)
- 선택된 날짜를 전달받아 URL 생성 후 다시 API에 요청하는 기능 구현
- `DateProvider` 기능 분리
- `URLManager` 싱글톤 적용

### 2023.08.10.(목)
- 당겨서 새로고침할때 API에 재요청 기능 구현
- API에서 요청 결과가 왔을때 `refreshControl`을 `endRefreshing()`하는 기능 구현

### 2023.08.11.(금)
- README 작성
    
### 2023.08.14.(월)
- 개인 공부

### 2023.08.15.(화)
- 화면 모드 변경을 위한 버튼 및 `AlertAction`을 이용한 기능 구현
- `IconMode`의 `CustomCell` 생성 및 등록
- `IsIconMode`에 따라 반환하는 `Cell` 및 분기처리

### 2023.08.16.(수)
- `IconCell`의 레이아웃 및 폰트 설정 및 `Cell`의 구분선 구현
- `Label`의 텍스트 스타일, `CollectionView`의 높이 등 UI의 수정
- `MainView`의 레이아웃 수정 및 `ListCell` 오토레이아웃 설정

### 2023.08.17.(목)
- 개인 공부


### 2023.08.18.(금)
- README 작성

</div>
</details>
<a id="3."></a>


## 3. 시각화 구조

### 📐 Diagram
![](https://hackmd.io/_uploads/Bkf3ouh3n.png)

### 🌲 File Tree

<details>
<summary>File Tree</summary>
<div markdown="1">

```
.
├── BoxOffice
│   ├── App
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Controller
│   │   ├── CalendarViewController.swift
│   │   ├── CollectionViewIconCell.swift
│   │   ├── CollectionViewListCell.swift
│   │   ├── Enum
│   │   │   └── Arrow.swift
│   │   ├── MainViewController.swift
│   │   └── Protocol+
│   │       └── CalendarViewControllerDelegate.swift
│   ├── Model
│   │   ├── APIManager.swift
│   │   ├── DTO
│   │   │   ├── BoxOffice.swift
│   │   │   └── Movie.swift
│   │   ├── DateProvider.swift
│   │   ├── Error
│   │   │   ├── APIError.swift
│   │   │   └── DateProviderError.swift
│   │   ├── Extension
│   │   │   ├── HideAPIKey++Bundle.swift
│   │   │   └── JSONDecoder+.swift
│   │   ├── JSONDecodingHelper.swift
│   │   └── URLManager.swift
│   ├── Resources
│   │   ├── APIKey.plist
│   │   ├── Info.plist
│   └── View
│       ├── Base.lproj
│       │   ├── LaunchScreen.storyboard
│       │   └── Main.storyboard
│       ├── CollectionViewIconCell.xib
│       └── CollectionViewListCell.xib
└── README.md
```

</div>
</details>

</br>
<a id="4."></a>

## 4. 실행 화면


|  | List Mode | Icon Mode |
| :--------: | :--------: | :--------: |
| 실행화면     | <Img src = "https://hackmd.io/_uploads/H1iuid2n2.gif" width="200" height="400"> | <Img src = "https://hackmd.io/_uploads/B1gm3d323.gif" width="200" height="400"> |



</br>
<a id="5."></a>

## 5. 트러블 슈팅

<details>
    <summary><b>네트워크 관련</b></summary>
<div markdown="1">
    
### 1-1. <HTTP 연결 이슈>

🤯 **문제상황** 
ATP 보안 기능으로 인해 HTTP에 대한 접근이 차단되어 테스트를 진행할 수 없었습니다.
![](https://hackmd.io/_uploads/rktGMWAqn.png)

🔥 **해결방법**
ATP에 도메인을 추가하여 해당 도메인에 HTTP에 대한 연결을 허용할 수 있도록 설정해주면서 해결할 수 있었습니다.
![](https://hackmd.io/_uploads/rynMz-R9h.png)

- - -
### 1-2. <재활용성 이슈>

🤯 **문제상황**
요구사항에선
> 1. 오늘의 일일 박스오피스 조회
> 2. 영화 개별 상세 조회

위와같이 2가지의 데이터를 받아오길 원했습니다.
처음엔 매개변수로 URLString을 넘겨줄까했지만 URL이 너무 길어 가독성이 상당히 떨어지는 문제가 있었고, 기존에는 조회할 타입을 직접 넣어서 메서드를 구현했기 때문에 여러 타입의 정보를 가져올 수 있는 재활용성 측면에서 부족한 코드였습니다.

🔥 **해결방법**

enum으로 Service타입을 만든뒤 사용하는 쪽에선 매개변수로 Service를 받게하여 해결하였습니다.
```swift
enum Service: String {
    case dailyBoxOffice = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=202a30725"
    case movieDetailInfo = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=9edeb739e275f3013ffb896c2ff41cfe&targetDt=20230724"
    
    var type: Any {
        switch self {
        case .dailyBoxOffice:
            return BoxOffice.self
        case .movieDetailInfo:
            return Movie.self
        }
    }
}

func fetchData(service: Service, completion: @escaping (Data?) -> Void) { ... }
```
- - -
### 1-3. **<URLRequest 객체의 필요성>**

🤯 **문제상황** 
기존에는 받아온 `URL`을 `URLRequest`로 다시 받아오면서 `DataTask`와 함께 서버로 요청을 넘겨주면서 응답을 받아왔는데, 사실 따로 메서드를 특정하거나 헤더/바디 등 다른 정보를 넘겨주지 않았기 때문에 불필요한 부분이라고 느껴졌습니다.

```Swift
var request = URLRequest(url: url)

// request.httpMethod = "GET"
// request.addValue("Bearer ...")
```

🔥 **해결방법**
`URLRequest` 객체 생성을 생략하고 URL을 바로 `DataTask`에 넘겨주는 것으로 수정했습니다. 다만 이렇게 되면 요청할 때 구성된 정보와 기능이 제한이 되지만 현재에서는 불필요한 부분이라고 생각합니다.

- - -
### 1-4. **<의존성 이슈>**

🤯 **문제상황**
기존에 `APIManager`의 `fetchData()`에서 `completion` 클로저가 결과 값을 반환해준 이후 switch-case로 인자로 전달받은 `APIservice` 타입에 따라 `decodeJSON()`으로 디코딩을 처리해주는 로직이었습니다. 하지만 이렇게 되면, 이후에 데이터 타입이 추가 되거나 삭제 될 경우 해당 타입도 같이 수정해야 하는 의존성 문제가 생길 수 있습니다.

```Swift
completion(.success(safeData))

switch service {
case .dailyBoxOffice:
    if let decodedData: BoxOffice = jsonDecoder.decodeJSON(data: safeData) {
        print(decodedData)
    } else {
        print("Decoding Error")
    }
case .movieDetailInfo:
    if let decodedData: Movie = jsonDecoder.decodeJSON(data: safeData) {
        print(decodedData)
    } else {
        print("Decoding Error")
    }
}

```

🔥 **해결방법**
JSONDecoder의 Extension으로 `decodeJSON()`을 빼와서 확장하고, VC의 `callAPIManager()`에서 디코딩을 처리하도록 하여 APIManager의 `fetchData()`에서는 오로지 API와 통신하는 기능만 관리하게 해주면서 DIP에 준수하도록 수정했습니다. 그 결과, 결합도를 낮추고 유지보수 측면에서 용이하게 되었습니다. 

```Swift
private func callAPIManager() {
    APIManager().fetchData(service: .dailyBoxOffice) { [weak self] result in
        let jsonDecoder = JSONDecoder()
        switch result {
        case .success(let data):
            if let decodedData: BoxOffice = jsonDecoder.decodeJSON(data: data) {
                self?.boxOffice = decodedData
                self?.updateCollectionView()
            } else {
                print("Decoding Error")
            }
        case .failure(let error):
            print(error)
        }
    }
}
```

### 1-5. **<APIKey 관리>**
🤯 **문제상황**
 깃허브에 APIKey가 올라가 공유되고 있었습니다. key가 유출된다면 다양한 보안 사고가 발생할 수 있으므로 저희는 APIKey를 숨기고자 했습니다.
    
🔥 **해결방법**
    .plist파일을 만들고 key를 그곳에 등록시킨뒤 .gitignore를 활용해 깃 추적을 방지해줬습니다. 사용시엔 `Bundle`을 확장하여 활용해 사용해주었는데, 이 extension파일에 .plist의 위치와 파일명이 나와있어 이 파일도 추적방지를 해줘야하는가 고민해봤지만 명확한 답이 떠오르지 않아 우선은 놔두기로 결정했습니다.
    
![](https://hackmd.io/_uploads/SkKMpfYsh.png)

- - -
### 1-6. **<URL 관리>**

🤯 **문제상황**
기존에는 urlString에 host와 path 등, 모든 url 정보를 갖도록 넣어주었습니다.하지만 이렇게 되면 요청하고자 하는 인터페이스를 따로 정의할 수가 없어 API서버와의 접근성에 제한이 생기는 구조가 될 수 밖에 없었습니다.
```Swift
var url: String {
        switch self {
        case .dailyBoxOffice:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=202a30725"
        case .movieDetailInfo:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=9edeb739e275f3013ffb896c2ff41cfe&targetDt=20230724"
        }
    }
```

🔥 **해결방법**
`URLComponents`클래스를 이용하여 데이터 타입과 날짜 등 요청하고자 하는 경로와 인터페이스와 따라서 URL을 임의적으로 구성하고 API서버와 통신할 수 있도록 해결했습니다. 이를 통해서 복잡했던 URL파라미터들을 분리하여 가독성을 높이고 더 안전하게 관리할 수 있게 되었습니다.
    
```Swift
func configureURLSession(key: String, path: String) -> URL? {
    let dateProvider = DateProvider()
    let targetDate = dateProvider.updateYesterday(.urlDate)
    var urlComponents = URLComponents()
    
    urlComponents.scheme = "https"
    urlComponents.host = "www.kobis.or.kr"
    urlComponents.path = path
    urlComponents.queryItems = [
        URLQueryItem(name: "key", value: key),
        URLQueryItem(name: "targetDt", value: targetDate)
    ]
    
    return urlComponents.url
}
```

</div>
</details>

<details>
    <summary><b>UI 관련</b></summary>
<div markdown="1">

### 2-1. **<CollectionViewListCell>**
    
🤯 **문제상황**
 기존의 CollectionViewCell에선 예시화면에서 나온 Accessory를 구현할 수 없었습니다.
    
🔥 **해결방법**
자료를 조금 찾아보니 iOS 버전 14.0 이상부터 사용할 수 있는 CollectionViewListCell을 발견했습니다. 기존의 CollectionViewCell타입을 CollectionViewListCell으로 변경한뒤 Accessory 프로퍼티를 활용하여 셀 우측에`>`를 추가해 주었습니다. 
    
```swift
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewListCell else { return UICollectionViewListCell() }
    
cell.accessories = [.disclosureIndicator()]
```
    
### 2-2. **<UIRefreshControl>**

🤯 **문제상황**
 당겨서 새로고침 기능을 구현하기 위해 UIRefreshControl()를 활용했습니다. 다만 아래와 같이 새로고침이 끝나기도 전에 애니메이션을 cell이 덮는 상황이 발생하였습니다.

🔥 **해결방법**
기존 DispatchQueue.main.async를 asyncAfter로 변경한뒤 2초간의 여유 시간을 주었습니다.
 
<Img src = "https://hackmd.io/_uploads/BJon7MFs3.gif" width="200" height="400"><Img src = "https://hackmd.io/_uploads/rkSHEGKin.gif" width="200" height="400">
    
- - -
### 2-3. **<선택한 날짜로 `selectedDate` 변경>**
    
🤯 **문제상황**
`calenderButton`을 클릭하여 `CalendarView`가 떴을 때 조회한 어제 날짜로 미리 선택되게 하고 다시 다른 날짜를 클릭하고 달력이 떴을 때 이전에 선택했던 날짜로 선택이 되어 있도록 설정할 때 어떤 속성으로 접근을 해야하는지 몰라 엄청 헤맸었습니다.
    
🔥 **해결방법**
`UICalendarSelectionSingleDate` 클래스는 사용자가 선택한 하나 이상의 날짜를 추적하는 개체로서 `SelectedDate`과 함께 날짜의 선택 값을 지정해 줄 수 있었습니다. 따라서 `selectedDate`가 nil일 경우는 `yesterday`를 선택하고, 선택된 날짜가 있을 경우에는 selectedDateComponent로 지정하여 구현했습니다.
    
```Swift
private func showCalendarView() {
    // some code
    let selectedDateComponent = getDateComponent(selectedDate ?? yesterday)
    let dateSelection = UICalendarSelectionSingleDate(delegate: self)
    dateSelection.selectedDate = selectedDateComponent
    // some code
}
```

### 2-4. **<CollectionView 하단에 버튼 추가>**
    
🤯 **문제상황**
기존에는 `CollectionView`를 `Safe area` 영역까지 크기를 설정했기 때문에 하단에 화면모드변경 버튼을 추가하려면 `CollectionView`의 높이를 다시 잡아주어야 했습니다. 하지만 레이아웃 설정이 충돌이 나면서 변경이 되지 않는 문제가 있었습니다.

🔥 **해결방법**
기존의 `Constraint'에서 잡아줬던 `Safe area` 설정을 제거하고 height 값을 직접 넣어주면서 해결할 수 있었습니다.
    

    
- - -
### 2-5. **<iconCell 레이아웃 설정>**
    
🤯 **문제상황**
iconCell을 생성한 뒤 그대로 뷰를 그리게 되면 각셀은 뷰의 left, right에 붙어있고 각 cell의 간격도 격차가 커서 View와 cell그리고 cell 간의 레이아웃을 잡아줘야 하는 문제가 있었습니다. 

🔥 **해결방법**
`UICollectionViewDelegateFlowLayout` 프로토콜을 채택하여 셀의 너비와 높이, 뷰와 셀의 간격 그리고 셀의 라인 값을 설정해주며 전체적인 `listCell`과 `iconCell`의 레이아웃을 잡아주었습니다.
```Swift
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.bounds.width
        let viewHeight = collectionView.bounds.height
        
        if isIconMode {
            let cellWidth = (viewWidth - 20 * 3) / 2
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            return CGSize(width: viewWidth, height: viewHeight / 9)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isIconMode {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isIconMode {
            return 10
        } else {
            return 0
        }
    }
}

```
- - -
### 2-6. **<cell 경계선 설정>**
🤯 **문제상황**
각 셀들을 구분짓기 위해서 기존에는 단순하게 셀의 간격을 두고`backgroundColor`를 넣어 경계가 보이도록 설정하였는데 이번에는 각 셀들에 `layer`에 너비를 주고 컬러를 넣어 경계선이 보이도록 수정했습니다. 하지만 셀들이 서로 겹치는 `layer`에서는 경계선들의 두께가 불규칙적으로 상이해지는 문제가 발생했습니다.
    
```Swift
override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.black.cgColor
}
```
![](https://hackmd.io/_uploads/Bkozp0K33.png)

🔥 **해결방법**
`isIconMode` 변수에 따라 `willSet`을 통해 값이 변경되기 직전, 즉 화면모드가 변경되기 직전에 레이아웃을 설정해주는 로직을 구현했습니다. `UICollectionViewFlowLayout` 아이콘 모드의 레이아웃을 잡아주고, `UICollectionLayoutListConfiguration`은 리스트 모드의 레이아웃을 잡아주고 있습니다. 여기 리스트 모드에서는 `appearance`를 `.plain`으로 주게 되면서 리스트 셀들의 경계선이 그어지고 일렬로 표시되는 레이아웃을 갖게되면서 문제를 해결할 수 있었습니다.
    
```Swift
var isIconMode: Bool = false {
    willSet(newVal){
       changeLayout(newValue: newVal)
    }
}

private func configureFlowLayout() {
    let layout = UICollectionViewFlowLayout()
    collectionView.setCollectionViewLayout(layout, animated: false)
}

private func configureListLayout() {
    let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    collectionView.setCollectionViewLayout(layout, animated: false)
}

private func changeLayout(newValue: Bool) {
    if newValue == true {
        configureFlowLayout()
    } else {
        configureListLayout()
    }
}

```

![](https://hackmd.io/_uploads/HJ5P60Kn3.png)
- - -
    
### 2-7. **<cell의 크기를 벗어난 Label.text 처리>**
🤯 **문제상황**
영화 제목이 긴 경우에는 하단의 다른 내용들이 밀려 정보가 가려지고, 관객수가 커지는 경우에는 셀의 범위를 벗어나 Label의 내용이 ...으로 잘리게되는 문제가 발생하였습니다.
    
- 영화제목의 길이로 인한 내용 잘림
![](https://hackmd.io/_uploads/S1MyvJ923.png)
- 많은 관객수에 따른 내용 잘림
![](https://hackmd.io/_uploads/Sy6JI193n.png)

🔥 **해결방법**
영화 제목은 `allowsDefaultTighteningForTruncation`을 이용하여 label의 너비를 초과하는 경우에도 텍스트를 조절하여 label에 맞게 표시하고, 관객수 정보는 `adjustsFontSizeToFitWidth` 속성을 이용하여 label의 내용이 잘릴 때 자동으로 폰트사이즈를 조절하도록 하였고 추가적으로 셀의 크기는 정해져 있기 때문에 label의 라인의 갯수를 따로 지정해주어 최대한 모든 정보가 담기도록 문제를 해결했습니다.
```Swift
audiNumberLabel.adjustsFontSizeToFitWidth = true
audiNumberLabel.numberOfLines = 1

movieNameLabel.allowsDefaultTighteningForTruncation = true
movieNameLabel.numberOfLines = 2
```
![](https://hackmd.io/_uploads/r1CnuJqh3.png)

    
</div>
</details>

<details>
    <summary><b>Model 및 로직 관련</b></summary>
<div markdown="1">

### 3-1. <데이터 타입 구현>

🤯 **문제상황**
일일 박스오피스의 데이터 형식이 크게 boxOfficeType, showRange, dailyBoxOfficeList로 이루어져 있고 dailyBoxOfficeList 배열 안에 Rank number 순으로 그 안에서 영화들의 각 데이터 요소들을 관리하고 있는데, 처음에는 배열 안의 데이터만 구현할 것인지 아니면 전체 구조를 가져오는 타입을 구현할지 고민하게 되었습니다.
```Swift
struct MovieInfo: Decodable {
    let rankNumber: String
    let rank: String
    let rankInten: String
    ...
```

🔥 **해결방법**
애초에 json파일을 파싱하는 과정에서 json의 데이터 구조와 구조체에 구현한 타입 구조가 다르게 되면 디코딩 에러가 발생하는 이슈가 있었기 때문에 구조를 같게 타입을 구현해 주며 해결하였습니다.
```Swift
struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeInfo
}

struct BoxOfficeInfo: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfo]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct MovieInfo: Decodable {
    let rankNumber: String
    let rank: String
    let rankInten: String
    ...
```
- - -

### 3-2. **<어제 날짜 가져오기>**

🤯 **문제상황**
 어제 날짜를 받아오기 위해 `DateProvider`타입을 생성해줬습니다.
문제는 어제 날짜를 사용하려는 곳이 `URL`과 `NavigationBar`의 `Title`인데 두 곳의 포맷이 서로 달랐습니다.

🔥 **해결방법**
처음으로 생각난 방법은 날짜를 받아오는 메서드를 만들고 별도로 별개의 포맷을 적용, 반환해주는 메소드를 만드는 방식이였습니다. 두번째로 생각난 방법은 enum으로 사용처의 따른 포맷을 case로 만들어 활용하는 방식이였습니다. 확장성 및 유지보수면에서 포맷의 수만큼 별개의 메서드가 계속 만들어져야하는 첫번째 방법보단 case만 추가하면 되는 두번째 방법이 좀 더 효율적이라고 느껴져 enum을 만들어 적용하였습니다.
```swift
struct DateProvider {
    var dateFormatter = DateFormatter()
    
    func updateYesterday(_ form: DateForm) -> String? {
        ...
        
        dateFormatter.dateFormat = form.rawValue
        
        return dateFormatter.string(from: yesterday)
    }
}

enum DateForm: String {
    case urlDate = "YYYYMMdd"
    case viewTitle = "YYYY-MM-dd"
}

```
    
- - -
### 3-3. **<delegate 이슈>**
    
🤯 **문제상황**
`delgate`를 통해서 `UICalendarViewDelegate`를 준수하고 있는 클래스에 선택된 `date`를 전달하고 각 클래스에서 `didSelectDate()`를 구현하여 처리를 해주는데 여기서 url을 반환해주는 `APISerive` 타입이 열거형이라 해당 프로토콜을 준수할 수가 없어 `delegate`를 지정해주지 못하는 문제가 있었습니다.
    
🔥 **해결방법**
수정 초반에는 `APIService` 타입을 클래스로 변경해주며 `didSelectDate()`를 정의해주었으나, `APIService`은 단순히 날짜 정보를 저장하고 url을 생성하여 API요청을 하는 역할을 하기 때문에 해당 메서드를 같이 정의하는 것이 어색하다고 판단했습니다. 따라서 구조체로 변경해주었고 delegate방식이 아닌 `APIService`의 `Singleton` 인스턴스를 생성하여 `selectedDate`를 공유하는 방법으로 해결하였습니다.

```Swift
struct APIService {
    static var shared = APIService()
    var selectedDate: Date?
    // some code
}
```
```Swift
class MainViewController: UIViewController, CalendarViewControllerDelegate {
    // some code
    func didSelectDate(_ date: Date) {
        selectedDate = date
        APIService.shared.selectedDate = date
        // some code
    }
}
```

</div>
</details>


- - -
<a id="6."></a>

## 6. 팀 회고

### 우리팀이 잘한점👍
- 매번 페어 프로그래밍을 진행하기에 앞서 서로가 참고자료들을 통해 충분히 공부해왔습니다. 그런 덕분에 각자가 정리되고 명확한 의견을 항상 공유하면서 프로젝트 진행에 있어 큰 어려움이 없이 이어갈 수 있었습니다.
    
### 서로에게 피드백😀
    
- <To. Redmango🥭>
이번 프로젝트에서는 많고 다양한 기능들을 사용해 보았는데 그런 부분에서 레드망고는 제가 찾지 못했던 필요한 자료들을 잘 찾아주셨고 제가 이해하지 못한 기능들에 대해서 구체적을 잘 설명해주셨습니다.

- <To. Jusbug🕷️>
저스버그는 새로 접한 지식에도 매우 적응이 빨랐고 제가 이해하지 못했던 부분을 잘 설명해주셨습니다.
    
</br>

- - -
<a id="7."></a>

## 7. 참고 문서

- [🍎 Apple-DataTask ](https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask)
- [🍎 Apple-URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎 Apple-URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
- [🍎 Apple-URLComponents](https://developer.apple.com/documentation/foundation/urlcomponents)
- [🍎 Apple-JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecode)
- [🍎 Apple-UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎 Apple-UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [🍎 Apple-CollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎 Apple-UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
- [🍎 Apple-UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [🍎 Apple-UIActionSheet](https://developer.apple.com/documentation/uikit/uiactionsheet)
- [🍎 Apple-UICalendarSelectionSingleDateDelegate](https://developer.apple.com/documentation/uikit/uicalendarselectionsingledatedelegate)
- [🍎 Apple-selectedDate](https://developer.apple.com/documentation/uikit/uicalendarselectionsingledate/3972032-selecteddate)
- [🍎 Apple-UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout)
- [📖 blog-DateFormatter](https://formestory.tistory.com/6)
- [📖 blog-URLSession](https://greatpapa.tistory.com/66)
- [📖 blog-UIActivityIndicatorView](https://velog.io/@qudgh849/UIActivityIndicatorView-%EC%82%AC%EC%9A%A9%EB%B2%95)
- [📖 blog-Date](https://garamm.tistory.com/m/132)
- [📖 blog-DateFormatter](https://hururuek-chapchap.tistory.com/156)
- [📖 blog-Calendar](https://es1015.tistory.com/511)
- [📖 blog-CustomCell](https://velog.io/@jyw3927/Swift-Custom-Cell%EB%A1%9C-UICollectionView-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-i4xtxih4)
- [📖 blog-NavigationController](https://velog.io/@5n_tak/Swift-ViewController-%ED%99%94%EB%A9%B4%EC%A0%84%ED%99%98-%EB%B0%A9%EB%B2%95)
- [📖 blog-UICellAccessory](https://sujinnaljin.medium.com/ios-uicellaccessory-%EC%A2%85%EB%A5%98-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-335d3f4a1f3c)
- [📖 blog-NumberFormatter](https://jinsangjin.tistory.com/104)
- [📖 blog-NSMutableAttributedString](https://roniruny.tistory.com/144)
- [📖 blog-Hiding APIKey](https://leeari95.tistory.com/76)
- [📖 blog-UICalendarView ](https://ohwhatisthis.tistory.com/23)
- [📖 blog-UIAlertAction](https://scshim.tistory.com/220)
