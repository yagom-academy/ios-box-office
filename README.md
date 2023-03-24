# 박스오피스
> 영화진흥위원회의 OPEN API를 이용하여 하루 전의 박스오피스 목록을 조회하는 앱입니다.
> 
> 프로젝트 기간: 2023.03.20 ~ 2023.03.31

## ⭐️ 팀원
| Rowan | 무리 |
| :--------: |  :--------: | 
| <Img src = "https://i.imgur.com/S1hlffJ.jpg" width="200" height="200"/>      |<Img src ="https://i.imgur.com/SqON3ag.jpg" width="200" height="200"/>
| [Github Profile](https://github.com/Kyeongjun2) |[Github Profile](https://github.com/parkmuri)


## 📝 목차
1. [타임라인](#-타임라인)
2. [프로젝트 구조](#-프로젝트-구조)
3. [실행화면](#-실행화면) 
4. [트러블 슈팅](#-트러블-슈팅) 
5. [핵심경험](#-핵심경험)
6. [참고 링크](#-참고-링크)


# 📆 타임라인 
- 2023.03.20 : JSON 모델타입, DataManager 및 BoxOfficeResult 타입 정의, UnitTest작성
- 2023.03.21 : DataManager 객체 정의, Refactoring (컨벤션, 네이밍)
- 2023.03.22 : TestDouble타입 생성 및 DataManager, URLMaker Test 작성
- 2023.03.23 : DataManager Test case 추가, Refactoring(Test 전반)

<br/>


# 🌳 프로젝트 구조

<details>
    <summary><big>UML</big></big></summary>

<img src="https://i.imgur.com/KMciOxh.png" width="100%">


</details>

<br>
<details>
    <summary><big>File Tree</big></big></summary>

```
├── BoxOffice
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Controller
│   │   └── ViewController.swift
│   ├── Error
│   │   └── NetworkError.swift
│   ├── Model
│   │   ├── DataManager.swift
│   │   ├── JSONModel
│   │   │   ├── DailyBoxOffice.swift
│   │   │   └── MovieDetails.swift
│   │   └── URLMaker.swift
│   └── Protocol
│       └── KobisURLSession.swift
├── BoxOffice.xcodeproj
└── BoxOfficeTests
    ├── DataManagerTests
    │   ├── DataManagerTests.swift
    │   ├── KobisAPI.swift
    │   └── TestDoubles.swift
    ├── JSONModelTests
    │   └── JSONModelTests.swift
    └── URLMakerTests.swift
```



</details>

   
# 📱 실행화면
> UI 구현 후 추가 예정

<br/>

# 🚀 트러블 슈팅
## 1️⃣ startLoad 메서드 모든 오류 Test하기

### 🔍 문제점
처음 Test case 작성 시, test할 메서드에서 던져지는 모든 Error가 처리되지 않고 네트워크 통신이 실패하는 경우 던져지는 Error만 처리하는 문제가 있었습니다.

```swift 
// TestDouble.swift

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, kobisAPI: KobisAPI = .dailyBoxOffice) {
        self.makeRequestFail = makeRequestFail
        self.kobisAPI = kobisAPI
    }
    
     func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
         // 생략
         sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(JokesAPI.randomJokes.sampleData, successResponse, nil)
            }
        }
         //생략
    }
```
### ⚒️ 해결방안
`makeServerError` 프로퍼티를 추가하여 실패 case를 제어할 수 있도록 수정하였습니다.

* `makeServerError` 프로퍼티가 true일 시 NetworkError.server 처리
* `makeRequestFail` 프로퍼티가 true일 시 NetworkError.request 처리

```swift 
class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var makeServerError: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, makeServerError: Bool = false, kobisAPI: KobisAPI = .dailyBoxOffice) {
        self.makeRequestFail = makeRequestFail
        self.makeServerError = makeServerError
        self.kobisAPI = kobisAPI
    }
    
     func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

         // 생략
         sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, nil, NetworkError.request)
            } else if self.makeServerError {
                completionHandler(nil, failureResponse, nil)
            } else {
                switch self.kobisAPI {
                case .dailyBoxOffice:
                    completionHandler(KobisAPI.dailyBoxOffice.sampleData, successResponse, nil)
                case .movieDetails:
                    completionHandler(KobisAPI.movieDetails.sampleData, successResponse, nil)
                }
            }
        }
         //생략
    }
```
<br/>


----

<br/>

# ✨ 핵심경험 

<details>
    <summary><big>✅ TestDouble</big></summary>
    
구현해놓은 DataManager 타입을 test하기 위해서는 네트워크 호출을 해야했습니다. 네트워크의 상태와 무관하게 로직을 테스트하기 위해 **Test Double**을 사용해보았습니다.
    
- Test Double 중 Mock를 이용하여 테스트를 원하는 객체의 behavior 테스트를 진행했습니다.
- `MockURLSessionDataTask`를 구현하고 `MockURLSession`의 `resume()`이 호출되면 프로퍼티로 선언된 클로저가 호출됩니다. 
- `MockURLSession`에서는 테스트를 실패하게 만들기 위한 프로퍼티를 생성 후, 초기값으로 false를 설정합니다.
- `dataTask()`에서 결과에 따라 넘겨줄 `failureResponse`, `successResponse`를 만든 후 성공, 실패 제어에 따라 해당하는 response를 전달할 수 있도록 하였습니다.
    
```swift
// TestDoubles 
class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
}
    
class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var makeServerError: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, makeServerError: Bool = false, kobisAPI: KobisAPI = .dailyBoxOffice) {
        self.makeRequestFail = makeRequestFail
        self.makeServerError = makeServerError
        self.kobisAPI = kobisAPI
    }
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)

        let failureResponse = HTTPURLResponse(url: url,
                                              statusCode: 410,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)
        
        let sessionDataTask = MockURLSessionDataTask()
        
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, nil, NetworkError.request)
            } else if self.makeServerError {
                completionHandler(nil, failureResponse, nil)
            } else {
                switch self.kobisAPI {
                case .dailyBoxOffice:
                    completionHandler(KobisAPI.dailyBoxOffice.sampleData, successResponse, nil)
                case .movieDetails:
                    completionHandler(KobisAPI.movieDetails.sampleData, successResponse, nil)
                }
            }
        }
        self.sessionDataTask = sessionDataTask
        
        return sessionDataTask
    }
}

```

    
</details>

<details>
    <summary><big>✅ URLSession</big></summary>

URLSession 객체를 통해 dataTask를 만들어 서버와 통신을 구현했습니다.
    
completionHandler를 통해 전달되는 data, response, error를 사용하여 네트워크 통신 성공/실패 경우를 처리하였습니다. 

```swift
let task = kobisUrlSession.dataTask(with: url) { data, response, error in
    if let error = error {
        completion(.failure(error))
            
        return
    }
            
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        completion(.failure(NetworkError.server))
                
        return
    }
            
    if let data = data,
       let decodedData = try? JSONDecoder().decode(decodingType, from: data) {
        completion(.success(decodedData))
                
        return
    }
    completion(.failure(NetworkError.decoding))
}
```

</details>  


----


# 📚 참고 링크

* [🍎apple developer 공식문서 - fetching website data into memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
* [🍎apple developer 공식문서 - dataTask](https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask)
* [🍎apple developer 공식문서 - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
* [🍎apple developer 공식문서 - URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
* [yeahg_dev 블로그 - URLRequest 만드는 방법](https://velog.io/@yeahg_dev/URLRequest-%EB%A7%8C%EB%93%9C%EB%8A%94-%EB%B0%A9%EB%B2%95-feat.-HTTP)
* [우아한형제들 기술블로그 - iOS Networking and Testing](https://techblog.woowahan.com/2704/)
