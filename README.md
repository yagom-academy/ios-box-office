# 🎬 박스오피스 _ 웰다비🍿🥤

## 📖 목차
🍀 [소개](#소개) </br>
👨‍💻 [팀원](#팀원) </br>
⏱️ [타임라인](#타임라인) </br>
👀 [시각화된 프로젝트 구조](#시각화된_프로젝트_구조) </br>
💻 [실행 화면](#실행_화면) </br>
⛑️ [핵심 경험](#핵심_경험) </br>
🧨 [트러블 슈팅](#트러블_슈팅) </br>
📚 [참고 링크](#참고_링크) </br>

</br>

## 🍀 소개<a id="소개"></a>
`Whales`과 `Dasan`이 만든 박스오피스입니다.
영화진흥위원회의 Open API를 이용하여 일별 박스오피스 정보와 영화 상세 정보를 가져옵니다.

</br>

## 👨‍💻 팀원<a id="팀원"></a>
| 🐬Whales🐬 | 🌳Dasan🌳 |
| :--------: | :--------: |
| <Img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/e4e33a5d-f56c-4a3d-80b5-484ab3c62f27" width="200"> | <Img src = "https://user-images.githubusercontent.com/106504779/253477235-ca103b42-8938-447f-9381-29d0bcf55cac.jpeg" width="200"> |
|[Github Profile](https://github.com/WhalesJin) |[Github Profile](https://github.com/DasanKim) |

</br>

## ⏱️ 타임라인<a id="타임라인"></a>
|날짜|내용|
|:--:|--|
|2023.07.24(월)| - [영화진흥위원회의 일별 박스오피스 API 문서](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice)의 데이터 형식을 고려한 모델 타입 설계 |
|2023.07.25(화)| - `BoxOffic`, `BoxOfficeData`, `DailyBoxOfficeResult` 타입 생성 <br> - `DecodingManager`, `DataError` 타입 생성 및 구현 <br> - `DecodingManager`에 대한 Unit Test 진행 <br> - 파일 그룹화|
|2023.07.26(수)| - **Test Plan Reference** 오류 수정 <br> - [URLSession](https://developer.apple.com/documentation/foundation/urlsession) 공부 |
|2023.07.27(목)| - `Movie`, `MovieInformationResult`, `MovieInformation` 타입 생성 <br> - 각각의 관련 타입들 `BoxOffice`, `Movie` 파일로 **병합** <br> - `NetworkManager` 타입 생성 및 구현|
|2023.07.28(금)| - `Movie` 타입 오류 수정 <br> - `fetchData`매서드에 `completionHandler` 추가 <br> - README 작성|
|2023.07.31(월)| - 네트워크 관련 에러 `Result` 타입으로 수정 <br> -`Utility`, `Error` 그룹 생성 및 그룹화 <br> - 피드백 반영| 
|2023.08.01(화)| - plist를 활용하여 github에서 API key값이 보이지 않도록 수정 <br> - `Resource` 그룹 생성 및 그룹화|
|2023.08.02(수)| - `os log` 메서드 활용 및 전체적인 리펙토링 |
|2023.08.03(목)| - [Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/), [Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026) 공부 <br> - 첫번째 페이지 UI 설계 |
|2023.08.04(금)| - README 작성 <br> - 개발 타겟 버전 `iOS 14` 이상으로 수정 <br> - `Modern Collection View`를 활용한 UI 구현|
|2023.08.07(월)| - `TargetDate` 타입 생성 <br> - `UIActivityIndicatorView`, `RefreshControl`를 활용한 로딩 화면 구현 <br> - `BoxOfficeManager` 타입 생성|
|2023.08.08(화)| - `Dynamic Type` 적용 <br> - `ConstraintsNamespace` 추가 및 적용 <br> - 전체적인 리펙토링 |
|2023.08.09(수)| - `Kakao REST API` 타입 설계 |
|2023.08.10(목)| - 영화 상세 페이지 UI 설계 |
|2023.08.11(금)| - 피드백 반영 및 수정 <br> - README 작성 |

</br>

## 👀 시각화된 프로젝트 구조<a id="시각화된_프로젝트_구조"></a>

### ℹ️ File Tree
    ┌── BoxOffice
    │   ├── BoxOffice
    │   │   ├── Application
    │   │   │   ├── AppDelegate
    │   │   │   └── SceneDelegate
    │   │   ├── Utility
    │   │   │   ├── DecodingManager
    │   │   │   ├── NetworkManager
    │   │   │   ├── URL+
    │   │   │   ├── TargetDate
    │   │   │   └── CountFormatter
    │   │   ├── Model
    │   │   │   ├── BoxOffice
    │   │   │   ├── Movie
    │   │   │   ├── URLConfigurable
    │   │   │   ├── KobisOpenAPI
    │   │   │   ├── Bundle+
    │   │   │   └── BoxOfficeManager
    │   │   ├── View
    │   │   │   ├── Main
    │   │   │   ├── LaunchScreen
    │   │   │   └── BoxOfficeCell
    │   │   ├── Controller
    │   │   │   └── BoxOfficeViewController
    │   │   ├── Namespace
    │   │   │   └── ConstraintsNamespace
    │   │   ├── Error
    │   │   │   ├── DataError
    │   │   │   └── NetworkError
    │   │   ├── Resource
    │   │   │   ├── Assets
    │   │   │   ├── Info
    │   │   │   └── KobisAPIKey
    │   └── BoxOfficeTests
    │       └── DecodingManagerTests
    │           └── DecodingManagerTests
    └── README
</br>

### 📐 Diagram

- Model<br>
    <img width = "450" src = "https://hackmd.io/_uploads/SkjAuGcon.png"> <br>

- View & Controller<br>
    <img width = "700" src = "https://hackmd.io/_uploads/SJ02gv7nn.png"> <br>

- <details> 
      <summary> View & Utility </summary>
  <img width = "250" src = "https://hackmd.io/_uploads/BygtbwQh3.png">
  </details>

- <details> 
      <summary> Controller & Utility </summary>
  <img width = "700" src = "https://hackmd.io/_uploads/H1dEWwXhn.png">
  </details>

- <details> 
      <summary> Model - DTO </summary>
  <img width = "550" src = "https://hackmd.io/_uploads/SkPRdzqo2.png">
  </details>

- <details> 
      <summary> Error & Utility </summary>
  <img width = "450" src = "https://hackmd.io/_uploads/HJy0uG9j2.png">
  </details>

</br>

## 💻 실행 화면<a id="실행_화면"></a>


| 앱 시작시 로딩 | 12시 새로고침(날짜변경) |
| :--------: | :--------: |
| <img src = "https://hackmd.io/_uploads/HyffIP73h.gif" width = "250"> | <img src = "https://hackmd.io/_uploads/B1TbrPXh3.gif" width = "250"> |

</br>


## ⛑️ 핵심 경험<a id="핵심_경험"></a>

### Unit Test의 XCTAssertThrowsError
- `DecodingManager` 타입의 decodeJSON`메서드`를 테스트하여, **decoding 및 parsing**이 잘 이루어지고 있는지를 확인하고 싶었습니다.
- Tests 내에서 `XCTAssertThrowsError`, `XCTAssertNoThrow` 메서드를 사용하여 상황에 맞게 오류를 잘 던지고 있는지 확인하였습니다.
 
<details>
    <summary> 코드 </summary>
    
```swift
//DecodingManagerTests.swfit

func test_일치하는_dataAsset이없을때_notFoundAsset에러를_던진다() {
    //given
    let fileName = "없는파일이름"

    //when, then
    XCTAssertThrowsError(try sut.decodeJSON(fileName: fileName) as BoxOffice) { error in
        XCTAssertEqual(error as! DataError, DataError.notFoundAsset)
    }
}
    
func test_일치하는_dataAsset가있을때_notFoundAsset에러를_던지지않는다() {
    //given
    let fileName = "box_office_sample"

    //when, then
    XCTAssertNoThrow(try sut.decodeJSON(fileName: fileName) as BoxOffice)
}
```
</details>

### Modern Collection Veiw 활용
- Modern Collection View를 활용하여 `list Layout`을 쉽게 구현할 수 있었습니다.
- 또한 `NSDiffableDataSourceSnapshot` 및 `UICollectionViewDiffableDataSource`를 활용하여 collection View 내의 Data를 업데이트하였습니다.

<details>
    <summary> 코드 </summary>
    
```swift
// BoxOfficeViewController.swfit

extension BoxOfficeViewController {
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)

        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

    (...)

    private func configureDataSource() {
        (...)
        dataSource = UICollectionViewDiffableDataSource <Section, BoxOfficeData>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeData) -> UICollectionViewListCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeData >()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    (...)
}
```
</details>

<br>

## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>

### 1️⃣ Test Plan Reference 오류
`DecodingManager` 타입에 대한 Unit Test을 진행하였습니다. 후에 추후 추가될 Test들을 생각하여 `BoxOfficeTests`라는 상위 폴더를 생성하고, `DecodingManagerTests` 폴더 및 `BoxOffice.xctestplan` 파일을 `BoxOfficeTests` 폴더에 넣어주었습니다.

    └── BoxOfficeTests
        ├── BoxOffice.xctestplan
        └── DecodingManagerTests
            └── DecodingManagerTests.swift

🚨 **문제점** <br>

- 폴더 및 파일들을 `BoxOfficeTests`로 이동한 후부터, 아래와 같은 메시지창이 뜨며 Unit Test가 실행되지 않았습니다.
   - error 메시지
   <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/124643545/256756273-ba5fd051-9faa-44dd-a94d-c553a6f1f220.png" width="400">

   - missing된 DecodingManagerTests
   <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/124643545/256756316-e934d064-053f-41d3-9ce4-8de7fd238d7b.png" width="400">

- 위와 같은 문제가 생긴 이유는 `Test Plan`의 위치를 옮길 때 `BoxOffice` 타겟에 대한 `Test Plan reference` 경로가 변경되었기 때문이었습니다.

   <img src = "https://github-production-user-asset-6210df.s3.amazonaws.com/124643545/256756329-6f5c135a-60e7-4b0a-82c8-fed4ee89c675.png" width = "700">

💡 **해결방법** <br>
- 이 문제를 해결할 수 있는 방법에는 2가지가 있었습니다:
    1. Test Plan의 `configurations` 설정
        - Test Plan > configurations > Target for Variable Expansion
        - Target for Variable Expansion 값을 none으로 바꾸었다가 다시 App으로 변경
    2. 기존 Test Plan 삭제 후 `새롭게 추가`
        - Product > Scheme > Edit scheme > Test
        - Test Plans에 있는 기존 BoxOffice Test Plan을 삭제하고, 다시 add
    
        <img src = "https://hackmd.io/_uploads/SkvTsgRqh.png" width = "500">

- 저희는 첫번째 방법으로는 해결이 되지 않아, 두번째 방법으로 해결하였습니다.

<br>

### 2️⃣ API Key 숨기기 
🚨 **문제점** <br>
- 처음엔 `API key` 값을 아래와 같이 `KobisOpenAPI` 내 key 프로퍼티에 넣어주었습니다.
- `private` 접근제어를 통하여 코드적으로는 외부에서 프로퍼티에 접근하지 못하도록해주었지만, git에 올렸을 때 key값이 **그대로 노출되는 문제**가 발생되었습니다.

```swift
// KobisOpenAPI.swift
enum KobisOpenAPI {
    case boxOffice(String)
    case movie(String)
}

extension KobisOpenAPI: API {
    (...)
    private var key: String {
        return "fb92260b76d9959bbf3ab69c991d8985"
    }
    (...)
}
```

💡 **해결방법** <br>
- API Key를 아래와 같은 방법으로 숨겼습니다.

    1. 새로운 `plist`를 만들어 KOBIS_API_KEY라는 이름의 `Key`와 KOBIS API KEY VALUE의 `Value`를 생성후, push 해주었습니다.
    2. 후에 **더이상 새로운 `plist`파일을 추적하지 못하도록** `.gitignore` 파일 내에 새로운 plist path를 추가해준 뒤 push 해주었습니다.
    3. 더 이상 추적하지 못하도록 한 뒤, `KOBIS API KEY VALUE`로 적혀있던 Value에 `실제 API Key`를 넣어주었습니다.
    ![](https://hackmd.io/_uploads/S1qX7Xqjh.png)
<br>

### 3️⃣ 역할 분리
🚨 **문제점** <br>
- 프로젝트를 진행하면서 아래와 같이 `ViewController`가 비대해졌고, 이는 `ViewController`가 많은 책임을 가지게 하였습니다.(또한 본래의 책임과는 동떨어진 기능들도 가지고 있었습니다.)

    <details>
        <summary> 코드 </summary>
    
    ```swift
    // BoxOfficeViewController.swift
    class BoxOfficeViewController: UIViewController {
        (...)

        override func viewDidLoad(){
            let networkManager = NetworkManager()

            networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: targetDate.formatNoSeparator()).url) { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                        print(decodedData)

                        let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList

                        boxOfficeItems.forEach { item in
                            self.items.append(item)
                        }

                        (...)
                        self.dataSource.apply(snapshot, animatingDifferences: true)
                        self.stopActivityIndicator()
                    } catch DataError.notFoundAsset {
                        os_log("%{public}@", type: .default, DataError.notFoundAsset.localizedDescription)
                    } catch DataError.failedDecoding {
                        os_log("%{public}@", type: .default, DataError.failedDecoding.localizedDescription)
                    } catch {
                        os_log("알 수 없는 오류입니다.", type: .default)
                    }
                case .failure(let error):
                    os_log("%{public}@", type: .default, error.localizedDescription)
                }
            }
        }
        (...)
    }
    ```
    </details>
    
</br>

💡 **해결방법** <br>

- `ViewController`가 본래의 책임만을 다할 수 있도록 `BoxOfficeManager`라는 타입을 만들었습니다.
    > 본래 `ViewController`의 주요 책임
    > - 일반적으로 기초 데이터의 변경에 대한 응답으로 `뷰의 콘텐츠를 업데이트`
    > - 뷰에 대한 `사용자 상호 작용에 응답`
    > - 뷰 `크기 조정` 및 전체 인터페이스의 `레이아웃 관리`
    > - 앱에서 다른 객체(다른 뷰 컨트롤러 포함)와 조정

- 더불어 각 Manager들이 하나의 책임만 갖도록 하였습니다.
  - **NetworkManager**: `API`를 통해 요청한 `Data`를 가져옵니다.
  - **DecodingManager**: `Data`를 `Swift`에서 사용할 수 있는 특정 데이터 타입으로 `Decodeing`합니다.
  - **BoxOfficeManager**: BoxOffice 관련 데이터 타입으로 디코딩된 `Data`를 `Result` 타입으로 반환합니다.
  - **ViewController**: `API`와의 통신 및 `Decoding` 과정을 몰라도 되며, `BoxOfficeManager`를 통해 받은 `Data`를 가지고 `View`에 전달하는 역할에 집중할 수 있도록 하였습니다.

   <details>
        <summary> 코드 </summary>

    ```swift
    // BoxOfficeManager.swift
    final class BoxOfficeManager {
        (...)
        func fetchBoxOfficeData(completionHandler: @escaping (Result[BoxOfficeData]?, Error) -> Void) {
            let networkManager = NetworkManager()

            networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: targetDate.formatNoSeparator()).url) { (data, error) in
                do {
                    if let error = error {
                        completionHandler(.failure(error))

                        return
                    }

                    if let data = data {
                        let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                        let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList
                        completionHandler(.success(boxOfficeItems))
                    }
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    ```
    ``` swift
    // BoxOfficeViewController.swift
    extension BoxOfficeViewController {
        private func loadData() {
            let boxOfficeManager = BoxOfficeManager(targetDate: yesterday)

            boxOfficeManager.fetchBoxOfficeData { result in
                switch result {
                case .success(let items):
                    guard let items = items else { return }
                    self.items = items
                    self.applySnapshot()
                    self.stopActivityIndicator()
                case .failure(let error):
                    os_log("%{public}@", type: .default, error.localizedDescription)
                }
            }
        }
    ```
   </details>

<br>

### 4️⃣ 셀 재사용으로 인한 문제
🚨 **문제점** <br>
- 새로고침 시 `rankIntensityLabel`의 `text` 색상이 바뀌는 문제가 있었습니다.<br>

  <img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/04a41bb7-cde0-4203-a56c-6e5219280fed" height = "500">

</br>

💡 **해결방법** <br>
- 셀이 **재사용**이 되면서 발생하는 문제임을 알고, `prepareForReuse` 매서드에서 `rankIntensityLabel`의 `text` 색상을 초기화해주었습니다.

    ```swift
    // BoxOfficeCell.swift
    override func prepareForReuse() {
        super.prepareForReuse()
        rankIntensityLabel.textColor = .black
    }
    ```
<br>

## 📚 참고 링크<a id="참고_링크"></a>

- [🍎Apple Docs: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎Apple Docs: Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎Apple Docs: Swift Closures - Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [🍎Apple Docs: UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎Apple Docs: XCTAssertThrowsError](https://developer.apple.com/documentation/xctest/1500795-xctassertthrowserror)
- [🍏WWDC: Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [🍎Apple Docs: Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [🍎Apple Docs: CollectionView Layout](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts)
- [🍎Apple Docs: prepareforreuse](https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620141-prepareforreuse)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Alamofire](https://github.com/Alamofire/Alamofire/blob/master/Source/Alamofire.swift)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Moya](https://github.com/Moya/Moya/tree/master/Sources/Moya)
- <Img src = "https://github.com/mint3382/ios-calculator-app/assets/124643545/56986ab4-dc23-4e29-bdda-f00ec1db809b" width="20"/> [야곰닷넷: Test Double](https://yagom.net/courses/unit-test-작성하기/lessons/테스트를-위한-객체-만들기/topic/테스트를-위한-객체를-이용해서-테스트-작성하기/)
- <Img src = "https://hackmd.io/_uploads/ByTEsGUv3.png" width="20"/> [blog: URL 처리 방법](https://ios-development.tistory.com/1014)

<br>
