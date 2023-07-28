# 박스오피스</br>
> 📌 영화진흥위위원회의 일별 박스오피스 API를 참고하여 "일별 박스오피스 데이터" Model 타입을 구현합니다.</br>
> 📌 구현한 "일별 박스오피스 데이터" Model 타입을 활용하여 제공된 JSON 타입으로 파싱합니다.</br>
> 📌 파싱한 "일별 박스오피스 데이터" 를 단위 테스트(Unit test)에도 활용해봅니다. </br>

## 📚 목차</br>
- [팀원소개](#-팀원-소개)
- [파일트리](#-파일트리)
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
├── BoxOffice
│   ├── Resource
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   ├── Contents.json
│   │   │   └── box_office_sample.dataset
│   │   │       ├── Contents.json
│   │   │       └── box_office_sample.json
│   │   └── SceneDelegate.swift
│   ├── Model
│   │   └── BoxOffice.swift
│   ├── View
│   │    └── Base.lproj
│   │        ├── LaunchScreen.storyboard
│   │        └── Main.storyboard
│   ├── Controller
│   │   └── ViewController.swift
│   ├── Info.plist
├── BoxOfficeTests
│   ├── BoxOfficeTestPlan.xctestplan
│   └── BoxOfficeTests.swift
└── README.md
```

## ⏰ 타임라인</br>
프로젝트 진행 기간 | 23.07.10.(월) ~ 23.07.14.(금)

| 날짜 | 진행 사항 |
| -------- | -------- |
| 23.07.25.(월)     |  BoxOffice 모델 객체 생성 및 구현. <br/> JSON 객체 추가 및 BoxOffice 모델 생성 및 구현. <br/> BoxOfficeModel에 코딩키 추가. <br/> BoxOffice Model Unit Test 생성 및 실행.<br/> refactor: MVC 패턴으로 폴더링.<br/> |
| 23.07.26.(화)     | 인덴트 수정.<br/>

## 📺 실행화면
- BoxOffice JSON 데이터 파싱 화면 🎬 </br>
<img src = "https://github.com/devKobe24/images/blob/main/boxOffice_1.gif?raw=true">

- BoxOffice 단위 테스트 성공 화면 🎬 </br>
<img src = "https://github.com/devKobe24/images/blob/main/boxOffice_test.gif?raw=true">

## 🔨 트러블 슈팅 
1️⃣ **유닛 테스트 시 `setUpWithError()`과 `tearDownWithError()`사용.** </br>
🔒 **문제점** </br>
굳이 프로퍼티 `sut`를 만들어 사용할 이유가 없어보여서 유닛 테스트를 시작할 때 `setUpWithError()`와 `tearDownWithError()` 메서드를 사용해야 할지 말지 고민이 많았습니다.


🔑 **해결방법** </br>
두 메서드는 삭제 후 테스트를 진행했습니다.

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


## 📑 참고자료
- [📃 URLSession](https://developer.apple.com/documentation/foundation/urlsession)</br>
- [📃 Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)</br>
- [📃 Human Interface Guidelines - Entering data](https://developer.apple.com/design/human-interface-guidelines/entering-data)
- [📃 UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
    - [🎦 Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
    - [🎦 Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
    - [📃 Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
