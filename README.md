# 🎬 Box Office

## 🍀 소개
> `idinaloq`와 `Mary`가 만든 박스오피스 입니다.

영화진흥위원회 API를 활용하여 일일 박스오피스 조회 및 영화 개별 상세 조회를 진행합니다.

* 주요 개념: `JSON Decoder`, `URLComponents`, `URLSession`, `Fetching Website Data into Memory`, `escaping closure`, `completionHandler`

<br>

## 📖 목차
[1. 팀원](#-팀원) <br>
[2. 타임라인](#-타임라인) <br>
[3. 시각화된 프로젝트 구조](#-시각화된-프로젝트-구조) <br>
[4. 실행 화면](#-실행-화면) <br>
[5. 고민했던 점](#-고민했던-점) <br>
[6. 트러블 슈팅](#-트러블-슈팅) <br>
[7. 참고 링크](#-참고-링크) <br>

<br>

## 👨‍💻 팀원
| **idinaloq** | **Mary** |
| :------: | :------: |
|<Img src = "https://user-images.githubusercontent.com/109963294/235301015-b81055d2-8618-433c-b680-58b6a38047d9.png" width = "200" height="200"/> | <img src="https://i.imgur.com/8mg0oKy.jpg" width="150"> |
|[<img src="https://hackmd.io/_uploads/SJEQuLsEh.png" width="20"/> **GitHub**](https://github.com/DasanKim) |[<img src="https://hackmd.io/_uploads/SJEQuLsEh.png" width="20"/> **GitHub**](https://github.com/MaryJo-github)

<br>

## ⏰ 타임라인
|날짜|내용|
|:--:|--|
|2023.07.24.(월)|일별 박스오피스를 담을DailyBoxOffice타입 생성<br> BoxOfficeTest 추가|
|2023.07.25.(화)|STEP1 PR작성|
|2023.07.26.(수)|영화 상세정보를 담을 DetailInformation타입 생성<br>APIConstants타입 구현|
|2023.07.27.(목)|MovieService타입 생성<br> APIConstants타입 구조변경<br> MovieService테스트코드 작성|
|2023.07.28.(금)|전체적인 리팩토링<br> README작성|
|2023.07.31.(월)| completion handler 구현 및 오류 처리|
|2023.08.01(화)|APIConstants+삭제<br>APIConstants타입 이름변경<br>Error 연관값 추가 및 네이밍 수정<br>의존성 주입을 위해 URLSessionProtocol 추가<br>KobisOpenAPI의 QueryKey 타입 삭제<br>URLError 타입 생성|
|2023.08.02(수)|NetworkService타입에 final 키워드 추가|
|2023.08.03(목)|StoryBoard 삭제 및 CollectionView 생성<br>커스텀 셀 DailyBoxOfficeCollectionViewCell 타입 추가<br>Cell 추가 및 autolayout 설정<br>Date+ 추가|
|2023.08.04(금)|README작성|

<br>

## 👀 시각화된 프로젝트 구조

### Class Diagram
<p>

<img width="500" src="https://hackmd.io/_uploads/ByDz91coh.jpg"> 
    
</p>

<br>

### File Tree
```
.
├── BoxOffice
│   ├── Model
│   │   ├── Date+.swift
│   │   ├── Kobis
│   │   │   ├── KobisOpenAPI.swift
│   │   │   └── KobisServiceType.swift
│   │   ├── NetworkError.swift
│   │   ├── NetworkService.swift
│   │   ├── URLError.swift
│   │   ├── URLSession+.swift
│   │   ├── URLSessionProtocol.swift
│   │   └── DataTransferObject
│   │       ├── DailyBoxOffice
│   │       │   ├── BoxOffice.swift
│   │       │   ├── BoxOfficeResult.swift
│   │       │   └── DailyBoxOffice.swift
│   │       └── MovieInformation
│   │           ├── DetailInformation.swift
│   │           ├── MovieInformation.swift
│   │           └── MovieInformationResult.swift
│   ├── View
│   │   ├── Base.lproj
│   │   │   └── LaunchScreen.storyboard
│   │   └── DailyBoxOfficeCollectionViewCell.swift
│   ├── Controller
│   │   ├── AppDelegate.swift
│   │   ├── SceneDelegate.swift
│   │   └── DailyBoxOfficeViewController.swift
│   ├── Application
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Resource
│   │   ├── Assets.xcassets
│   │   └── Info.plist
└── BoxOfficeTests
    └── BoxOfficeTests.swift
```

<br>

## 💻 실행 화면 
**추가 예정**
<!-- |실행 화면|
|:--:|
|<img src=" " width="600">|
 -->
 
</br>

## 🧠 고민했던 점

### 1️⃣ Nested Data Parsing
- 영화진흥위원회 API 문서를 확인해보니 다음과 같이 데이터가 여러번 중첩되어있는 형태였습니다. 이와같이 복잡한 형태를 가진 데이터의 DTO는 어떻게 만들어야할지 고민하였습니다.
    ```json
    {
      "boxOfficeResult": {
        "boxofficeType": "일별 박스오피스",
        "showRange": "20220105~20220105",
        "dailyBoxOfficeList": [
          {
            "rnum": "1",
            "rank": "1",
            ...
          },
          {
            "rnum": "1",
            "rank": "1",
            ...
          },
          ...
        ]
      }
    }          
    ```
- [공식문서](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types#3540681)를 참고하여 다음과 같이 여러개의 DTO타입을 만들어주어 해결하였습니다.
    ```swift
    struct BoxOffice: Decodable {
        let boxOfficeResult: DailyBoxOffice
    }

    struct DailyBoxOffice: Decodable {
        let boxOfficeType: String
        let showRange: String
        let dailyBoxOfficeList: [MovieInformation]
        ...
    }

    struct MovieInformation: Decodable {
        let rowNumber: String
        let rank: String
        let rankChangeValue: String
        ...
    }
    ```

### 2️⃣ 실패하는 Test case
- 성공하는 테스트 케이스가 아닌, 실패하는 케이스에 대해서도 다음과 같이 작성을 했습니다.
- 실패하는 테스트케이스는 특정 기능이 제대로 작동하지 않는지를 확인하는 데 도움이 되기 때문이라고 생각했습니다.
    ```swift
    func test_boxofficesample프로퍼티와_DailyBoxOffice프로퍼티가다르면_파싱에실패한다() { 
        let test = try? JSONDecoder().decode(BoxOffice.self, from: dataAsset)

        ...

        //then
        XCTAssertNil(test)
    }
    ```

### 3️⃣ Completion Handler
- `fetchData(url: URL, completion: @escaping NetworkResult)`메서드에서 `dataTask()`메서드로 데이터를 비동기로 가져와도 반환할 때는 비동기적으로 데이터를 넘겨주지 않는것을 확인했습니다.
- `completion Handler`인 `escaping closure`를 사용해서 비동기로 데이터를 반환할 수 있었습니다.
    
<br>

## 🧨 트러블 슈팅
### 1️⃣ testable한 코드
⚠️ **문제점** <br>
- 서버에 데이터를 요청할 때 여러 개의 URLSession객체를 만들 필요가 없다고 생각하여 URLSession.shared를 사용하였습니다.
- 하지만 아래와 같은 구조면 네트워크 무관 테스트를 진행하고싶을 때, Session을 주입받는 형태가 아니기 때문에 실제로 통신을 하지 않는 가짜 session으로 변경할 수 없어 테스트가 불가능하였습니다.

``` swift
enum NetworkManager {
    typealias NetworkResult = (Result<Data, NetworkError>) -> Void

    static func fetchData(url: URL, completion: @escaping NetworkResult) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            ...
        }
    }
}
```

✅ **해결방법** <br>
- session을 주입받는 형태로 변경하면서 네트워크 무관 테스트가 가능해졌습니다.
- 기본값을 shared 싱글톤으로 설정하여 불필요한 URLSession 객체 생성을 방지했습니다.

``` swift
class NetworkManager {
    typealias NetworkResult = (Result<Data, NetworkError>) -> Void

    let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchData(url: URL, completion: @escaping NetworkResult) {
        let task = session.dataTask(with: url) { data, response, error in
            ...
        }
    }
}
```

### 2️⃣ reusable, massive type
- 코드를 작성하면서 항상 고민했던 점은 코드의 재사용성과 관련된 부분 이였습니다. 기존에는 재사용성에만 중점을 두었기 때문에 결국 해당 타입을 가져다 쓰기 위해 관리하는 타입의 크기가 관리할 수 없을정도로 커질 가능성이 있었습니다.
**기존코드**
```swift
enum QueryItem {
        static let targetDate: String = "targetDt"
        static let itemPerPage: String = "itemPerPage"
        static let multiMovie: String = "multiMovieYn"
        static let nationCode: String = "repNationCd"
        static let widewAreaCode: String = "wideAreaCd"
        static let movieCode: String = "movieCd"
        static let key: String = "key"
        static let value: String = "c824c74a1ff9ed62089a9a0bcc0d3211"
    }
```
- 기존 코드는 같은 API 타입을 재사용하기 위해 따로 관리를 하기위한 열거형이 있었습니다. 예를들어 `targetDt`는 `targetDate`를 나타내기 위함이였습니다. 하지만 API가 많아지고 그에따라 관리해야되는 쿼리도 많아지게 된다면 추후에 관리가 어려워 질 수 있는 문제가 있다고 생각했습니다. 

✅ **해결방법** <br>

**현재코드**
```swift
struct KobisOpenAPI {
...
 private enum APIKey {
        static let key: String = "key"
        static let value: String = "c824c74a1ff9ed62089a9a0bcc0d3211"
    }
    
    private enum Components {
        static let scheme: String = "http"
        static let host: String = "www.kobis.or.kr"
        static let path: String = "/kobisopenapi/webservice/rest"
    }
}
```
- 쿼리 값들 중 `value` 같은 값을 제외하고 나머지 값들은 리터럴하게 사용하도록 수정했고, 공통으로 사용할 API타입이 아닌 하나의 API타입을 만들고 그 안에에서 고정적인 값 들만 열거형으로 사용하도록 다음과 같이 수정을 했습니다.
<br>

## 📚 참고 링크
- [🍎 Apple Docs: `JSONDecoder`](https://developer.apple.com/documentation/foundation/jsondecoder)
- [🍎 Apple Docs: `URLComponents`](https://developer.apple.com/documentation/foundation/urlcomponents)
- [🍎 Apple Docs: `URLSession`](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎 Apple Docs: `Fetching Website Data into Memory`](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎 Apple Docs: `dataTask with completionHandler`](https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask?changes=_8)
- [🌐 Blog: `escaping closure`](https://jusung.github.io/Escaping-Closure/)
- [🌐 Blog: `iOS 서버통신 연결하기`](https://vanillacreamdonut.tistory.com/254)

<br>

## 👥 팀 회고
### 칭찬할 부분
- 
### 서로에게 하고 싶은 말
- To. idinaloq
    - 
- To. Mary
    - 

---
