# 🎬📽️박스 오피스🎞️🎥

## 💬 소개
> 영화진흥위원회의 `API` 서버와 통신하여 일별 박스오피스 정보를 `JSON`데이터로 `Parsing`하여 하루 전의 박스오피스 목록을 조회하고 영화 상세 정보를 확인할 수 있는 프로젝트입니다.

</br>

## 🔖 목차 

1. [팀원](#1.)
2. [타임 라인](#2.)
3. [시각적 프로젝트 구조](#3.)
4. [실행 화면](#4.)
5. [핵심 경험](#5.)
6. [트러블 슈팅](#6.)
7. [참고 링크](#7.)

---

</br>

<a id="1."></a>

## 1. 🎙️ 팀원

|[Karen ♉️](https://github.com/karenyang835)|
| :-: |
| <Img src="https://avatars.githubusercontent.com/u/124643896?v=4" width="250"/>|

---

</br>

<a id="2."></a>

## 2. ⏰ 타임 라인
> 프로젝트 기간 : 2023.07.24. ~ 2023.08.18.
<details><summary span style="color:black; background-color:#23ff2921; font-size:120%"><b>1주차 (2023.07.24. ~ 2023.07.30)</b></summary></span>


|**날 짜**|**내 용**|
|:-:|-|
| 2023.07.24.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `JSON` <br>|
| 2023.07.25.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `UnitTest` <br>|
| 2023.07.26.    | ✴️ `JSON`타입의 `Decoding`을 위한 `DailyBoxOffice` 구조체 구현 <br>✴️ `JSON`타입의 `Decoding`을 위한 `BoxOfficeResult`구조체 구현 <br>✴️ `JSON`타입의 `Decoding`을 위한 `MovieInfo` 구조체 구현<br> ✴️ `API`서버와의 통신시 구현할 메서드 정의를 위한 `Protocol` 구현 <br> ✴️ 실제 `API`서버와 통신시 실행할 `GetDataAPI`클래스 구현 <br> ✴️ `API`서버와의 통신시 실행 될 부분 `viewController`에 구현<br> ✴️ `DataNamespace` 구현 <br> ✅ `UnitTest` 구현|
| 2023.07.27.    | 🖨️ 부적절한 네이밍 전면 수정 및 컨벤션 동일하게 통일<br>|
| 2023.07.28.    | ✅`test`코드를 `DataManager`로 타겟을 맞추어 디코딩이 원활하게 되는지 테스트하는 코드로 전면 수정 <br> ✍️ `README`작성 <br>|
| 2023.07.29.    |✴️ 영화개별 상세조회용 `JSON`타입의 `Decoding`을 위한 `MovieInfo` 구조체 구현 <br> ✴️ 영화개별 상세조회용 `JSON`타입의 `Decoding`을 위한 `MovieInfo` 구조체 구현<br> ✴️ 영화개별 상세조회용 `JSON`타입의 `Decoding`을 위한 `MovieInfoResult` 구조체 구현<br> ✴️ 영화개별 상세조회용 `JSON`타입의 `Decoding`을 위한 `MovieInfoDescription` 구조체 구현|
| 2023.07.30.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - 네트워크 통신 <br>|
</details>


<details><summary span style="color:black; background-color:#23ff2921; font-size:120%"><b>2주차 (2023.07.31. ~ 2023.08.06)</b></summary></span>

|**날 짜**|**내 용**|
|:-:|-|
| 2023.07.31.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - 네트워크 통신 <br>|
| 2023.08.01.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - 네트워크 통신 <br>|
| 2023.08.02.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `URLSession` <br>|
| 2023.08.03.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `URLSession` <br>|
| 2023.08.04.    |✴️ `URLSession`을 관리할 `NetWorkManager` 구조체 구현 <br> ✴️ `queryItems`와 `URL` 넘겨주는 구조를 변경하기 위해 `URL Extension` 구현 <br> ✴️ `API`키 숨겨서 저장하기 위해 `Bundle Extension` 구현<br>✴️ `Error`관리를 위한 `BoxOfficeError enum`구현<br> 🖨️ `MovieDataFetchable`-> `NetworkingProtocol`로 네이밍 변경 <br> 🖨️ `MovieDataAPI`->` NetworkManager`로 네이밍 변경 및 구조 구현 <br>|
| 2023.08.05.    | ✴️ 서버에서 파일 받아오고 `Decoding`할 `BoxOfficeDecoder `구현  <br> ✴️ 박스오피스 검색 날짜를 받아오기 위해 `Date Extension` 구현 <br>|
| 2023.08.06.    |💥 기존 `Decoding`을 담당하던 `DataManager`을 네트워크 파일을 전체적으로 관리할 용도로 코드 구조 변경 <br> ✅ `URL`의 `mock`데이터 구현<br> ✅ `test`파일 `URLSession`테스트하는걸로 코드 변경 <br>|

</details>


<details><summary span style="color:black; background-color:#23ff2921; font-size:120%"><b>3주차 (2023.08.07. ~ 2023.08.13)</b></summary></span>

|**날 짜**|**내 용**|
|:-:|-|
| 2023.08.07.    | 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Collection View`<br>|
| 2023.08.08.    | 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Collection View`<br>|
| 2023.08.09.    | 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Mordern Collection View`<br>|
| 2023.08.10.    | 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Mordern Collection View`<br>|
| 2023.08.11.    |✂️ `BoxOfficeDecoder`구조체를 역할에 맞게 네트워크 요청 처리와 `Decoding`를 분리 <br> 🖨️ 전체적인 코드 부적절한 네이밍 변경 및 컨벤션 수정 <br> ✍️ `README`작성 <br>|

</details>


<details><summary span style="color:black; background-color:#23ff2921; font-size:120%"><b>4주차 (2023.08.14. ~ 2023.08.18)</b></summary></span>

|**날 짜**|**내 용**|
|:-:|-|
| 2023.08.14.    | 💥 스토리보드 삭제 후 코드베이스 준비 <br> ✴️`UILabel` 구현과 `Alert`를 띄우기 위한 `ViewController`을 `extension`구현 <br> ✂️`BoxOfficeManager`과 `NetworkManager`을 `NetworkService`프로토콜에 맞게 수정하고 역할 분리 <br> 🖨️ 전체적인 코드 컨벤션 통일화 <br>   |
| 2023.08.15.    |✴️ `CollectionView`에 들어갈 `UIModel`구현 및 `DataNamespace`구현 <br> ✴️ 랭킹체크를 위해 `BoxOfficeMovieInfo`에 `rainkingStatus`추가 <br> ✴️ 무비랭킹을 보여주기 위한 `UICollectionViewListCell`구현 <br> ✴️ `BoxOfficeViewController`에 네트워크 통신 메서드 구현 <br> ✴️ `BoxOfficeViewController`에 컬렉션뷰 관련 메서드 구현 <br> | ✴️ 오토레이아웃 설정 및 `Dynamic Types`적용 <br>
| 2023.08.16.    | ✂️ `BoxOfficeError`에 명확하지 않은 에러명 수정 및 `failedToGetData` 케이스 추가<br>✂️ `CellUIModel`에서 누락된 `audienceInfoText`의 `Dynamic Types`적용 <br> ✂️ 순위 유지를 표시해주는 '-'의 `.label`로 모드 변경시 색상 변경 되게 적용 <br> 🖨️ 전체적인 코드 부적절한 네이밍 변경 및 컨벤션 수정 <br> |
| 2023.08.18.    | 전체적인 코드 부적절한 네이밍 수정 <br> ✍️ `README`작성 <br> |

</details>


---

</br>

<a id="3."></a>

## 3.📊 시각적 프로젝트 구조
</br>

### 📂 폴더 구조
```swift
┌── BoxOffice
│   ├── BoxOffice
│   │   ├── Error
│   │   │   └── BoxOfficeError
│   │   ├── Extension
│   │   │   ├── Bundle+
│   │   │   ├── URL+
│   │   │   ├── Date+
│   │   │   ├── String+
│   │   │   ├── UILabel+
│   │   │   └── UIViewController+
│   │   ├── NetWork
│   │   │   ├── KobisAPIType
│   │   │   ├── DefaultDecodingService
│   │   │   ├── BoxOfficeManager
│   │   │   ├── NetworkManager
│   │   │   └── DataManager
│   │   ├── Protocol
│   │   │   ├── NetworkService
│   │   │   └── DecodingService
│   │   ├── Application
│   │   │   ├── AppDelegate
│   │   │   └── SceneDelegate
│   │   ├── Model
│   │   │   ├── CellUIModel
│   │   │   ├── DataNamespace
│   │   │   ├── BoxOfficeRankingViewType
│   │   │   ├── BoxOffice
|   |   |   |   ├── DailyBoxOffice
|   |   |   |   ├── BoxOfficeResult
|   |   |   |   └── BoxOfficeMovieInfo
│   │   │   ├── Movie
|   |   |   |   ├── MovieInfo
|   |   |   |   ├── MovieInfoResult
|   |   |   |   └── MovieInfoDescription
│   │   ├── View
│   │   │   ├── LaunchScreen
│   │   │   └── MovieRankingListCell
│   │   ├── Controller
│   │   │   └── BoxOfficeViewController
│   │   ├── Resource
│   │   │   ├── Assets
│   │   │   ├── Info
│   │   │   └── APIKEY
│   └── BoxOfficeTests
│       ├── BoxOffice
│       ├── BoxOfficeTests
│       ├── MockURLProtocol
│       └── MockNetworkModel
│
└── README.md
```
### 🎨 Class Diagram
</br>

![image](https://github.com/karenyang835/ios-box-office/assets/124643896/9ad9be99-1b19-4416-8d68-72f4e6e23958)


---

</br>

<a id="4."></a>

## 4.📱실행 화면


| <`RoadingView`> | <다이나믹타입> |
| :--------: |:--------: |
|<img src="https://github.com/karenyang835/ios-box-office/assets/124643896/7f38c212-4432-4502-91b2-085f28a57d2e" style="zoom:80%;" />|<img src="https://github.com/karenyang835/ios-box-office/assets/124643896/ff2d74fa-0065-43f1-be87-f15b6a086fb7" style="zoom:80%;" />| 

---

</br>

<a id="5."></a>

## 5. 🏆 핵심 경험 
### 1️⃣`CodingKeys`를 활용한 `Json`파싱
- `CodingKeys`의 사용 목적이 단순히 `JSON`에서 사용하는 스네이크케이스를 카멜케이스로 변환하는 용도로만 사용하지 않고`JSON`에서 축약적인 네이밍부분과 명확하지 않은 네이밍 부분도 변경하는 용도로도 활용하고 알아보기 힘든 네이밍 부분도 `swift`에서 추구하는 네이밍으로 변경하는 용도로 작성해 보았습니다.

### 2️⃣ `Generic`을 활용한 범용 메서드 구현
- 다양한 타입의 `Decoding`에 활용 할 수 있도록 `DecodingManager`의 메서드를 `Generic`으로 구현하였습니다.

### 3️⃣ `URLSession`를 활용한 네트워크 통신
- `URLSession`을 활용하여 영화진흥위원회 오픈 `API`와 통신하여 데이터를 가져 오고 관리해주었습니다.

### 4️⃣ `TestDouble`을 활용한 `UnitTest` 진행
- #### `UnitTest`를 하는 목적과 중점 파악
    - `UnitTest`를 하는 목적은 개발자가 작성한 코드가 제대로 자기 역할에 맞게 수행하는지를 검증하는 것이라는걸 알게 되었습니다. 
    - `UnitTest`를 작성할 때 나무보다는 숲을 볼 수 있게 코드를 작성할 수 있게 해주는 방법 중 하나라고 생각되었습니다. 추후 진행되어질 부분까지 생각하고 염두해서 유연하게 대처할 수 있는 코드를 작성하려고 노력했습니다.
- #### `TestDouble`의 종류
    - **`Dummy`** : 아무것도 하지 않고 자리만 채워줄 뿐인 역할
    - **`fake`** : 실제 객체와 핵심 로직은 동일하게 작성
    - **`Stub`** : 상태 검증, 실제 객체 대신 가짜 객체를 넣어야 하는데 실제 로직은 필요없음.
    - **`Mock`** : 행위 검증, 해당 메소드가 잘 호출되었는지, 얼마나 호출되었는지가 중요할 때 쓰는 것
- 이 중에서도 행위 검증 및 메소드가 잘 호출되는지를 확인하기 위해 `Mock`를 활용하여 `UnitTest`를 진행했습니다.

### 5️⃣ `plist`를 활용한 `apiKey` 설정
- 개인 정보에 해당하고 타인에게 공유되거나 노출되지 않아야하는 `key`정보를 관리해주었습니다.

### 6️⃣ `Modern CollectionView` 사용
- `icon` 모양과 `List` 모양으로 화면을 구성하기 위해서 `Modern Collection View`를 활용하였습니다

---

</br>

<a id="6."></a>

## 6. 🚨 트러블 슈팅

### 1️⃣ `UnitTest`시 왜 자꾸 `nil`로 인식을 하는가?
- `UnitTest`를 진행했을 때 성공으로 떠서 제대로 수행한 것인줄 알았는데 `else`문을 타고 `return`해버리는 문제점이 발생했습니다.
#### ⛔️ 문제점
```swift
struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let dateRange: String
    let movies: [MovieInfo]

    private enum CodingKeys: String, CodingKey {
        case boxOfficeType
        case dateRange = "showRange" 
        case movies = "dailyBoxOfficeList"
    }
}
```
#### ✅ 해결 방법
```swift
struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let dateRange: String
    let movies: [MovieInfo]

    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case dateRange = "showRange"
        case movies = "dailyBoxOfficeList"
    }
}
```


### 2️⃣ `App Transport Security`란 무엇인가?
#### ⛔️ 문제점
- `http`로 `request`를 시도하려고 하자 보라색 문구가 뜨면서 접속이 안되었습니다. 
![스크린샷 2023-08-06 오후 8 22 21](https://github.com/yagom-academy/ios-box-office/assets/124643896/f7acee9b-642d-4292-9ef9-17b3f065050c)

#### ✅ 해결 방법
- 그래서 해당 내용을 검색해보니 `http`는 `https`보다 상대적으로 보안이 취약하기 때문에 발생하는 에러로 `App Transport Security(ATS)`를 활용하여 `http`를 통한 접속의 차단을 해제해 주었습니다.
![스크린샷 2023-08-06 오후 8 27 33](https://github.com/yagom-academy/ios-box-office/assets/124643896/33d0a4ff-f885-4f81-8518-c2decc9405f8)


### 3️⃣ `@available`을 사용하게 되는 이유는?

#### ⛔️ 문제점
- `UICollectionLayoutListConfiguration`와 `UICollectionLayoutListConfiguration`을 활용하려고 할 경우 다음과 같은 오류가 발생했습니다. <br>
![스크린샷 2023-08-15 오전 2 22 14](https://github.com/karenyang835/ios-box-office/assets/124643896/4a9e935d-6bb1-4a02-b0c0-0a4e70758c06)


#### ✅ 해결 방법
- `iOS`버전을 `14`로 올려 해결했습니다. <br>
![스크린샷 2023-08-15 오전 3 03 27](https://github.com/karenyang835/ios-box-office/assets/124643896/49878ab9-cf7c-4ccd-bdab-d6f742a76281)

---

</br>



<a id="7."></a> 
## 7. 🔗 참고 링크
🍎 [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) <br>
🍏 [Apple Developer - JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)<br>
🍏 [Apple Developer - UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller)<br>
🍏 [Apple Developer - URLSession](https://developer.apple.com/documentation/foundation/urlsession)<br>
🍏 [Apple Developer - UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)<br>
🍏 [Apple Developer - UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)<br>
🍏 [Apple Developer - Entering data](https://developer.apple.com/design/human-interface-guidelines/entering-data)<br>


📚 [위키백과 - JSON](https://ko.wikipedia.org/wiki/JSON)<br>

---

</br>
