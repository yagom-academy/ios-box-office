# 🎥 박스오피스🍿


## 📖 목차

1. [소개](#소개)
2. [팀원](#팀원)
3. [타임라인](#타임라인)
4. [UML & 파일트리](#UML&파일트리)
5. [실행 화면](#실행-화면)
6. [트러블 슈팅](#트러블-슈팅)
7. [팀 회고](#팀-회고)
8. [참고 링크](#참고-링크)

<br>

<a id="소개"></a>

## 1. 📢 소개

`오늘의 일일 박스오피스`가 궁금하신가요?
혹은 `영화 개별 상세 조회`를 원하시나요?
저희에게 물어보세요!

 **핵심 개념**
> 오픈 API / URLSession / JSON Decoding / CodingKeys / UNIT Test

 **핵심 경험**
> 영화진흥위위원회 오픈 API를 참고하여 `오늘의 일일 박스오피스 데이터`와  `영화 개별 상세 데이터` Model를 구현
> Model을 활용하여 URLSession을 생성하여 JSON 파일을 Fetch
> JSON 파일 Decode에 대한 UNIT Test 작성

<br>

<a id="팀원"></a>

## 2. 👤 팀원

| [Serena 🐷](https://github.com/serena0720) | [BMO 🤖](https://github.com/bubblecocoa) |
| :--------: | :--------: | 
| <Img src = "https://i.imgur.com/q0XdY1F.jpg" width="350"/>| <img width="350px" src="https://avatars.githubusercontent.com/u/67216784?v=4">|

<br>

<a id="타임라인"></a>
## 3. ⏱️ 타임라인

> 프로젝트 기간 :  2023-07-24 ~ 2023-08-04

|날짜|내용|
|:---:|---|
| **2023.07.24** |▫️  <br> ▫️ |
| **2023.07.25** |▫️  <br> ▫️ |
| **2023.07.26** |▫️  <br> ▫️ |
| **2023.07.27** |▫️  <br> ▫️ |
| **2023.07.28** |▫️  <br> ▫️ |


<br>

<a id="UML&파일트리"></a>
## 4. 📊 UML & 파일트리

### UML
> 추후 업로드 예정

### 파일트리
```
📦BoxOffice
┗ 📄Info.plist
 ┣ 📂App
 ┃ ┣ 📄AppDelegate.swift
 ┃ ┗ 📄SceneDelegate.swift
 ┣ 📂ViewController
 ┃ ┗ 📄ViewController.swift
 ┣ 📂Model
 ┃ ┗ 📄NetworkManager.swift
 ┣ 📂DTO
 ┃ ┣ 📂BoxOffice
 ┃ ┃ ┣ 📄BoxOffice.swift
 ┃ ┃ ┣ 📄BoxOfficeResult.swift
 ┃ ┃ ┗ 📄DailyBoxOffice.swift
 ┃ ┗ 📂Movie
 ┃ ┃ ┣ 📄Audit.swift
 ┃ ┃ ┣ 📄Company.swift
 ┃ ┃ ┣ 📄Genre.swift
 ┃ ┃ ┣ 📄Movie.swift
 ┃ ┃ ┣ 📄MovieInfo.swift
 ┃ ┃ ┣ 📄MovieInfoResult.swift
 ┃ ┃ ┣ 📄Nation.swift
 ┃ ┃ ┣ 📄People.swift
 ┃ ┃ ┗ 📄ShowType.swift
 ┣ 📂NameSpace
 ┃ ┣ 📄CustomDateFormatStyle.swift
 ┃ ┣ 📄KobisNameSpace.swift
 ┃ ┗ 📄MimeType.swift
 ┣ 📂Extension
 ┃ ┗ 📄JSONDecoder+.swift
 ┣ 📂Error
 ┃ ┗ 📄JSONDecoderError.swift
 ┣ 📂Resource
 ┃ ┗ 📂Assets.xcassets
 ┃ ┃ ┗ 📂box_office_sample.dataset
 ┃ ┃   ┣ 📄Contents.json
 ┃ ┃   ┗ 📄box_office_sample.json
 ┣ 📄LaunchScreen.storyboard
 ┗ 📄Main.storyboard  
 
```


<br>

<a id="실행-화면"></a>
## 5. 📲 실행 화면
> 추후 업로드 예정
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
- UNIT Test에서 JSON 파일 Decode에 대한 테스트를 진행 시 do-catch문을 활용하였습니다. 이때 테스트가 실패했을 때 XCTTest 메서드를 `retrun`만 하게 되면 테스트가 `Success`처리 되는것을 확인했습니다. 
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

<a id="팀-회고"></a> 
## 7. 💭 팀 회고

<details>
<summary>팀 회고</summary>

### 우리팀이 잘한 점😃
> 추후 작성 예정
    
### 우리팀이 아쉬웠던 점😭
> 추후 작성 예정
    
</details>

<br>

<a id="참고-링크"></a>
## 8. 🔗 참고 링크
- [🍎 Developer Apple - XCTFail](https://developer.apple.com/documentation/xctest/xctfail)
- [🍎 Developer Apple - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎 Developer Apple - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎 Developer Apple - Escaping Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Escaping-Closures)
- [📒 Blog: SwiftUI : @escaping](https://seons-dev.tistory.com/entry/SwiftUI-escaping)
- [📒 Blog: XCTAssert Failure Messages](https://www.basbroek.nl/xctassert-asterisk)
- [📒 Blog: [Swift] 예외처리 (throws, do-catch, try) 하기](https://twih1203.medium.com/swift-예외처리-throws-do-catch-try-하기-c0f320e61f62)
- [📒 Blog: do-try-catch 유닛테스트 하기 위한 코드
](https://oingbong.tistory.com/213)
- [📒 Blog: Xcode13 HTTP 통신 방법](https://jerry-bakery.tistory.com/entry/iOS-Xcode13에서-HTTP-통신-사용하는-방법Use-HTTPS-instead-or-add-Exception-Domains-to-your-apps-Infoplist)
