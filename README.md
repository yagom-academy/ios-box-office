# 박스오피스[STEP2]</br>
> 📌 네트워크 통신을 담당할 타입을 설계하고 구현합니다. </br>
> 📌 구현한 타입 형식을 고려하여 실제로 서버와 데이터를 주고 받습니다.</br>
> 📌 주고 받을 데이터는 다음과 같습니다</br>
> 📌 "오늘의 일일 박스 오피스" 데이터</br>
> 📌 "영화 개별 상세" 데이터</br>

## 📚 목차</br>
- [팀원소개](#-팀원-소개)
- [파일트리](#-파일트리)
- [시각화된 프로젝트 구조](#시각화된-프로젝트-구조)
- [타임라인](#-타임라인)
- [실행화면](#-실행화면)
- [트러블 슈팅](#-트러블-슈팅)
- [참고자료](#-참고자료)


## 🧑‍💻 팀원 소개</br>
| <img src="https://hackmd.io/_uploads/H11K3alon.png" width="200" height="200"/> | <img src="https://github.com/devKobe24/BranchTest/blob/main/IMG_5424.JPG?raw=true" width="200" height="200"/> |
| :-: | :-: |
| [**yyss99(와이)**](https://github.com/yy-ss99) | [**Kobe**](https://github.com/devKobe24) |

## 🗂️ 파일트리</br>
```
.
├── BoxOffice
│   ├── API_KEY.plist
│   ├── Info.plist
│   ├── Extension
│   │   └── Bundle+.swift
│   ├── Model
│   │   ├── BoxOffice.swift
│   │   ├── EndPoint.swift
│   │   ├── NetworkConfigurable.swift
│   │   ├── NetworkManager.swift
│   │   └── URLSession.swift
│   ├── View
│   │   └── Base.lproj
│   │       ├── LaunchScreen.storyboard
│   │       └── Main.storyboard
│   ├── Controller
│   │   └── ViewController.swift
│   ├── Error
│   │   ├── NetworkConfigurableError.swift
│   │   └── URLRequestError.swift
│   ├── Resource
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
├── BoxOffice.xcodeproj
└── BoxOfficeTests
    ├── BoxOfficeTestPlan.xctestplan
    └── BoxOfficeTests.swift
```

## 🗺️ 시각화된 프로젝트 구조</br>
<img src = "https://github.com/devKobe24/images/blob/main/UML_Box_Office.png?raw=true">

## ⏰ 타임라인</br>
프로젝트 진행 기간 | 23.07.10.(월) ~ 23.07.14.(금)

| 날짜 | 진행 사항 |
| -------- | -------- |
| 23.07.25.(월)     |  BoxOffice 모델 객체 생성 및 구현. <br/> JSON 객체 추가 및 BoxOffice 모델 생성 및 구현. <br/> BoxOfficeModel에 코딩키 추가. <br/> BoxOffice Model Unit Test 생성 및 실행.<br/> refactor: MVC 패턴으로 폴더링.<br/> |
| 23.07.26.(화)     | 인덴트 수정.<br/>
| 23.07.27.(수)     | NetworkManager 구현 및 MakeURLRequestError 오류 타입 구현.<br/>
| 23.08.01(화)     | NetworkConfigurable 프로토콜 구현 및 확장.<br/> NetworkConfigurable에 generateURL 메서드 추가.<br/> NetworkConfigurableError 타입 구현.<br/> App Transport Security Settings Key를 추가. <br/> API_KEY gitignore 추가.<br/> Bundle 확장 및 내부 구현. <br/> BoxOffice 데이터 출력을 위한 함수 구현.


## 📺 실행화면
- BoxOffice 네트워크 통신 결과 화면 🎬 </br>
<img src = "https://github.com/devKobe24/images/blob/main/BoxOffice_step2.gif?raw=true">

## 🔨 트러블 슈팅 
### 1️⃣ **유닛 테스트 시 `setUpWithError()`과 `tearDownWithError()`사용.** </br>
### 🔒 **문제점** 🔒</br>
굳이 프로퍼티 `sut`를 만들어 사용할 이유가 없어보여서 유닛 테스트를 시작할 때 `setUpWithError()`와 `tearDownWithError()` 메서드를 사용해야 할지 말지 고민이 많았습니다.


### 🔑 **해결방법** 🔑</br>
두 메서드는 삭제 후 테스트를 진행했습니다.

<details> 
<summary> 코드 </summary>

```swift!
import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    func test_BoxOffice_객체가_성공적으로_파싱될_경우_nil을_반환하지_않는다() {
        // given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        
        // when
        let result = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        
        // than
        XCTAssertNotNil(result)
    }
    
    func test_BoxOffice_객체가_성공적으로_파싱될_경우_boxOfficeType의_Value값을_반환한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        let expection = "일별 박스오피스"
        
        // when
        let boxOffice = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let result = boxOffice.boxOfficeResult.boxOfficeType
        
        // then
        XCTAssertEqual(expection, result)
    }
    
    func test_BoxOffice_객체가_성공적으로_파싱될_경우_dailyBoxOfficeList_0번째_요소인_movieName의_Value값을_반환한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        let expection = "경관의 피"
        
        // when
        let boxOffice = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let result = boxOffice.boxOfficeResult.dailyBoxOfficeList[0].movieName
        
        // then
        XCTAssertEqual(result, expection)
    }
}
```
</details>
<br>

### 2️⃣ **`API Key`를 `Github`에서 안보이도록 숨기는 방법**
### 🔒 **문제점** 🔒</br>
`github`은 개인적이거나 조직 내부적인 비공개 프로젝트뿐만 아니라 공개적으로 접근 가능한 오픈 소스 코드 저장소도 제공합니다. 
따라서 `API key`와 같이 민감한 정보는 `github` 레포지토리에 공개적으로 올리는 것은 적절하지 않다고 판단했습니다.


### 🔑 **해결방법** 🔑</br>

  `.gitignore`에 `Infoplist`를 추가하는 방법을 선택하여서 사용하였습니다.

## 📑 참고자료
- [📃 Bundle](https://developer.apple.com/documentation/foundation/bundle)
- [📃 URLSession](https://developer.apple.com/documentation/foundation/urlsession)</br>
- [📃 Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)</br>
- [📃 Human Interface Guidelines - Entering data](https://developer.apple.com/design/human-interface-guidelines/entering-data)
- [📃 UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
    - [🎦 Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
    - [🎦 Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
    - [📃 Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
