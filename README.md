# 박스 오피스 프로젝트 🍿
> [영화진흥위원회](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice)의 오픈 API를 이용하여 박스 오피스 영화를 소개하는 프로젝트

---
## 목차 📋
1. [팀원 소개](#1-팀원-소개)
2. [타임 라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [트러블 슈팅](#4-트러블-슈팅)
5. [Reference](#5-reference)

## 1. 팀원 소개

|[Hyemory](https://github.com/Hyemory)| [Christy](https://github.com/christy-hs-lee) | 
| :--------: | :--------: |
|<img height="180px" src="https://i.imgur.com/r0PGWW3.png">| <img height="180px" src="https://i.imgur.com/kHLXeMG.png"> |

<br>

## 2. 타임라인
### 프로젝트 진행 기간
**23.03.20 (월) ~ 23.03.31 (금)** 

| 날짜 | 타임라인 |
| --- | --- |
| 23.03.20 (월) | 프로젝트 시작, 박스 오피스 모델, 디코더 타입 구현 및 유닛 테스트 진행 |
| 23.03.21 (화) | 박스 오피스 모델, 디코더 타입 리팩토링 |
| 23.03.22 (수) | 영화 정보 모델, 네트워크 매니저 모델 타입 구현 |
| 23.03.23 (목) | 네트워크 Mock 유닛 테스트 진행 |
| 23.03.24 (금) | 코드 리팩토링 및 프로젝트 회고 진행 |

<br>

## 3. 프로젝트 구조
### 폴더 구조

```swift
├── BoxOffice
│   ├── Controller
│   │   └── ViewController.swift
│   ├── Model
│   │   ├── BoxOffice.swift
│   │   ├── DailyBoxOfficeItem.swift
│   │   ├── Movie.swift
│   │   └── MovieInfo.swift
│   ├── Network
│   │   ├── Decoder
│   │   │   └── NetworkDecoder.swift
│   │   ├── NetworkManager.swift
│   │   ├── NetworkingError.swift
│   │   ├── URLMaker.swift
│   │   └── protocols
│   │       ├── URLSessionDataTaskProtocol.swift
│   │       └── URLSessionProtocol.swift
│   └── View
└── BoxOfficeTests
    ├── BoxOfficeTests.swift
    ├── DummyBoxOffice.swift
    ├── MockURLSession.swift
    ├── MockURLSessionDataTask.swift
    ├── NetworkManagerTests.swift
    └── New Group
```

</br>

## 4. 트러블 슈팅
### 1️⃣ JSON Decoding 유닛테스트

#### 🔒 문제점 <br/>
sut(decoding)가 정상적으로 실행되지 않을 때 nil을 반환하도록 유닛 테스트를 작성하였는데
타입에 문제가 있는 것인지, data에 문제가 있는 것인지 구별이 되지 않는 문제가 있었습니다.

``` swift
// MARK: - sut 실행 구문
do {
    let result = try decoder.decode(type, from: items.data)

    return result
} catch DecoderError.decodeFailed {
    print("\(name)파일 디코딩에 실패했습니다.")

    return nil
}

// MARK: - Unit test 메서드
func test_디코딩할때_nil을반환하지않는다() {
    // then
    XCTAssertNotNil(sut)
}
```

#### 🔑 해결 방법 <br/>
타입과 data를 각각 잘못된 값을 주입하여 확인해 보는 방법으로 수정하였습니다.

``` swift
func test_잘못된data로_디코딩했을때_decodeFailed에러를던진다() {
    // given
    let invalidData = Data(count: 0)
    let expectation = NetworkingError.decodeFailed
    var result: NetworkingError?

    // when
    XCTAssertThrowsError(try NetworkDecoder().decode(data: invalidData, type: BoxOffice.self).get()) {
        errorHandler in
        result = errorHandler as? NetworkingError
    }

    // then
    XCTAssertEqual(result?.description, expectation.description)
}

func test_잘못정의한Model로_디코딩했을때_decodeFailed에러를던진다() {
        // given
        let expectation = NetworkingError.decodeFailed
        var result: NetworkingError?
        
        // when
        XCTAssertThrowsError(try NetworkDecoder().decode(data: NSDataAsset(name: "box_office_sample")!.data,
                                                          type: DummyBoxOffice.self).get()) {
            errorHandler in
            result = errorHandler as? NetworkingError
        }
        
        // then
        XCTAssertEqual(result?.description, expectation.description)
    }
```

<br/>

### 2️⃣ 확장성있는 Decoder 타입만들기 

#### 🔒 문제점 <br/>
샘플로 사용할 Asset의 JSON 파일은 이후 다루지 않게되고, 들어갈 타입도 계속 변경이 될 것이라 생각했습니다.

```swift
func decode(name: String) throws -> BoxOffice? {
    guard let items = NSDataAsset(name: name) else {
        throw DecoderError.decodeFailed
    }

    do {
        let result = try decoder.decode(BoxOffice.self, from: items.data)

        return result
    } catch DecoderError.decodeFailed {
        print("\(name)파일 디코딩에 실패했습니다.")

        return nil
    }
}
```

#### 🔑 해결 방법 <br/>
data와 type을 매개변수로 받아 제네릭을 이용하여 확장성 있게 수정하였습니다.
또한 성공, 실패 두가지 분류로 나뉘다보니 Result 타입을 이용하여 오류를 던져주는 방식을 채택하였습니다.

``` swift
func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
    if let result = try? JSONDecoder().decode(type, from: data) {
        return .success(result)
    } else {
        return .failure(NetworkingError.decodeFailed)
    }
}
```

## 5. Reference
- [Apple Docs - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Docs - URLSessionDataTask](https://developer.apple.com/documentation/foundation/urlsessiondatatask)
- [Apple Docs - URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared)
- [iOS Networking and Testing](https://techblog.woowahan.com/2704/)
- [URLSession & Result](https://swiftstudent.com/2020-04-14-urlsession-and-result/)

---

###### tags: `readme`
