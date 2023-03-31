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

### Step1 : 모델 타입 구현
<details>

 

| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 03.20     | Json 데이터와 매칭할 일별 박스오피스API 데이터 모델 타입 구현 |
| 03.20     | Json 테스트케이스 구현 | 

</details>


### Step 2, 2-1 : 네트워킹 타입 구현 및 Mock 테스트 케이스 구현 
<details>


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

</details>

### Step 3 : 박스오피스 목록 화면 구현
<details>
| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 03.24    | Json 데이터와 매칭할 상세 박스오피스API 데이터 모델 타입 구현 |
| 03.24 - 03.26     | 목록화면을 위한 CollectionView 및 MovieListViewCell 구현 |
| 03.27 | 새로고침을 위한 refreshControl 구현 |
| 03.28 - 03.29 | step3에 대한 코드 개선 및 step4 시작 |
</details>

    
### Step 4 : 영화 상세화면 구현
<details>
| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 03.28    | 상세화면을 위한 DetailViewController 생성 및 코드 작성 |
| 03.28     | 상세화면 목록을 가져오기 위한 fetchMovieDetailData 구현  |
| 03.28 - 03.29 | 목록 데이터를 그려줄 함수 구현 |
| 03.29 | 이미지를 가져오기 위한 데이터 모델 구현 | 
| 03.30 - 03.31 | 이미지 검색을 위한 함수 구현 및 레이아웃 구현 
| 03.31 | 이미지 로딩 전 indicator 구현 |
</details>

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

### 5️⃣ createStateLabel 함수

영화의 순위 변동에 따라 상태 레이블을 생성해주는 함수 

영화진흥위원회API에서 확인할 수 있는 rankOldandNew(랭킹에 신규진입여부)와 rankInten(전일대비 순위의 증감분)을 매개변수로 받아주었습니다. 

1. rankOldandNew가 “Old”인 경우에는 아래 세 조건이 들어갑니다.
 
    -  변동 없으면 "-"
    -  순위 상승 : 빨간 화살표 + 등락 편차  ▲
    -  순위 하락 : 파란 화살표 + 등락 편차  ▼

2. rankOldandNew가 “New”인 경우에는 “신작”으로 표시해줍니다.

```swift
private func createStateLabel(rankOldandNew: String, rankInten: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        if rankOldandNew == "OLD" {
            if rankInten == 0 {
                attributedString.add(string: "-")
            } else if rankInten > 0 {
                attributedString.add(string: "▲", color: .systemRed)
                attributedString.add(string: "\(rankInten)")
            } else {
                attributedString.add(string: "▼", color: .systemBlue)
                attributedString.add(string: "\(-rankInten)")
            }
        } else {
            attributedString.add(string: "신작", color: .systemRed)
        }
        
        return attributedString
        
}
```

또한 새로운 NSAttributedString을 만들어 주어진 속성으로 초기화한 다음, 
기존의 NSMutableAttributedString에 추가하고 반환할 수 있도록 extension을 구현하여 위와 같이 편리하게 원하는 문자열을 추가할 수 있습니다. 

```swift
extension NSMutableAttributedString {
    
    @discardableResult
    func add(
        string: String,
        font: UIFont = .systemFont(ofSize: 12),
        color: UIColor = .label
    ) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        append(NSAttributedString(string: string, attributes: attributes))
        
        return self
    }
    
}
```

### 6️⃣ ImageView extension 구현 

이미지를 가져올 때 이미지가 크면 제가 사이즈를 조절해주더라도
줄여준 만큼 여백이 생기는 문제가 있었습니다. 
`scale`을 이용해서 이미지의 크기를 조절할 수 있도록 했습니다.
원본 이미지의 가로 크기와 UIImageView의 가로 크기를 비교하여 이미지의 스케일을 계산하고, 이용해 UIImage를 생성하는 방식입니다.

데이터에서 이미지를 만드는 과정이 메모리를 많이 사용하는데, 
이런 방식으로 구현하면 imageView에 맞게 크기를 지정해서 불필요한 메모리 사용을 줄일 수 있습니다.   

```swift
extension UIImageView {
    
    func load(url: URL, originalWidth: Int = 0) {
        let viewWidth = frame.width
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let data = try? Data(contentsOf: url) else { return }
            
            let scale = CGFloat(originalWidth) / CGFloat(viewWidth)
            
            let image = UIImage(data: data, scale: scale)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
```
### 7️⃣  Custom log 사용 

커스텀 로그를 사용하면 코드의 실행 흐름을 쉽게 파악할 수 있습니다. 로그를 통해 아래와 같이 함수 호출, 에러 발생 위치 등의 정보를 정확하게 확인 할 수 있어서 사용하게 되었습니다.

![](https://i.imgur.com/p9B5LMu.png)

```swift
func DEBUG_LOG(_ msg: Any, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let filename = file.split(separator: "/").last ?? ""
    let funcName = function.split(separator: "(").first ?? ""
    print("😡[\(filename)] \(funcName) (\(line)): \(msg)")
    #endif
}
```


## 참고링크 

<details>
<summary>step1, step2, step2-1</summary>
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
</details>

<details>
<summary>step3, step4</summary>
- [UIrefreshcontrol](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
- [UIcollectionviewcompositionallayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [Uicollectionlayoutlistconfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
- [implementing_modern_collection_views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [Swift-UICollectionView-CompositionalLayout-UIKit](https://github.com/vvbutko/Swift-UICollectionView-CompositionalLayout-UIKit)
- [how-to-create-uicollectionview-list-with-compositional-layout/](https://www.vbutko.com/articles/how-to-create-uicollectionview-list-with-compositional-layout/)
- [when-to-use-uicollectionview-instead-of-uitableview](https://stackoverflow.com/questions/23078847/when-to-use-uicollectionview-instead-of-uitableview)
- [nsmutableattributedstring](https://developer.apple.com/documentation/foundation/nsmutableattributedstring)
- [Return Early Pattern](https://medium.com/swlh/return-early-pattern-3d18a41bba8)
- [Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
- [creating-lists-with-collection-view/](https://useyourloaf.com/blog/creating-lists-with-collection-view/)
- [CollectionView - FlowLayout](https://co-dong.tistory.com/69)
- [iOS-TableView-xib로-구현하기](https://shark-sea.kr/entry/iOS-TableView-xib%EB%A1%9C-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)
- [Swift-Custom-Cell로-UICollectionView-구현하기](https://velog.io/@jyw3927/Swift-Custom-Cell%EB%A1%9C-UICollectionView-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-i4xtxih4)
- [이미지API가져오기](https://rhkdgus0779.tistory.com/70)
- [indicator-view](https://ios-development.tistory.com/682)
</details>
