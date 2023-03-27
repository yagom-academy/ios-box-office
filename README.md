# 박스 오피스 🎥

> 소개: 영화진흥위원회의 API를 사용하여 데이터들을 표시하는 어플

</br>

## 목차
1. [팀원](#1-팀원)
2. [타임라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행-화면)
5. [트러블슈팅](#5-트러블-슈팅)
6. [참고링크](#6-참고-링크)

<br>

## 1. 팀원

|[vetto](https://github.com/gzzjk159) | [Brody](https://github.com/seunghyunCheon)|
| :--------: | :--------: |
|<img height="180px" width="180" src="https://cdn.discordapp.com/attachments/535779947118329866/1055718870951940146/1671110054020-0.jpg"> | <img height="180px" width="200" src="https://i.imgur.com/fPPz155.jpg">|


<br>

## 2. 타임라인
### 프로젝트 진행 기간
**23.03.20 (월) ~ 23.03.31 (금)** 

| 날짜 | 타임라인 |
| --- | --- |
|23.03.20 (월)| BoxOffice, DailyBoxOffice모델 구현, BoxOfficeJsonDecoder 구현 및 테스트케이스 작성 |
|23.03.21 (화)| NetworkManager, BoxOfficeAPI, MovieInformation, MovieDetail Infomation모델 구현 및 Mock객체를 이용한 테스트 케이스 작성 |
|23.03.22 (수)| Modern Collection View 학습 |
|23.03.23 (목)| Modern Cell API(ContentConfiguration) 학습|
|23.03.24 (금)| URL 만드는 기능에 Http method 추가|

<br>

## 3. 프로젝트 구조

<details>
    <summary><big>폴더 구조</big></big></summary>

### BoxOffice
```swift
BoxOffice
├── BoxOffice
│   ├── Application
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Error
│   │   ├── DataAssetError.swift
│   │   └── NetworkError.swift
│   ├── Info.plist
│   ├── Model
│   │   ├── BoxOffice.swift
│   │   ├── BoxOfficeAPI.swift
│   │   ├── BoxOfficeJsonDecoder.swift
│   │   ├── DailyBoxOffice.swift
│   │   ├── MovieDetailInformation.swift
│   │   └── MovieInformation.swift
│   ├── Network
│   │   ├── NetworkManager.swift
│   │   ├── URLSessionDataTaskProtocol.swift
│   │   └── URLSessionProtocol.swift
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   └── LaunchScreen.storyboard
│   ├── View
│   │   └── Main.storyboard
│   └── ViewController
│       └── BoxOfficeViewController.swift
├── BoxOfficeJsonDecoderTests
│   └── BoxOfficeJsonDecoderTests.swift
└── NetworkManagerTests
    ├── JsonLoader.swift
    ├── MockURLSession.swift
    ├── MockURLSessionDataTask.swift
    └── NetworkManagerTests.swift
```

</details>

</br>

<details>
    <summary><big>UML</big></big></summary>
    
STEP3이후 추가하겠습니다!

</details>

</br>


## 4. 실행 화면
STEP3이후 추가하겠습니다!




</br>

## 5. 트러블 슈팅

### 1️⃣ parsing한 데이터 유닛테스트
json의 담긴 데이터를 가져오기 위해 jsonDecoder를 사용하여 데이터를 파싱하였습니다. 정확한 비교를 하기 위해서는 예상한 데이터들과 파싱한 데이터들을 하나하나 비교해야하는데 그렇게 하는 것은 데이터의 양이 너무 많아 테스트 하는 코드가 기존의 코드보다 길어진다는 것과 코드가 길어지면서 휴먼에러가 발생한다는 문제가 발생하였습니다.

이것을 정확히 해결하는 방법은 아니지만 일부의 데이터를 비교했을 때 데이터들이 일치한다고 하면 파싱한 데이터가 전부 일치한다고 생각하여 일부만 비교하여 일치하는지 확인하는 테스트를 진행하였습니다.

```swift
    // given
        let assetName = "box_office_sample"
        let expectedBoxOfficeType = "일별 박스오피스"
        let expectedFirstMovieName = "경관의 피"
        
    // when, then
        do {
            let result = try sut.loadJsonData(name: assetName, type: BoxOffice.self)
            XCTAssertEqual(expectedBoxOfficeType, result.boxOfficeResult.boxOfficeType)
            XCTAssertEqual(
                expectedFirstMovieName,
                result.boxOfficeResult.dailyBoxOfficeList[0].movieName
            )
        } catch {
            XCTFail("The loadJsonData was not supposed to throw an Error")
        }
```

### 2️⃣ URL Endpoint관리
api를 호출할 때 하드코딩 된 url을 통째로 넣어서 요청했습니다. 
하지만 이는 url에 쿼리 파라미터를 추가하는 경우에 보일러 플레이트 코드가 발생하기에 URL을 만들어주는 객체가 있으면 좋겠다는 생각이 들었습니다.

* ### BoxOfficeAPI의 사용
```swift
enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    case detailMovieInformation(movieCode: String)
    
    static let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    
    static func makeForEndpoint(_ endpoint: String) -> URL? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        
        return url
    }
}
```
case별로 분류하고 쿼리파라미터에 해당하는 값을 받아 `도메인+경로+api키+엔드포인트`에 해당하는 URL을 반환하는 객체를 만들었습니다. 

하지만 이 경우 현재 요청하는 URL의 HttpMethod는 명시되어있지 않기 때문에 이와 같은 헤더부분 또한 넣어줘서 URLReqeust를 만들어 반환해주는 객체를 만들어야겠다고 생각했습니다.




<br>

## 6. 참고 링크
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Article - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Closure](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [우아한 형제들 - iOS Networking and Testing](https://techblog.woowahan.com/2704/)
- [네트워크와 무관한 URLSession Unit Test](https://wody.tistory.com/10)
- [mock 이용한 URLSession Unit Test](https://sujinnaljin.medium.com/swift-mock-%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-network-unit-test-%ED%95%98%EA%B8%B0-a69570defb41)
- [info.plist api키 가리기](https://velog.io/@loopbackseal/Swift-Plist%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%B4%EC%84%9C-API-key%EB%AF%BC%EA%B0%90%EC%A0%95%EB%B3%B4-%EA%B0%80%EB%A6%AC%EA%B8%B0)
---
