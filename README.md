# 박스오피스🎬
## 소개
> 영화진흥위원회의 API를 통해 박스오피스, 영화 상세정보를 불러오는 앱입니다.

**프로젝트 기간 : 23/07/24~**
</br>

## 목차
1. [팀원소개](#1.)
2. [타임라인](#2.)
3. [시각화구조](#3.)
4. [핵심경험](#4.)
5. [트러블슈팅](#5.)
6. [참고자료](#6.)
7. [팀 회고](#7.)

</br>

<a id="1."></a></br>
## 팀원소개
|<Img src =  "https://hackmd.io/_uploads/rJj1EtKt2.png" width="200" height="200">|<Img src="https://hackmd.io/_uploads/rk62zRiun.png" width="200">|
|:-:|:-:|
|[**Yetti**](https://github.com/iOS-Yetti)|[**maxhyunm**](https://github.com/maxhyunm)|

<a id="2."></a></br>
## 타임라인
|날짜|내용|
|:--:|--|
|2023.07.24.| json 파일 파싱을 위한 BoxOfficeEntity 타입 생성, 디코딩 유닛테스트 진행 |
|2023.07.25.| DecodingManager에서 디코딩만 진행할 수 있도록 기능 분리 |
|2023.07.26.| NetworkingManager, BoxOfficeError, MoviewDetailEntity 타입 생성 |
|2023.07.27.| extension으로 중첩타입 분리, URLNamespace 타입 생성 |
|2023.07.31.| 프로젝트 진행을 위한 개인 공부시간 |
|2023.08.01.| 프로젝트 진행을 위한 개인 공부시간 |
|2023.08.02.| CollectionView세팅, BoxOfficeRankingCell 생성 및 셀 구성 세팅,  DiffableDataSource 세팅 및 연결, 랭킹 증감분 AttributedString 처리, collectionView에 refreshControl 추가 |
|2023.08.04.| 리뷰에 따른 리팩토링 진행  |

<a id="3."></a></br>
## 시각화 구조
### File Tree
    ├── BoxOffice
    │   ├── Extension
    │   │   ├── DateFormatter+.swift
    │   │   └── String+.swift
    │   ├── Model
    │   │   ├── BoxOfficeEntity.swift
    │   │   ├── DecodingManager.swift
    │   │   ├── Error.swift
    │   │   ├── MovieDetailEntity.swift
    │   │   ├── NetworkingManager.swift
    │   │   └── URLSessionProtocol.swift
    │   ├──View
    │   │   └── BoxOfficeRankingCell.swift
    │   ├── Controller
    │   │   └── BoxOfficeViewController.swift
    │   ├── Resource
    │   │   ├── AppDelegate.swift
    │   │   ├── SceneDelegate.swift
    │   │   ├── NetworkNamespace.swift
    │   │   ├── Assets.xcassets
    │   │   └── box_office_sample.json
    │   └──  Info.plist
    ├── BoxOffice.xcodeproj
    ├── BoxOfficeTests
    │   ├── BoxOffice.xctestplan
    │   ├── BoxOfficeDecodingTests.swift
    │   ├── BoxOfficeNetworkingTest.swift
    │   └── TestDouble.swift
    └── README.md

### UML
<img src="https://hackmd.io/_uploads/B1tZIkFo3.png"><br>


<a id="4."></a></br>
## 핵심경험
#### 🌟 CodingKeys와 Nested Type Enum을 활용한 중첩 json 파싱
`Nested Type`을 활용하여 여러 단계로 중첩된 형태의 json을 파싱할 수 있도록 하였고, `CodingKeys`를 활용해 이해하기 어려운 파라미터명을 변경하였습니다.
#### 🌟 Generic을 활용한 범용 메서드 구현
다양한 타입의 Entity를 반환해야 하는 `DecodingManager`의 메서드를 `Generic`으로 구현하였습니다.
#### 🌟 xcconfig, info.plist를 활용한 api key 설정
환경 파일을 활용해 원격 저장소에 공유되지 않아야 하는 key 정보를 관리하였습니다.
#### 🌟 UIActivityIndicatorView를 활용한 로딩 구현
데이터 fetch 상태에 따라 `UIActivityIndicatorView`의 상태값을 변경하여 로딩 마크가 활성화/비활성화 되도록 구현하였습니다.
#### 🌟 UIRefreshControl를 활용한 새로고침 구현
`Collection View`에 `UIRefreshColtrol` 객체를 추가하여, 아래로 당겼을 때 새로고침을 진행할 수 있도록 하였습니다.
#### 🌟 Modern Collection View 구현
`Modern Collection View`를 통해 박스오피스 랭킹 리스트를 구현하기 위하여 `Diffable Data Source`와 `Collection View List Cell`를 활용하였습니다.
#### 🌟 Attributed String 활용
하나의 레이블 안에서 여러 가지 색상을 표시하기 위하여 `Attributed String`을 활용하였습니다.

<a id="5."></a></br>
## 트러블슈팅
### 1️⃣ dataTask 메서드로 받아온 데이터 처리
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

### 2️⃣ ATS를 통한 네트워크 설정
**🚨 문제점**</br>
API를 받아와야 하는 도메인이 `https`가 아닌 `http`를 활용하고 있어 네트워크 연결시에 오류가 발생하였습니다.</br>
<img src="https://hackmd.io/_uploads/BkwWly-jn.png"></br>

**💡 해결 방법**</br>
해당 도메인 및 하위 도메인 정보를 ATS에 `Exception Domains`로 추가하여 정상적으로 네트워킹이 가능하도록 구현하였습니다.</br>
<img src="https://hackmd.io/_uploads/Hkj4Tsgjh.png"></br>

### 3️⃣ 로딩과 새로고침 종료 위치 설정
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

### 4️⃣ Cell Accessory 설정
**🚨 문제점**</br>
아래와 같이 코드를 작성하여 각 셀 우측에 악세서리를 추가하였습니다. 하지만 이렇게 하니 `>` 아이콘이 파란색으로 표시되는 것을 확인하였습니다.
```swift
cell.accessories = [.outlineDisclosure()]
```
<img src="https://hackmd.io/_uploads/BJyxnyYoh.png"></br>

**💡 해결 방법**</br>
`tintColor` 설정을 추가하여 회색으로 표시될 수 있도록 변경하였습니다.
```swift
cell.accessories = [.outlineDisclosure(options: .init(tintColor: .systemGray))]
```
<img src="https://hackmd.io/_uploads/r19MhyYj3.png"></br>

### 5️⃣ Cell Separator 설정
**🚨 문제점**</br>
`UICollectionLayoutListConfiguration`의 기본 설정으로 `Collection View`를 구성하니 각 셀 사이의 구분자인 `separator`가 화면 끝까지 이어지지 않는 문제가 있었습니다.</br>
<img src="https://hackmd.io/_uploads/B1ysLAFj2.png"></br>

**💡 해결 방법**</br>
레이아웃 설정에서 아래의 내용을 추가하여 해결하였습니다.
```swift
self.separatorLayoutGuide.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor)
```
<img src="https://hackmd.io/_uploads/SySyvCYo2.png"></br>

### 6️⃣ Test Double 생성
**🚨 문제점**</br>
인터넷 연결이 없는 상태에서 네트워크 통신을 테스트하기 위해 `Test Double`을 생성하였습니다. 이 과정에서 테스트용 `Stub Session`과 실제 `Session` 사이에 호환이 가능하도록 하기 위해 `URLSessionProtocol`을 구현하였는데, `URLSession`에서 이를 상속하려 하니 아래와 같은 경고가 발생하였습니다.</br>
<img src="https://hackmd.io/_uploads/BJeZG3lin.png" width="1000"></br>

**💡 해결 방법**</br>
`CompletionHandler typealias`에 `@Sendable`을 채택하여 해결하였습니다.
```swift
typealias CompletionHandler = @Sendable (Data?, URLResponse?, Error?) -> Void
```


<a id="6."></a></br>
## 참고자료
- [URLSession 공식문서🍎](https://developer.apple.com/documentation/foundation/urlsession)
- [Fetching Website Data into Memory 공식문서🍎](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [UICollectionView 공식문서🍎](https://developer.apple.com/documentation/uikit/uicollectionview)
- [UICollectionViewListCell 공식문서🍎](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [UICollectionViewDiffableDataSource 공식문서🍎](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [야곰 닷넷 - Unit Test](https://yagom.net/courses/unit-test-%ec%9e%91%ec%84%b1%ed%95%98%ea%b8%b0/)
</br>

<a id="7."></a></br>
## 팀 회고
[일일 스크럼](https://github.com/iOS-Yetti/ios-box-office/wiki)

</br>
