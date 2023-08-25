# 🎬 박스오피스 _ 웰다비🍿🥤

- 프로젝트 기간: [2023년 7월 24일 ~ 8월 23일](https://github.com/WhalesJin/ios-box-office/wiki/타임라인)
- 프로젝트 팀원: [Whales🐬](https://github.com/WhalesJin), [Dasan🌳](https://github.com/DasanKim)
- 프로젝트 리뷰어: [vivi🦜](https://github.com/YebinKim)


## 📖 목차
🍀 [소개](#소개) </br>
💻 [실행 화면](#실행_화면) </br>
🛠️ [사용 기술](#사용_기술) </br>
👀 [다이어그램](#Diagram) </br>
🧨 [트러블 슈팅](#트러블_슈팅) </br>
📚 [참고 링크](#참고_링크) </br>
👩‍👧‍👧 [about TEAM](#about_TEAM) </br>

</br>

## 🍀 소개<a id="소개"></a>
- [영화진흥위원회에서 제공하는 영화 API](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice)를 사용하여 일별 박스오피스 순위와 영화 상세 정보를 볼 수 있는 앱입니다.
- 박스오피스 화면은 `화면 모드 변경` 버튼을 이용하여 리스트/아이콘 두 가지 화면으로 볼 수 있습니다.

</br>

## 💻 실행 화면<a id="실행_화면"></a>

| 앱 시작시 로딩 | 12시 새로고침(날짜변경) |
| :--------: | :--------: |
| <img src = "https://hackmd.io/_uploads/HyffIP73h.gif" width = "200"> | <img src = "https://hackmd.io/_uploads/B1TbrPXh3.gif"  width = "200"> |

| 화면모드 변경 | List-상세정보 | Grid-상세정보 |
| :--------: | :--------: | :--------: |
| <img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/b3cd38d5-9b1b-40d6-87a0-d75084c6961a" width = "200"> | <img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/9b72dc37-c9ba-4c17-95ed-307efcf64efb" width = "200"> | <img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/1d4c9957-ae63-48fb-a61d-eae89d39ddae" width = "200"> |

</br>

## 🛠️ 사용 기술<a id="사용_기술"></a>
| 구현 내용	| 도구 |
|:---:|:---:|
|아키텍쳐|MVC|
|UI|UIKit|
|동시성 프로그래밍|GCD|
|네트워크|URLSession|
|리스트 표시|Modern Collection Veiw|

</br>

## 👀 Diagram<a id="Diagram"></a>
### 📐 UML
<img src = "https://github.com/WhalesJin/ios-box-office/assets/106504779/523e302d-87dc-4d5e-827a-c3d25586d40b" width = "800">

</br>
</br>
<details>
    <summary> Model </summary>

<img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/2d3d0e01-a30b-4574-bd2d-80474f210731" width = "400">
</details>

<details>
    <summary> View </summary>

<img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/09a678c8-ef3e-44af-8621-1444d188bdd0" width = "800">
</details>

<details>
    <summary> Controller </summary>

<img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/a34044e3-f825-413d-93be-51662d4a882b" width = "800">
</details>

</br>

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
    
<br>

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

### 5️⃣ 스크롤 뷰 내 오토레이아웃
🚨 **문제점** <br>
- 아래와 같이 코드로 **스크롤 뷰**와 스크롤 뷰의 `content 뷰` 역할을 하는 **스택 뷰**의 오토레이아웃을 설정하여 주었습니다. 실행되는 화면에서는 특별한 문제가 없었는 듯하였으나, debug view hierarchy에서 아래와 같은 오류 메시지를 확인할 수 있었습니다.

  - **코드**
    ```swift 
    // MovieScrollView.swift
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieStackView)
        movieStackView.addArrangedSubview(movieImageView)

        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            movieStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ...
        ])
        ...
    }
    ```
  - **debug view hierarchy**의 오류 메시지 </br>
    <img src ="https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/00c59b68-af27-4c68-8135-36188aedb223" width = "500">

💡 **해결방법** <br>
- [Working with Scroll Views](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1)에서 스크롤 뷰의 레이아웃은 `content 뷰`의 크기를 **`완전히`** 정의해야한다고 말해주고 있습니다.
   > to set the width, you must have an unbroken chain of constraints and views from the content view’s leading edge to its trailing edge.
- `content 뷰`인 `movieStackView`의 크기가 완전히 정의되지 않아 생긴 오류이므로, `movieStackView`의 centerX 대신 `leading`, `trailing` edge를 스크롤 뷰의 edge에 고정시켜주었더니 해당 오류 메시지가 사라졌습니다.
- `widthAnchor`는 스크롤 뷰의 가로 스크롤을 막기 위한 constraint입니다.
    ```swift 
    // MovieScrollView.swift
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieStackView)
        movieStackView.addArrangedSubview(movieImageView)

        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ...
        ])
        ...
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

## 👩‍👧‍👧 about TEAM<a id="about_TEAM"></a>

| <Img src = "https://github.com/WhalesJin/FireSaturdayStudyClassC/assets/124643545/e4e33a5d-f56c-4a3d-80b5-484ab3c62f27" width="100"> | 🐬Whales🐬  | https://github.com/WhalesJin |
| -------- | -------- | -------- |
| <Img src = "https://user-images.githubusercontent.com/106504779/253477235-ca103b42-8938-447f-9381-29d0bcf55cac.jpeg" width="100"> | **🌳Dasan🌳** | **https://github.com/DasanKim** |


- [타임라인](https://github.com/WhalesJin/ios-box-office/wiki/타임라인)
- [팀 회고](https://github.com/WhalesJin/ios-box-office/wiki/팀-회고)
