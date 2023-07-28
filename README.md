# 박스오피스🎬
## 소개
> 영화진흥위원회의 API를 통해 박스오피스, 영화 상세정보를 불러오는 앱입니다.

**프로젝트 기간 : 23/07/24~**
</br>

## 목차
1. [팀원소개](#1.)
2. [타임라인](#2.)
3. [시각화구조](#3.)
4. [핵심경험](#4.)
5. [트러블슈팅](#5.)
6. [참고자료](#6.)

</br>
 
<a id="1."></a></br>
## 팀원소개
|<Img src =  "https://hackmd.io/_uploads/rJj1EtKt2.png" width="200" height="200">|<Img src="https://hackmd.io/_uploads/rk62zRiun.png" width="200">|
|:-:|:-:|
|[**Yetti**](https://github.com/iOS-Yetti)|[**maxhyunm**](https://github.com/maxhyunm)|

<a id="2."></a></br>
## 타임라인
|날짜|내용|
|:--:|--|
|2023.07.24.| json 파일 파싱을 위한 BoxOfficeEntity 타입 생성, 디코딩 유닛테스트 진행 |
|2023.07.25.| DecodingManager에서 디코딩만 진행할 수 있도록 기능 분리 |
|2023.07.26.| NetworkingManager, BoxOfficeError, MoviewDetailEntity 타입 생성 |
|2023.07.27.| extension으로 중첩타입 분리, URLNamespace 타입 생성 |
|2023.07.28.| 네트워킹 테스트를 위한 Test Double 작성 |

<a id="3."></a></br>
## 시각화 구조
### File Tree
    ├── BoxOffice
    │   ├── Info.plist
    │   ├── Controller
    │   │   └── BoxOfficeViewController.swift
    │   ├── Model
    │   │   ├── BoxOfficeEntity.swift
    │   │   ├── BoxOfficeError.swift
    │   │   ├── DecodingManager.swift
    │   │   ├── MovieDetailEntity.swift
    │   │   ├── NetworkingManager.swift
    │   │   └── URLSessionProtocol.swift
    │   ├── Resource
    │   │   ├── AppDelegate.swift
    │   │   ├── Assets.xcassets
    │   │   ├── SceneDelegate.swift
    │   │   ├── URLNamespace.swift
    │   │   └── box_office_sample.json
    │   └── View
    │       └── Base.lproj
    │           ├── LaunchScreen.storyboard
    │           └── Main.storyboard
    ├── BoxOffice.xcodeproj
    ├── BoxOfficeTests
    │   ├── BoxOffice.xctestplan
    │   ├── BoxOfficeDecodingTests.swift
    │   ├── BoxOfficeNetworkingTest.swift
    │   └── TestDouble.swift
    └── README.md

### UML
<img src="https://hackmd.io/_uploads/B1RScCej3.png">


<a id="4."></a></br>
## 핵심경험
#### 🌟 CodingKeys와 Nested Type Enum을 활용한 중첩 json 파싱
Neste Type을 활용하여 여러 단계로 중첩된 형태의 json을 파싱할 수 있도록 하였고, CodingKeys를 활용해 이해하기 어려운 파라미터명을 변경하였습니다.
#### 🌟 Generic을 활용한 범용 메서드 구현
다양한 타입의 Entity를 반환해야 하는 DecodingManager의 메서드를 Generic으로 구현하였습니다.
#### 🌟 xcconfig, info.plist를 활용한 api key 설정
환경 파일을 활용해 원격 저장소에 공유되지 않아야 하는 key 정보를 관리하였습니다.

<a id="5."></a></br>
## 트러블슈팅
### 1️⃣ dataTask 메서드로 받아온 데이터 처리
**🚨 문제점**</br>
`NetworkingManager`의 `load()` 메서드를 호출한 위치에서 `dataTask`를 통해 받아 온 데이터를 해당 클로저 밖에서 활용할 수 있는 방법에 대해 고민이 있었습니다.
처음에는 두 타입을 델리게이트로 연결하여 전달하는 등의 방법을 생각했습니다. 하지만 데이터 처리를 위해 네트워킹을 사용하는 모든 타입을 델리게이트로 연결하는 것은 권장되는 방식도 아니고, 효율적이지 못한 것 같았습니다.

**💡 해결 방법**</br>
`@escaping` 클로저와 `Result`타입을 활용하여 해결하였습니다. `Result`는 성공/실패 두 가지 가능성에 대한 데이터타입을 따로 지정해줄 수 있어 `CompletionHandler`에 활용하기에 적절하다고 판단했습니다.
```swift
func load(_ urlString: String, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }

    let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
            completion(.failure(BoxOfficeError.connectionFailure))
            return
        }
        ...
```

### 2️⃣ Test Double 생성
**🚨 문제점** </br>
인터넷 연결이 없는 상태에서 네트워크 통신을 테스트하기 위해 `Test Double`을 생성하였습니다. 이 과정에서 테스트용 `Stub Session`과 실제 `Session` 사이에 호환이 가능하도록 하기 위해 `URLSessionProtocol`을 구현하였는데, `URLSession`에서 이를 상속하려 하니 아래와 같은 경고가 발생하였습니다.</br>
<img src="https://hackmd.io/_uploads/BJeZG3lin.png" width="1000"></br>

**💡 해결 방법**</br>
`CompletionHandler typealias`에 `@Sendable`을 채택하여 해결하였습니다.</br>
```swift
typealias CompletionHandler = @Sendable (Data?, URLResponse?, Error?) -> Void
```

### 3️⃣ ATS를 통한 네트워크 설정
**🚨 문제점**</br>
API를 받아와야 하는 도메인이 `https`가 아닌 `http`를 활용하고 있어 네트워크 연결시에 오류가 발생하였습니다.</br>
<img src="https://hackmd.io/_uploads/BkwWly-jn.png"></br>

**💡 해결 방법**</br>
해당 도메인 및 하위 도메인 정보를 ATS에 `Exception Domains`로 추가하여 정상적으로 네트워킹이 가능하도록 구현하였습니다.</br>
<img src="https://hackmd.io/_uploads/Hkj4Tsgjh.png"></br>




<a id="6."></a></br>
## 참고자료
- [URLSession 공식문서](https://developer.apple.com/documentation/foundation/urlsession)
- [Fetching Website Data into Memory 공식문서](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [야곰 닷넷 - Unit Test](https://yagom.net/courses/unit-test-%ec%9e%91%ec%84%b1%ed%95%98%ea%b8%b0/)
