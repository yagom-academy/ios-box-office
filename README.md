# 🎥 박스오피스🍿

 <Img src = "https://hackmd.io/_uploads/HySyMN5sh.png" width="725"/>

## 📖 목차

1. [소개](#소개)
2. [팀원](#팀원)
3. [타임라인 및 핵심경험](#타임라인-핵심경험)
4. [UML & 파일트리](#UML-파일트리)
5. [실행 화면](#실행-화면)
6. [트러블 슈팅](#트러블-슈팅)
7. [주요 학습 내용](#주요-학습-내용)
8. [팀 회고](#팀-회고)
9. [참고 링크](#참고-링크)

<br>

<a id="소개"></a>

## 1. 📢 소개

`오늘의 일일 박스오피스`가 궁금하신가요?
혹은 `영화 개별 상세 조회`를 원하시나요?
저희에게 물어보세요!

✔️ 전날 기준 1~10위 박스오피스를 제공해드립니다!
✔️ 새로고침을 원하시면 리스트를 아래로 잡아 끌어주세요!

> **핵심 개념**
> 오픈 API / URLSession / JSON Decoding / CodingKeys / UNIT Test /
> CollectionView / ModernCollectionView / UIActivityIndicatorView /
> UIRefreshControl / NSMutableAttributedString

<br>

<a id="팀원"></a>

## 2. 👤 팀원

| [Serena 🐷](https://github.com/serena0720) | [BMO 🤖](https://github.com/bubblecocoa) |
| :--------: | :--------: | 
| <Img src = "https://i.imgur.com/q0XdY1F.jpg" width="350"/>| <img width="350px" src="https://avatars.githubusercontent.com/u/67216784?v=4">|

<br>

<a id="타임라인-핵심경험"></a>
## 3. ⏱️ 타임라인 및 핵심경험

> 프로젝트 기간 : 2023-07-24 ~ 2023-08-04

**타임라인**

|날짜|내용|
|:---:|---|
| **2023.07.24** |◽️ 일별 박스 오피스 샘플 `json dataset` 추가 <br> ◽️ 일별 박스오피스 Model 추가|
| **2023.07.25** |◽️ 일별 박스오피스 관련 테스트 추가 및 테스트 작성 <br> ◽️ 박스오피스 Model 추가 <br> ◽️ 전체 `Model` `CodingKey` 적용|
| **2023.07.27** |◽️ 네트워크 관련 로직을 처리하는 `NetworkManager` 타입 추가 <br> ◽️ 영화진흥위원회로부터 일별 박스오피스 조회하는 로직 작성|
| **2023.07.28** |◽️ 영화 상세정보 조회를 위한 `DTO` 생성 및 `CodingKey` 적용 <br> ◽️ 영화 상세정보 조회 메서드 추가 <br> ◽️ 매직리터럴 관리를 위한 `NameSpace` 추가 |
| **2023.07.31** |◽️ `Result` 타입을 활용하여 `Model` 바인딩 및 에러처리 |
| **2023.08.02** |◽️ 스토리보드 제거 및 코드베이스 UI 구현 <br> ◽️ 일벽 박스오피스 `Cell` 생성 <br> ◽️ 일별 박스오피스 `CollectionView`로 구현 |
| **2023.08.03** |◽️ `CollectionView` 의 `DataSoruce`를 `DiffableDataSource`로 변경 <br> ◽️ `CollectionView`에 `refresh control` 추가 |
| **2023.08.04** |◽️ 접근성 향상을 위해 `adjustsFontSize` 적용 <br> ◽️ 에러 발생시 `Alert` 출력 |

**핵심경험**

> - 영화진흥위위원회 오픈 API를 참고하여 '오늘의 일일 박스오피스 데이터'와  '영화 개별 상세 데이터' `Model`을 구현
> - `Model`을 활용하여 `URLSession`으로 `JSON` 파일을 `Fetch`
> - `JSON` 파일 `Decode`에 대한 `Unit Test` 작성
> - iOS 14.0 미만 버전을 위한 `CollecionView` / iOS 14.0 이상 버전을 위한 `ModernCollecionView` 구성

<br>

<a id="UML-파일트리"></a>
## 4. 📊 UML & 파일트리

### UML
> 추후 업로드 예정

### 파일트리
```
BoxOffice 
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Error
│   ├── JSONDecoderError.swift
│   └── NetworkManagerError.swift
├── Extension
│   ├── JSONDecoder+.swift
│   └── String+.swift
├── Info.plist
├── Model
│   ├── DTO
│   │   ├── BoxOffice
│   │   │   ├── BoxOffice.swift
│   │   │   ├── BoxOfficeResult.swift
│   │   │   └── DailyBoxOffice.swift
│   │   └── Movie
│   │       ├── Audit.swift
│   │       ├── Company.swift
│   │       ├── Genre.swift
│   │       ├── Movie.swift
│   │       ├── MovieInfo.swift
│   │       ├── MovieInfoResult.swift
│   │       ├── Nation.swift
│   │       ├── People.swift
│   │       └── ShowType.swift
│   └── Section.swift
├── NameSpace
│   ├── CustomDateFormatStyle.swift
│   ├── KobisNameSpace.swift
│   └── MimeType.swift
├── Service
│   └── BoxOfficeService.swift
├── Util
│   └── NetworkManager.swift
├── View
│   └── BoxOfficeCell.swift
└── ViewController
    └── ViewController.swift
```

<br>

<a id="실행-화면"></a>
## 5. 📲 실행 화면
| 박스오피스 로딩 화면 | 박스오피스 리스트 새로고침|
| :--------: | :--------: |
| <Img src = "https://github.com/bubblecocoa/storage/assets/67216784/7662d089-f891-4bd9-978b-3cab4b7f4ce9" width="350"/>| <img width="350px" src="https://github.com/bubblecocoa/storage/assets/67216784/58ec5755-dad8-4966-a80f-d535e2437244">|

<br>

<a id="트러블-슈팅"></a>
## 6. 🛎️ 트러블 슈팅

## CodingKeys
### 🔥 문제점
- 초반 코드 작성 시 `decode` 과정에서 알 수 없는 에러가 계속 발생하였습니다. `decode` 과정에서 어느 부분에서 잘못되었는지를 찾기 위해 코드를 처음부터 다시 작성하다보니, `CodingKey`를 잘못 작성하여 `JSON decode`가 되지 않았다는 것을 발견했습니다.

### 🧯 해결방법
- `CodingKey`를 사용할 때 프로퍼티명을 `swift`에서 사용할 이름으로 지정하고, `enum case`의 값으로 기존의 `JSON` 키 값의 이름을 지정해야합니다. 하지만 이를 반대로 작성하였더니, 알 수 없는 에러가 발생하여 이를 디버깅하는데 많은 시간을 소요하였습니다.

    > CodingKey 잘못 작성 예시
    ```swift
    struct BoxOfficeResult: Decodable {
        let boxofficeType: String
        ...

        enum CodingKeys: String, CodingKey {
            case boxofficeType = "boxOfficeType"
            ...
        }
    }
    ```

    > CodingKey 올바른 예시
    ```swift
    struct BoxOfficeResult: Decodable {
        let boxOfficeType: String
        ...

        private enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            ...
        }
    }
    ```

<br>

## UnitTest에서 do-catch문 사용 시 XCTFail 활용
### 🔥 문제점
- `Unit Test`에서 `JSON` 파일 `Decode`에 대한 테스트를 진행 시 `do-catch`문을 활용하였습니다. 이때 테스트가 실패했을 때 `XCTTest` 메서드를 `retrun`만 하게 되면 테스트가 `Success`처리 되는것을 확인했습니다. 
- 테스트가 꼭 `Then`과정까지 도달하지 않더라도 `Given`과 `When`과정 또한 테스트에 적절하지 않은 값이 들어오거나, 값이 처리되는 과정에 대한 처리가 필요하다고 생각했습니다.

### 🧯 해결방법
- `XCTFail` 메서드를 찾아 테스트 진행 중 적절하지 않은 부분에 삽입해 주었습니다. Apple Developer 공식문서에 따르면 `XCTFail`의 설명은 다음과 같습니다.
    > This function generates a failure immediately and unconditionally.
    > (이 함수는 즉시 무조건 실패를 생성합니다.)

    ```swift
    func test_box_office_sample_json_파일을_디코딩_할_수_있다() {
        // Given
        guard let result: BoxOffice = JSONDecoder.decode(fileName: "box_office_sample") else {
            XCTFail("파일명 'box_office_sample'로 JSON 디코딩 할 수 없습니다.")
            return
        }

        // When

        // Then
        XCTAssertNotNil(result)
    }
    ```

<br>

## Result 타입을 활용하여 URLSession dataTask에서 발생한 에러 처리
### 🔥 문제점
- `ViewController`에서 요청한 `dataTask`에서 작업 도중 에러가 발생하는 경우, 발생한 에러를 `ViewController`에서 전달받아 처리하고 싶었습니다. 하지만 `dataTask` 클로저 내부에서 밖으로 값을 리턴시킬수 없는것처럼, 에러도 밖으로 던질 수 없었습니다.

    > Invalid conversion from throwing function of type '@sendable (Data?, URLResponse?, (any Error)?) throws -> Void' to non-throwing function type '@sendable (Data?, URLResponse?, (any Error)?) -> Void'


### 🧯 해결방법
- `Return` 값이 없는 경우나 `Error throws`를 할 수 없는 상황에서 `Result` 타입을 활용하여 `Error Handling`을 할 수 있습니다. 특히 `URLSession`의 `dataTask`처럼 `Void` 타입으로 기본 구현되어 있는 메소드안에서 발생한 `Error`를 외부로 전달하고 싶을 때 유용하게 사용 가능합니다.

    > 코드 예시
    1. `Error` 타입을 생성
    ```swift
    enum NetworkManagerError: Error {
        case notExistedUrl
        ...
    }
    ```
    2. `Result Type`을 파라미터로 받는 함수 정의 (`Success: Generic`, `Failure: NetworkManagerError`)
    ```swift
    struct NetworkManager {
    // completion Handler 파라미터로 Result Type을 파라미터로 받는 Void 클로저
    static func loadData<T: Decodable>(_ components: URLComponents?,_ dataType: T.Type,_ completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        ...
                // Void 타입으로 기본 구현되어 있는 메소드(dataTask)안에서 Error 발생
                do {
                    ...
                    // 성공한 경우
                    completion(.success(result))
                } catch let error as JSONDecoderError {
                    ...
                    // 실패한 경우
                    completion(.failure(NetworkManagerError.failureJsonDecode))
                } catch {
                    ...
                    completion(.failure(NetworkManagerError.unknown))
                }
            ...
    }
    ```
    3. `Generic` 타입으로 전달받은 `Success` 타입을 구체적 타입으로 다시 전달
    ```swift
    func loadDailyBoxOfficeData(_ completion: @escaping (Result<BoxOffice, NetworkManagerError>) -> Void) {
        ...
        NetworkManager.loadData(components, BoxOffice.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error)) 
            }
        }
    }
    ```
    4. `ViewController`에서 `Success`/ `Failure` 처리
    ```swift
    private func fetchBoxOffice(_ result: Result<BoxOffice, NetworkManagerError>) {
        switch result {
        case .success(let boxOffice):
            ...
        case .failure(let error):
            ...
        }
    }
    ```

<br>

## NSMutableAttributedString를 활용하여 특정 문자 변경하기
### 🔥 문제점
- 랭킹 변동 정보를 표시하기 위해 화살표 특수문자를 활용하였습니다. 이때 변동 정보에 맞추어 `Label Text`의 해당 특수문자의 색상만 바꾸고자 하였습니다. 예를 들어 랭킹이 높아진 경우 빨간색의 위로 향하는 화살표를, 랭킹이 낮아진 경우 파란색의 아래로 향하는 화살표를 표시하고자 했습니다.

### 🧯 해결방법
- `UILable`은 `String Text`뿐만이 아니라 `attributedText`를 사용할 수 있습니다. `String Text`를 사용하게되면 글자에 `foregroundColor`를 줄 수 없기 때문에, `attributeText`를 사용하고자 하였습니다.
- `attributedText`에는 `NSMutableAttributedString` 타입의 값을 대입할 수 있습니다. 하여 `String`을 `NSMutableAttributedString` 타입으로 변환하여 사용했습니다.
- [addAttribute(_:value:range:)](https://developer.apple.com/documentation/foundation/nsmutableattributedstring/1417080-addattribute) 메서드를 이용하여 해당하는 문자를 지정한 색상으로 변경했습니다.

<br>

<a id="주요-학습-내용"></a> 
## 7. 📚 주요 학습 내용

## ✏️ Modern Collection View - DiffableDataSource 사용하기
- 일반 `CollectionView`
    - `ViewController`에 `UICollectionViewDataSource` 프로토콜 채택 후 필요 메서드를 구현합니다.
    - 이후 `CollectionView`의 `dataSource`를 `self`로 지정합니다.
- Modern Collection View
    - `dataSource`로 사용할 `UICollectionViewDiffableDataSource` 클래스를 인스턴스화 합니다.
    - `DiffableDataSource`를 인스턴스화 할때는 `CollectionView`, 사용할 데이터(e.g. `DTO`, `Model` 등), `Section`, `IndexPat`h가 필요로 합니다.
    - `DiffableDataSource`에서 사용하는 데이터 정보가 추가, 삭제, 변경이 되는 경우는 `NSDiffableDataSourceSnapshot` 클래스를 사용합니다.
    - `SnapShot`에는 `Section`정보와 `Items`정보를 각각 전달합니다.
    - 이후 `dataSource`인스턴스에 `Snapshot`을 `apply`합니다.

<br>

## ✏️ iOS14버전 이하와도 호환이 되는 CollectionView 구성하기
- CollectionView 요소를 구성할 때, 버전 호환 문제와 직면하였습니다. 
1. **디테일 악세사리 구현 시**
    예시에 제시되어 있는 디테일 악세사리를 `UICellAccessory`에서 지원해주었습니다.
    ```swift
    cell.accessories = [ 
        .disclosureIndicator(options: .init(tintColor: .systemGray)), 
    ]
    ```
    하지만 `UICellAccessory`은 iOS 14.0 이상부터 지원이 가능하였습니다.
    > 참고 - [UICellAccessory 공식 문서](https://developer.apple.com/documentation/uikit/uicellaccessory)
    
    이를 사용하면 iOS14.0 이하 버전을 지원할 수 없기 때문에 다른 방식으로 구현해보고자 했습니다. 하여 별도의 `label`을 만들어 디테일 악세사리뷰와 같은 형태를 띌 수 있도록 하였습니다.
    ```swift
    private let disclosureIndicatorLabel: UILabel = {
        var label = UILabel()
        label.text = "〉"
        label.textColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        return label
    }()
    ```
    
2. **셀 Separator 구현 시**
    `UICollectionViewListCell`의 프로퍼티 중 `separator`를 사용하면 각 CollecionViewCell 별로 구분선을 생성할 수 있습니다. 하지만 `UICollectionViewListCell`은 iOS14.0 이상 버전에서만 지원이 가능합니다. 
    > 참고 - [UICollectionViewListCell 공식 문서](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
    
    하여 iOS14.0이하 버전과의 호환을 위해 CustomCell의 내용을 View로 감싸서 위,아래 높이 1pt 여백 공간을 만들어 separator로 보일 수 있게금 코드 작성을 했습니다.
    ```swift
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.frame.size.width = view.frame.width
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    ```

<br>

<a id="팀-회고"></a> 
## 8. 💭 팀 회고

<details>
<summary>팀 회고</summary>

### 우리팀이 잘한 점😃
> 추후 작성 예정
    
### 우리팀이 아쉬웠던 점😭
> 추후 작성 예정
    
</details>

<br>

<a id="참고-링크"></a>
## 9. 🔗 참고 링크
- [🍎 Developer Apple - XCTFail](https://developer.apple.com/documentation/xctest/xctfail)
- [🍎 Developer Apple - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎 Developer Apple - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎 Developer Apple - Escaping Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Escaping-Closures)
- [🍎 Developer Apple: UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎 Developer Apple: Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [🍎 Developer Apple: Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
- [🍎 Developer Apple: Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [🍎 Developer Apple: UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [🍎 Developer Apple: Hashable](https://developer.apple.com/documentation/swift/hashable)
- [🍎 Developer Apple: Sendable](https://developer.apple.com/documentation/swift/sendable)
- [📒 Blog: SwiftUI : @escaping](https://seons-dev.tistory.com/entry/SwiftUI-escaping)
- [📒 Blog: XCTAssert Failure Messages](https://www.basbroek.nl/xctassert-asterisk)
- [📒 Blog: [Swift] 예외처리 (throws, do-catch, try) 하기](https://twih1203.medium.com/swift-예외처리-throws-do-catch-try-하기-c0f320e61f62)
- [📒 Blog: do-try-catch 유닛테스트 하기 위한 코드
](https://oingbong.tistory.com/213)
- [📒 Blog: Xcode13 HTTP 통신 방법](https://jerry-bakery.tistory.com/entry/iOS-Xcode13에서-HTTP-통신-사용하는-방법Use-HTTPS-instead-or-add-Exception-Domains-to-your-apps-Infoplist)
- [📒 Blog: DiffableDataSource](https://ios-development.tistory.com/717)
- [📒 Blog: UIActivityIndicator](https://calmone.tistory.com/entry/iOS-UIKit-in-Swift-4-UIActivityIndicator-사용하기)
- [📒 Blog: UIActivityIndicatorView](https://ios-development.tistory.com/985)
- [📒 Blog: 일치하는 모든 문자열의 Attribute를 바꾸고 싶을 때](https://zeddios.tistory.com/462)