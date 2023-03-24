# 박스오피스 📦
> 영화진흥위원회의 일별 박스오피스 및 영화 상세정보 API 문서에 있는 데이터를 가져와서 
> `오늘의 일일 박스오피스 조회` 및 `영화 개별 상세 조회`를 출력하는 앱 


> 프로젝트 기간: 2023.03.20-2023.03.31

## 목차

1. [팀원](#팀원)
2. [타임라인](#타임라인)
3. [트러블슈팅](#트러블슈팅)
4. [참고링크](#참고링크)


## 팀원

| Sehong   |
| :-----------: |
| <img height="210px" src="https://i.imgur.com/64dvDJl.jpg"> 
|[Github Profile](https://github.com/sehoong0429)

## 타임라인

### step1 

| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 03.20     | Json 데이터와 매칭할 일별 박스오피스API 데이터 모델 타입 구현 |
| 03.20     | Json 테스트케이스 구현 | 

### step2, step2-1 

| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 03.22     | NetworkError 타입 구현                          |
| 03.22     | 네트워크 요청 수행하는 APIProvider 클래스 구현                 |
| 03.22     | Json데이터 디코딩 수행 작업할 JSONConverter 클래스 구현 |
| 03.22     | 영화 개별 상세조회를 위한 데이터 모델 구현         |
| 03.22     | 영화 정보 API에서 사용하는 각종 정보를 관리할 수 있는 MovieAPI 구현 |
| 03.22     | API 요청을 받아 해당 요청받고 해당 네트워크 요청을 처리하는 performRequest 함수 구현 |
| 03.22     | 일일오피스 및 영화 상세 데이터 출력을 위한 함수 구현 |                       |
| 03.23     | 테스트환경에서 사용할 URLSessionDataTask 대체 프로토콜 구현 |
| 03.23     | 파라미터 정렬을 위한 URL Extension 추가                 |
| 03.23     | URLSessionDataTask를 모방하여 동작하는 클래스 구현   |
| 03.23     | APIProvider 메서드를 테스트하기 위한 MockURLSession 클래스 구현 | 

## 트러블슈팅 

### 1️⃣ API TEST 

1. 테스트 진행시 URL이 임의로 지정되어도 테스트가 통과되는 문제
2. URL 파라미터 쿼리의 위치가 변경되어 속성이 같아도 같은 URL로 인식하지 않는다는 문제


해당 테스트에서는 각각 일치하지 않는 URL을 넣고 에러를 발생시키는 테스트입니다. 
하지만 해당 테스트에서는 일치하지 않는 URL은 넘기고 서버에러를 만들어주고 있습니다.  
![](https://i.imgur.com/44HNwk7.png)


boxOfficeURLString을 임의로 지정해도 테스트가 통과한다는 것을 확인할 수 있습니다.
![](https://i.imgur.com/KElJwAW.png)

이를 위해, URL extension에 normalizedURL 속성을 추가하여 쿼리 파라미터를 정렬하여 반환하도록 구현했습니다.
```swift
extension URL {
    var normalizedURL: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        if let queryItems = components.queryItems {
            components.queryItems = queryItems.sorted { $0.name < $1.name }
        }
        
        return components.url
    }
}


```
MockURLSession에서는 요청 URL과 응답URL을 비교하여 다르다면,
URLError.differentURL 에러를 반환하는 로직을 추가하여 위 두가지 문제를 해결해주었습니다. 

```swift
if request.url?.normalizedURL != self.response.urlResponse?.url?.normalizedURL {
                self.response.error = URLError.differentURL
}
```



## 2️⃣ HTTP 상태코드에 따른 에러처리 

APIProvider클래스 내의 dataTask 함수는 URLSession의 dataTask를 실행하여
네트워크 요청을 수행하고 결과를 completionHandler에 전달하고 있습니다. 

또한 함수 내에서 클라이언트 에러, 서버 에러 등의 네트워크 에러를 처리하고 있습니다.  
하지만 여기서 저는 Http 상태코드에 따른 에러처리를 200~299 성공 상태 코드가 아니면 
모두 `serverError` 경우로 단 한가지로만 처리해주고 있었습니다. 

```swift
 private func dataTask(request: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        
            ....

        guard let response = urlResponse as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            completionHandler(.failure(.serverError))
            return
        }      
            
        ...
                                                   
    }
```

Http 상태코드는 간단히 아래와 같이 분류됩니다.

100 - 199 : 정보성 상태 코드
200 - 299 : 성공 상태 코드
300 - 399 : 리다이렉션 상태 코드
400 - 499 : 클라이언트 에러 상태 코드
500 - 599 : 서버 에러 상태 코드


위의 상태코드를 참고하여 아래와 같이 결과에 따라 성공상태에 데이터를 받고 나머지의 경우 각각 다른 에러처리를 해주는 방향으로 로직을 수정해보았습니다. 
```swift
        
guard let response = urlResponse as? HTTPURLResponse else {
    completionHandler(.failure(.invalidURLRequest))
        return
        }
        
    switch response.statusCode {
        case 200...299:
        if let data = data {
            completionHandler(.success(data))
        } else {
            completionHandler(.failure(.missingData))
        }
        case 400...499:
            completionHandler(.failure(.clientError))
        case 500...599:
            completionHandler(.failure(.serverError))
        default:
            completionHandler(.failure(.invalidURLComponents))
        }
    }
    task.resume()
}

```

### 3️⃣ API 관리를 위한 MovieAPI 

Step2에서는 오늘의 일일 박스오피스 조회, 영화 개별 상세조회에 대한 네트워킹 타입을 구현해야합니다.
각 API 요청에 대한 필요한 정보를 전달 할 수 있도록 연관 값을 사용하였습니다.

 

1. boxOffice: 일일 박스오피스 정보를 가져오는 API
    - targetDt(date)가 필요합니다.
2. detail: 특정 영화의 상세 정보를 가져오는 API
    - movieCd(code)가 필요합니다.

extension으로 API 요청에 대한 경로, 메소드, 파라미터로 각 API 속성을 나눠서 관리해주는 방식으로 구현해주었습니다. 그 이유는 다음과 같습니다. 

1. 각 속성을 별도로 관리하면 필요한 부분만 가져와 사용할 수 있고, 동일한 baseURL, method를 다른 API가 추가 될 경우에도 쉽게 적용할 수 있습니다. 
2. API의 속성들을 명확하게 구분하여 관리하면 코드가 구조화시킬 수 있습니다. 
3. 각 속성을 분리하여 관리하면, API를 확장하거나 수정할 때 쉽게 대응할 수 있습니다.

```swift
extension MovieAPI {
    
    var key: String {
      return "5946533a51615e4910d26ed447f2a666"
    }
    
    var baseURL: String {
        return "http://kobis.or.kr"
    }
    
    var path: String {
        switch self {
        case .boxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .detail:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }
    
    ... 
    
}
```

### 4️⃣ 에러타입
네트워크 요청 처리 중 발생할 수 있는 에러들을 총 4가지로 나타내주었습니다.
또한 에러 메시지를 사용자 친화적으로 제공할 수 있는 LocalizedError 를 채택해보았습니다.

`clientError` - 클라이언트가 잘못된 데이터를 전송하거나 요청이 올바르지 않은 경우
`serverError` - 서버가 내부 오류로 인해 요청을 처리할 수 없거나 서버가 올바른 응답을 제공하지 못한 경우
`invalidURLComponents` - API 요청을 구성하는 데 필요한 URL 구성 요소가 올바르지 않은 형식인 경우
`invalidURLRequest` - 요청 URL이 올바르게 생성되지 않은 경우
`missingData` - 데이터가 없는 경우

```swift
enum NetworkError: LocalizedError, CustomStringConvertible {
    case clientError
    case serverError
    case invalidURLComponents
    case invalidURLRequest
		case missingData 
    
    var description: String {
        switch self {
        case .clientError:
            return "CLINET_ERROR"
        case .serverError:
            return "SERVER_ERRROR"
        case .invalidURLComponents:
            return "INVALID_URL_COMPONENTS"
        case .invalidURLRequest:
            return "INVALID_URL_REQUEST"
				case .missingData:
            return "MISSING_DATA"
        }
    }
}
```

## 참고링크 

- [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
[Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [swift에서 Json Parsing하기](https://learn-hyeoni.tistory.com/m/45)
- [swift에서 codable사용하기](https://medium.com/humanscape-tech/swift에서-codable-사용하기-367587c5a591)
- [restful-api는 무엇일까요?](https://aws.amazon.com/ko/what-is/restful-api/)
- [restAPI제대로알고사용하기](https://meetup.nhncloud.com/posts/92)
- [네트워크와 무관한URLSessionTest](https://wody.tistory.com/10)
- [네트워크 통신(RESTful API, JSON, URLSession)](https://weekoding.tistory.com/m/7)
- [JSON API와 네트워크 통신하기 - URLSession, JSONConverter](https://bibi6666667.tistory.com/m/359)
- [Test Double이란](https://jiseobkim.github.io/swift/2022/02/06/Swift-Test-Double(%EB%B6%80%EC%A0%9C-Mock-&-Stub-&-SPY-%EC%9D%B4%EB%9F%B0%EA%B2%8C-%EB%AD%90%EC%A7%80-).html)
- [http 통신 get , post , post body json 요청 실시](https://kkh0977.tistory.com/1334)
- [Json파일만들기](https://jurgen-94.tistory.com/30)
- [Constructing URLs in Swift](https://www.swiftbysundell.com/articles/constructing-urls-in-swift/)
- [iOS Networking and Testing](https://techblog.woowahan.com/2704/)
- [[Swift] Mock 을 이용한 Network Unit Test 하기](https://sujinnaljin.medium.com/swift-mock-을-이용한-network-unit-test-하기-a69570defb41)
- [HTTPS상태코드](https://dev-mystory.tistory.com/274)
