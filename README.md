# 🎬 Box Office

## 🍀 소개
> `idinaloq`와 `Mary`가 만든 박스오피스 입니다.

영화진흥위원회 API를 활용하여 일일 박스오피스 조회 및 영화 개별 상세 조회를 진행합니다.

* 주요 개념: `JSON Decoder`, `URLComponents`, `URLSession`, `Fetching Website Data into Memory`

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

<br>

## 👀 시각화된 프로젝트 구조

### Class Diagram
<p>
<img width="700" src="https://hackmd.io/_uploads/HkbufyWin.jpg">

</p>

<br>

### File Tree
```
.
├── BoxOffice
│   ├── Model
│   │   ├── APIConstants+.swift
│   │   ├── APIConstants.swift
│   │   ├── MovieService.swift
│   │   ├── ServiceType.swift
│   │   └── DataModel
│   │       ├── BoxOffice.swift
│   │       ├── BoxOfficeResult.swift
│   │       ├── DailyBoxOffice.swift
│   │       ├── DetailInformation.swift
│   │       ├── MovieInformation.swift
│   │       └── MovieInformationResult.swift
│   ├── View
│   │   └── Base.lproj
│   │       ├── LaunchScreen.storyboard
│   │       └── Main.storyboard
│   ├── Controller
│   │   ├── AppDelegate.swift
│   │   ├── SceneDelegate.swift
│   │   └── ViewController.swift
│   ├── Resource
│   │   └── Assets.xcassets
│   └── Info.plist
└── BoxOfficeTests
    └── BoxOfficeTests.swift
```

<br>

## 💻 실행 화면 
**8/4 추가 예정**

<!-- |실행 화면|
|:--:|
|<img src="https://hackmd.io/_uploads/Hyprjqwc2.gif" width="600">| -->

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
    ```swift
    func test_boxofficesample프로퍼티와_DailyBoxOffice프로퍼티가다르면_파싱에실패한다() { 
        let test = try? JSONDecoder().decode(BoxOffice.self, from: dataAsset)

        ...

        //then
        XCTAssertNil(test)
    }
    ```
    
<br>

## 🧨 트러블 슈팅
**8/4 추가 예정**

<br>

## 📚 참고 링크
- [🍎 Apple Docs: `JSONDecoder`](https://developer.apple.com/documentation/foundation/jsondecoder)
- [🍎 Apple Docs: `URLComponents`](https://developer.apple.com/documentation/foundation/urlcomponents)
- [🍎 Apple Docs: `URLSession`](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎 Apple Docs: `Fetching Website Data into Memory`](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🌐 Blog: iOS 서버통신 연결하기](https://vanillacreamdonut.tistory.com/254)

<br>
