# 🎥 박스오피스🍿

 <Img src = "https://hackmd.io/_uploads/HySyMN5sh.png" width="725"/>

## 📖 목차

1. [소개](#소개)
2. [팀원](#팀원)
3. [타임라인 및 핵심경험](#타임라인-핵심경험)
4. [파일트리](#파일트리)
5. [실행 화면](#실행-화면)
6. [트러블 슈팅](#트러블-슈팅)
7. [주요 학습 내용](#주요-학습-내용)
8. [팀 회고](#팀-회고)
9. [참고 링크](#참고-링크)

<br>

<a id="소개"></a>

## 1. 📢 소개

`일일 박스오피스`가 궁금하신가요?
혹은 `영화 개별 상세 조회`를 원하시나요?
저희에게 물어보세요!

✔️ 캘린더에서 원하시는 날짜를 선택해주세요 📅 <br>
✔️ 해당 날짜의 1️⃣~🔟위 박스오피스를 제공해드립니다! <br>
✔️ 새로고침을 원하시면 리스트를 아래로 잡아 끌어주세요! <br>
✔️ 영화 별 상세정보도 확인 가능하니 놓치지 마시고 확인해 보세요😆

> **핵심 개념**
> 오픈 API / URLSession / JSON Decoding / CodingKeys / UNIT Test / <br>
> CollectionView / ModernCollectionView / UIActivityIndicatorView /  <br>
> UIRefreshControl / NSMutableAttributedString / <br>
> API KEY 발급 및 노출 방지 / Image Fetch / NSCache / <br>
> Modal / UICalendarView / DateManager / Image Loading View

<br>

<a id="팀원"></a>

## 2. 👤 팀원

| [Serena 🐷](https://github.com/serena0720) | [BMO 🤖](https://github.com/bubblecocoa) |
| :--------: | :--------: | 
| <Img src = "https://i.imgur.com/q0XdY1F.jpg" width="350"/>| <img width="350px" src="https://avatars.githubusercontent.com/u/67216784?v=4">|

<br>

<a id="타임라인-핵심경험"></a>
## 3. ⏱️ 타임라인 및 핵심경험

> 프로젝트 기간 : 2023-07-24 ~ 2023-08-18

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
| **2023.08.06** |◽️ `BoxOfficeService`를 사용하는 곳은 모두 의존성 주입을 받아 사용하도록 변경 <br> ◽️ 공통 `Alert` 중복 메서드 분리 <br> ◽️ 영화 상세정보 `ViewController` 생성 및 구현 <br> ◽️ 다음 이미지 검색 관련 `DTO` 추가 |
| **2023.08.07** |◽️ `NetworkManager` 로직 변경 및 싱글톤 클래스로 변경 <br> ◽️ `Dynamic Type` 적용 |
| **2023.08.08** |◽️ `Kakao Developer`에 팀 앱 생성  <br> ◽️ `KakaoAPIKey`를 `plist`에 등록 |
| **2023.08.09** |◽️ 이미지 로드 애니메이션 생성 <br> ◽️ 이미지 캐시 저장 로직 추가 |
| **2023.08.10** |◽️ 박스오피스 날짜 선택 `ViewController` 추가 <br> ◽️ `BoxOfficeService`의 날짜 로직을 `DateManager` 싱글톤 클래스로 분리 |

**핵심경험**

> - 영화진흥위위원회 오픈 API를 참고하여 '오늘의 일일 박스오피스 데이터'와  '영화 개별 상세 데이터' `Model`을 구현
> - `Model`을 활용하여 `URLSession`으로 `JSON` 파일을 `Fetch`
> - `JSON` 파일 `Decode`에 대한 `Unit Test` 작성
> - iOS 14.0 미만 버전을 위한 `CollecionView` / iOS 14.0 이상 버전을 위한 `ModernCollecionView` 구성
> - `Kakao API Key`를 활용하여 영화 포스터 `fetch`하기
> - `fetch`한 이미지 및 데이터를 `StackView`와 `ScrollView`에 넣기

<br>

<a id="파일트리"></a>
## 4. 🌲 파일트리

### 파일트리
```
BoxOffice 
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Error
│   ├── AlertManager.swift
│   ├── JSONDecoderError.swift
│   └── NetworkManagerError.swift
├── Extension
│   ├── Bundle+.swift
│   ├── JSONDecoder+.swift
│   ├── String+.swift
│   └── UIFont+.swift
├── Info.plist
├── KakaoAPIKey.plist
├── Model
│   ├── DTO
│   │   ├── BoxOffice
│   │   │   ├── BoxOffice.swift
│   │   │   ├── BoxOfficeResult.swift
│   │   │   └── DailyBoxOffice.swift
│   │   ├── DaumSearch
│   │   │   ├── DaumSearchMainText.swift
│   │   │   ├── DaumSearchMeta.swift
│   │   │   └── ImageDocument.swift
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
│   ├── KakaoNameSpace.swift
│   ├── KobisNameSpace.swift
│   ├── MimeType.swift
│   └── MovieDetailNameSpace.swift
├── Protocol
│   ├── CalendarViewControllerDelegate.swift
│   └── DaumSearchDocumentable.swift
├── Service
│   └── BoxOfficeService.swift
├── Util
│   ├── DateManager.swift
│   ├── ImageCacheManager.swift
│   └── NetworkManager.swift
├── View
│   ├── BoxOfficeCell.swift
│   ├── Custom
│   │   ├── DetailLabel.swift
│   │   ├── LabelsStack.swift
│   │   └── TitleLabel.swift
│   └── MovieDetailView.swift
└── ViewController
    ├── BoxOfficeViewController.swift
    ├── CalendarViewController.swift
    └── MovieDetailViewController.swift
```

<br>

<a id="실행-화면"></a>
## 5. 📲 실행 화면
| 박스오피스 로딩 화면 | 박스오피스 리스트 새로고침|
| :--------: | :--------: |
| <Img src = "https://github.com/bubblecocoa/storage/assets/67216784/7662d089-f891-4bd9-978b-3cab4b7f4ce9" width="350"/>| <img width="350px" src="https://github.com/bubblecocoa/storage/assets/67216784/58ec5755-dad8-4966-a80f-d535e2437244">|
| 이미지 로딩 화면 | 캘린더로 날짜 선택하기 |
| <Img src = "https://hackmd.io/_uploads/BkRj2OG3n.gif" width="350"/>| <img width="350" src="https://hackmd.io/_uploads/Sy5W8P73h.gif">|


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

## API Key를 git에 노출시키지 않는 방법
### 🔥 문제점
- `이미지 검색 API`를 사용하기 위해 `Kakao Developer`에서 앱을 생성하여 `REST API Key`를 발급받았습니다. 발급받은 `REST API Key`를 이용해 `이미지 검색 API`를 이용하는데 성공했고, 해당 내용을 커밋하려고 했습니다.
- 변경 내역을 확인하던 중 `API Key`가 포함된 코드가 커밋된다면 이후 별도 관리를 위해 해당 코드를 제거하더라도 깃 커밋 이력에 `API Key`가 그대로 노출 되는 상황이 발생하게 됩니다.

### 🧯 해결방법
- 저희는 이러한 상황이 발생하지 않도록 하기 위해 `KakaoAPIKey.plist` 파일을 만들고 `gitignore`에 추가했습니다. 해당 파일은 깃을 통해 받을 수 없게 되었기 때문에 팀원에게 직접 파일 전달을 하는 방식으로 작업하게 됩니다.
- `plist`내부의 데이터는 `Bundle`을 확장하여 읽기전용 프로퍼티를 통해 가져오도록 했습니다.
    ```swift
    extension Bundle {
        var kakaoApiKey: String {
            guard let file = self.path(forResource: "KakaoAPIKey", ofType: "plist") else { return "" }
            guard let resource = NSDictionary (contentsOfFile: file) else { return "" }
            guard let key = resource["Authorization"] as? String else {
                fatalError("KakaoAPIKey.plist에 Authorization를 설정해주세요.")
            }

            return key
        }
    }

    enum KakaoNameSpace {
        ...
        static let authorization = "Authorization"
        static let apiKey = Bundle.main.kakaoApiKey // Bundle에 등록된 Key를 NameSpace로 관리
    }

    // 이후 URLRequest에 header에 필요한 정보를 주입
    let headers = [
        KakaoNameSpace.authorization : KakaoNameSpace.apiKey
    ]
    
    ```
    > `Bundle`은 실행 가능한 코드와 해당 코드의 자원을 포함하는 디렉토리입니다.
    > `Bundle`은 여러가지가 있는데, 그 중 `main`은 앱이 실행되는 코드가 있는 `Bundle` 디렉토리에 접근할 수 있는 `bundle`입니다.

<br>

## UIImageView의 Height를 동적으로 입력
### 🔥 문제점
- 이미지 검색 API를 통해 어떤 사이즈의 이미지를 가지 와도 이미지의 `width`는 `contentView`의 `width`와 맞추면 되었습니다. 하지만 `UIImage.contentMode`를 어떻게 조정해도 가로 혹은 세로 사이즈의 요구조건을 맞출 수 없었습니다.

### 🧯 해결방법
- `UIImageView.contentMode`와 상관없이, 비율을 계산하여 세로 사이즈를 조정해주기로 했습니다. 다행히도 이미지 검색 시 가로, 세로 사이즈 정보가 함께 제공되었기 때문에 어렵지 않게 높이를 동적으로 입력할 수 있었습니다.
    ```swift
    private func setPosterImage(_ imageDocument: ImageDocument, _ image: UIImage) {
        // 비율 = UIImage 프레임 가로 ÷ 로드된 이미지 실제 가로 사이즈
        let ratio = self.movieDetailView.posterImage.frame.width / CGFloat(integerLiteral: imageDocument.width)
        // 높이 = 비율 × 로드된 이미지 실제 세로 사이즈
        let height = ratio * CGFloat(integerLiteral: imageDocument.height)
        self.movieDetailView.posterImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.movieDetailView.posterImage.image = image
    }
    ```

<br>

## UIFont Extension을 활용하여 Dynamic Bold Font 구현
### 🔥 문제점
- 특정 문자의 두께를 변경하고자 할 때 어떤 방법을 사용할 지 고민하였습니다.
- swift 기본 제공 메서드를 활용하는 방법이 있지만, 이는 `Font`의 **사이즈가 고정** 된다는 단점이 존재했습니다.
    ```swift
    .systemFont(ofSize: 17, weight: .bold)
    ```
- `Label`과 `Button`은 `Dynamic Type`에 대한 대응이 되어야한다고 생각했기 때문에, `Font`의 사이즈가 고정되지 않으면서 특정 `Font`의 두께를 조절할 수 있는 방법을 찾고자 하였습니다.


### 🧯 해결방법
- `UIFont`를 `extension`하여 폰트를 `Custom`할 수 있다는 것을 알게되어 이를 활용하였습니다.
    ```swift
    extension UIFont {
        static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
            let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
            let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: weight)
            let metrics = UIFontMetrics(forTextStyle: style)
            return metrics.scaledFont(for: font)
        }
    }
    ```

<br>

## Singleton 구조의 DateManager로 Date 관리 로직 분리
### 🔥 문제점
- 이전 Step에서는 어제의 날짜 기준으로 모든 데이터를 로드하면 되었으나, 이번 Step부터는 다양한 날짜를 대응해야 했습니다. 여러 `ViewController`에서 지정 날짜를 공유해야 하는 상황에서 어떤 방식으로 대응할지 고민을 했습니다.
- `ViewController`간 날짜 정보를 주고 받을 수 있지만, 날짜 정보를 가지고 있는 `ViewController`가 모두 메모리에서 해제되는 경우 날짜 정보가 초기화 되는 위험이 있었습니다.
- 기존에 생성한 `BoxOfficeService`는 앱의 생명주기와 함께하는 구조체이기 때문에, 기존 날짜 관련 로직을 이곳에서 관리하였습니다. 하지만 날짜 관련 로직이 증가하면서 이전과 같이 `BoxOfficeService`에서 이를 모두 관리하는 것은 적절하지 않다고 생각했습니다.

### 🧯 해결방법
- `DateManager`를 생성하여 날짜 관련 프로퍼티를 해당 클래스에서 처리하도록 했습니다.
    ```swift
    class DateManager {
        static private let dateFormatter = DateFormatter()
        static let yesterday: Date = .now - (24 * 60 * 60)
        static var selectedDate: Date = yesterday
        ...

        private init() {}
    }
    ```

<br>

## UICalendarView 선택된 날짜
### 🔥 문제점
- 날짜선택 화면의 달력에는 현재 선택된 날짜가 미리 선택되어 있어야 한다는 내용이 있었습니다. 해당 요구사항을 구현하기 위해 `UICalendarView.Decoration`를 이용했습니다.
    > 커스텀 데코레이션에 적용한 코드
    ```swift
    private func customDecoration() -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.clipsToBounds = false
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }
    ```
    <Img src = "https://hackmd.io/_uploads/B1snPOMnh.png" width="350"/>
- 결과는 날짜의 하단 일부 영역에만 커스텀을 할 수 있을 뿐, 날짜 자체가 선택된 효과를 줄 수 없었습니다. 

### 🧯 해결방법
- `UICalendarSelectionSingleDate`를 인스턴스화 하고(`UICalendarSelectionSingleDateDelegate`도 채택합니다.) 아래 코드를 적용하면, 원하는 효과가 적용되는 것을 확인할 수 있었습니다.
    ```swift
    let dateSelection = UICalendarSelectionSingleDate(delegate: self)
    calendarView.selectionBehavior = dateSelection
    ```
- 추가로 아래 코드를 작성하여 캘린더뷰가 열릴 때부터 날짜가 선택된 효과를 적용할 수 있었습니다.
    ```swift
    dateSelection.selectedDate = DateComponents(year: year, month: month, day: day)
    ```

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

## ✏️ animatedImage를 활용하여 Loading 화면 구성
- 이미지 로딩 화면을 구성 시 어떤 방법을 사용할 지 고민이 많았습니다. `BoxOfficeViewController`처럼 `activityIndicatorView`를 사용할 수도 있었지만, 다른 종류의 로딩화면도 구현해보고자 하였습니다. 고민을 하던 중 통상적인 앱에서 로딩화면서 움직이는 이미지를 참고하여 이와 비슷하게 구현을 해보고자 하였습니다.
- `asset`에 `gif` 이미지를 `frame`별 `png`파일로 분리하여 저장하였습니다. 이를 `UIImage`에서 `animatedImage`를 활용하여 임의의 `duration`을 지정하여 자연스럽게 움직이는 형상을 보여줄 수 있도록 하였습니다.
- 현재 저희 프로젝트에서 로딩하는 이미지는 빠른 속도로 처리가 되기 때문에 저희가 구성한 `Image Loading`화면이 짧은 찰나에 깜빡이고 사라지는 형상을 띄게 되었습니다. 저희는 오히려 이렇게 짧은 로딩화면이 `user`에게 오류가 나는 형상처럼 보여질 수 있다 생각하였습니다. 하여 이미지가 로딩 중이라는 것을 `user`에게 명시하기 위해 `usleep(500000)`을 주어 `Image Loading`의 과정이 보다 저희의 의도와 맞게끔 조정하였습니다.

<br>

## ✏️ URLCache in Memory
- 저희는 프로젝트에 `NSCache`를 적용했지만, `URLCache`도 공부해 보았습니다.
- `URLCache`는 기본적으로 캐시 저장이 `ondisk`인 것을 확인했고, 이것을 변경하기 위해 `StoragePolicy`를 `allowedInMemoryOnly`로 지정해 보았습니다. 하지만 저희의 예상과 달리 `StoragePolicy`를 변경하였음에도 캐시 데이터가 `Memory`에 저장 되지 않았습니다.
- 아래와 같이 여러 실험 끝에 `(30 * 1024 * 1024)` 부터는 `URLCache`가 `메모리`에 저장이 되는 것을 확인할 수 있었습니다.
    ```
    ------------------------------------------------------------------------------
    URLCache.shared의 memoryCapacity: 512,000 bytes
                      diskCapacity: 10,000,000 bytes

    CachedURLResponse의 storagePolicy가 .allowedInMemoryOnly일 때,
    memoryCapacity: 10, 20 (* 1024 * 1024)일 때는 실패함. 30부터 성공. 31,457,280 bytes
    첫번째 data - 1,469,837 bytes
    두번째 data - 1,078,478 bytes
    ------------------------------------------------------------------------------
    ```
- 때문에 저희는 저장되어야하는 데이터 보다 지정 `memoryCapacity`가 클 때만 `URLCache`의 `inmemory Policy`가 적용된다고 추측했습니다.

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

<details>
<summary>🍎 Developer Apple</summary>

- [XCTFail](https://developer.apple.com/documentation/xctest/xctfail)
- [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Escaping Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Escaping-Closures)
- [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
- [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [Hashable](https://developer.apple.com/documentation/swift/hashable)
- [Sendable](https://developer.apple.com/documentation/swift/sendable)
- [Bundle](https://developer.apple.com/documentation/foundation/bundle)
- [NSCache](https://developer.apple.com/documentation/foundation/nscache)
- [URLCache](https://developer.apple.com/documentation/foundation/urlcache)
- [URLRequest.CachePolicy](https://developer.apple.com/documentation/foundation/urlrequest/cachepolicy)
- [URLCache.StoragePolicy](https://developer.apple.com/documentation/foundation/urlcache/storagepolicy)
- [UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
- [UICalendarView.Decoration](https://developer.apple.com/documentation/uikit/uicalendarview/decoration)
- [addTarget](https://developer.apple.com/documentation/uikit/uicontrol/1618259-addtarget)
- [addAction](https://developer.apple.com/documentation/uikit/uicontrol/3600490-addaction)
- [UIRefreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)

</details>    

<br>


<details>
<summary>📒 Blog</summary>

- [🌳 Cache](https://green1229.tistory.com/57)
- [🌳 NSCache vs URLCache](https://green1229.tistory.com/268)
- [이미지 캐시 처리와 NSCache](https://beenii.tistory.com/187)
- [URLSession Cahce Policy](https://inuplace.tistory.com/1232)
- [SwiftUI : @escaping](https://seons-dev.tistory.com/entry/SwiftUI-escaping)
- [XCTAssert Failure Messages](https://www.basbroek.nl/xctassert-asterisk)
- [예외처리 (throws, do-catch, try) 하기](https://twih1203.medium.com/swift-예외처리-throws-do-catch-try-하기-c0f320e61f62)
- [do-try-catch 유닛테스트 하기 위한 코드
](https://oingbong.tistory.com/213)
- [Xcode13 HTTP 통신 방법](https://jerry-bakery.tistory.com/entry/iOS-Xcode13에서-HTTP-통신-사용하는-방법Use-HTTPS-instead-or-add-Exception-Domains-to-your-apps-Infoplist)
- [DiffableDataSource](https://ios-development.tistory.com/717)
- [UIActivityIndicator](https://calmone.tistory.com/entry/iOS-UIKit-in-Swift-4-UIActivityIndicator-사용하기)
- [UIActivityIndicatorView](https://ios-development.tistory.com/985)
- [일치하는 모든 문자열의 Attribute를 바꾸고 싶을 때](https://zeddios.tistory.com/462)
- [github에 올리면 안되는 APIKEY 숨기기](https://nareunhagae.tistory.com/44)
- [Dynamic Type을 지원하되, weight는 커스텀하기](https://dev-dain.tistory.com/244)
- [달력 UICalendarView Custom 예제](https://ohwhatisthis.tistory.com/23)
    
</details>    

<br>


<details>
<summary>👾 Git</summary>

- [토요스터디ClassC - DasanKim](https://github.com/WhalesJin/FireSaturdayStudyClassC/blob/dasan/2_week6_cache/2_week6_cache/ViewController.swift)
- [달력 로딩 이미지 애니메이션 팝업 쉽게 만들기](http://minsone.github.io/mac/ios/easy-make-loading-animation-popup-view-in-swift)

</details>    

<br>


<details>
<summary>🌊 stack overflow</summary>
    
- [change size of UICalanderView Decofration](https://stackoverflow.com/questions/75470155/how-to-change-size-of-customview-passed-as-uicalanderview-decoration)
    
</details>    
