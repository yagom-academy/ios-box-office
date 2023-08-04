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
> - **MVC**
>   - `MVC`패턴을 활용하여 객체를 역할에 알맞게 분리하여 프로젝트 구현

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

<br>

<a id="4."></a>
## 4. 📊 UML & 파일트리

### UML

<Img src = "https://hackmd.io/_uploads/Hy3VRfqs3.png" width=""/>

<br>

### 파일트리
```
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── NetWork
│   └── NetworkManager.swift
├── Model
│   ├── BoxOfficeManager.swift
│   ├── DTO
│   │   ├── BoxOffice.swift
│   │   ├── Entity
│   │   │   └── DailyBoxOffice.swift
│   │   └── Movie.swift
│   ├── DataManager.swift
│   └── TestDouble
│       ├── StubURLSession.swift
│       └── URLSessionProtocol.swift
├── Controller
│   └── BoxOfficeViewController.swift
├── View
│    └── BoxOfficeCollectionViewCell.swift
├── Extension
│   ├── DateFormatter+.swift
│   ├── NumberFormatter+.swift
│   ├── UIAlertController+.swift
│   ├── UILabel+.swift
│   ├── URL+.swift
│   └── URLSession+.swift
├── Error
│   ├── DataError.swift
│   └── NetworkError.swift
└── Util
    └── Path.swift
```

<br>

<a id="5."></a>
## 5. 📱 실행 화면
| 박스오피스 데이터 로드 | 화면을 당겨 데이터 리로드 | 데이터 로드에 실패했을 때 알림화면 |
| :--------------: | :-------: |  :-------: | 
| <Img src = "https://hackmd.io/_uploads/BJdHyz9i3.gif" width="225"/> | <Img src = "https://hackmd.io/_uploads/ByZ1xfqi2.gif" width="225"/>  | <Img src = "https://hackmd.io/_uploads/H12xlf5jn.gif" width="225"/> |

<br>

<a id="6."></a>
## 6. 🧨 트러블 슈팅
### 1️⃣  객체 분리

#### 🔥 문제점
`Controller`나 하나의 `Model`에서 많은 로직을 처리하는 것보단 자신의 역할을 가진 객체들을 잘 구현하여 필요할때만 불러 사용한다면 객체간의 의존도 낮추고 코드를 재사용하는 측면에 좋을 것 같아 객체 분리에 대한 고민을 많이 했습니다.

#### 🧯 해결방법
다음과 같이 자신의 역할을 가진 객체를 만들어 프로젝트를 구현하였습니다.

> - **DTO** : 서버로부터 받은 `Data`를 `Decode`할때 쓰는 타입
> - **Entity** : 실제 `App`에서 사용할 `Data` 타입
> - **DataManager** : `DTO`를 `Entity`로 변환해주는 역활
> - **NetworkManager** : 서버로부터 `Data`를 받아오는 역할
> - **BoxOfficeManager** : `Controller`에서 필요한 데이터를 받아 관리하는 타입,
> - **Extension**
>   - URL : `URL`을 생성하는 `kobisURL`메서드 추가
>   - UILabel : `attributedText`의 부분 색을 변경해주는 `convertColor`메서드 추가
>   - UIAlertController : 하나의 액션을 가진 기본적인 `alert`을 반환하는 `errorAlert` 메서드 추가
>   - DateFormatter : 오늘로부터 원하는 만큼 떨어진 날짜를 원하는 포멧으로 반환하는 `dateString` 메서드 추가
>   - NumberFormatter : 숫자로 이루어진 `String`을 받아 `Decimal`스타일로 포멧해주는 `decimalString` 메서드 추가

<br>

### 2️⃣ Closure Capture

#### 🔥 문제점
`BoxOfficeManager`의 `fetchBoxOffice`에서 `requestData`로 네트워킹을하여 데이터를 받아오는 로직에 클로져 내에서 `BoxOfficeManager`의 프로퍼티인 `dailyBoxOffices`로 접근하여 프로퍼티를 변경하는 로직이 있었습니다. 
이때 클로져가 `self`를 캡쳐하면서 `RC`가 올라가 메모리 해제가 안되는 강한참조순환이 발생할 수 있다는 문제가 있었습니다.

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
클로져의 캡쳐로 `self`의 `RC`가 올라가는 것을 막아주기 위해 `[weak self]`로 클로져를 캡쳐하여 강한순환참조를 예방하였습니다.

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

### 3️⃣ @escaping (Error?)

#### 🔥 문제점
`Controller`가 `NetworkManager`로 직접 데이터를 받아와서 가지고 있는 것보단 `BoxOffice`앱에서 필요한 데이터를 받아오고 관리하는 객체가 있으면 좋을 것 같아 `BoxOfficeManager` 객체를 생성하였습니다.
그리고 `BoxOfficeManager`의 데이터 로드가 성공했을때 `UI update`를 하는 방식으로 코드를 구현하기 위해 `BoxOfficeManager.fetchBoxOffice`에서 완료핸들러가 `Error`를 던져 주도록 구현했습니다.
하지만 `Controller`가 어떤 `Error`가 발생했는지 알아야할까라는 고민이 생겼습니다.

**BoxOffice**
```swift
final class BoxOfficeManager {
    private(set) var dailyBoxOffices: [DailyBoxOffice] = []
    
    // ...
    func fetchBoxOffice(completion: @escaping (Error?) -> Void) {
        // ...
    }
    
    // ...
}
```

**BoxOfficeViewController**
```swift
final class BoxOfficeViewController: UIViewController {
    private let boxOfficeManager = BoxOfficeManager()
    
    // ...
    @objc private func loadBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { [weak self] error in
            if let error {
                // error 처리
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                // UI 업데이트
            }
        }
    }
}
```

- `Controller`는 `BoxOfficeManager.dailyBoxOffice`로 접근하여 데이터를 사용하고 `fetchBoxOffice`가 완료됐을때 에러를 반환하지 않으면 `UI update`를 합니다.

#### 🧯 해결방법
`fetchBoxOffice`가 완료됐을때 `Error`를 던져는 것이 아닌 `Bool` 타입을 던져 성공 유무만 알 수 있도록 하고 어떤 에러가 발생했는지는 `Model`인 `BoxOfficeManager`만 알 수 있도록 하였습니다.

**BoxOffice**
```swift
final class BoxOfficeManager {
    private(set) var dailyBoxOffices: [DailyBoxOffice] = []
    
    // ...
    func fetchBoxOffice(completion: @escaping (Bool?) -> Void) {
        // ...
    }
    
    // ...
}
```

**BoxOfficeViewController**
```swift
final class BoxOfficeViewController: UIViewController {
    private let boxOfficeManager = BoxOfficeManager()
    
    // ...
    @objc private func loadBoxOfficeData() {
        boxOfficeManager.fetchBoxOffice { [weak self] result in
            if result == false {
                // 실패했을때 처리
            }
            
            DispatchQueue.main.async {
                // UI 업데이트
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

<a id="7."></a>
## 7. 🔗 참고 링크
- [🍎Apple: Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Capturing-Values)
- [🍎Apple: UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎Apple: attributedText](https://developer.apple.com/documentation/uikit/uilabel/1620542-attributedtext)
