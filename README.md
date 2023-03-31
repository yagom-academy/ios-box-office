# 박스 오피스 🎥

## 프로젝트 소개
> 서버와 통신하여 영화정보를 화면에 출력하는 앱
> 
> 프로젝트 기간: 2023.03.20 - 2023.03.31

## 목차 :book:


- [1. 팀원을 소개합니다 👀](#팀원을-소개합니다-) 
- [2. 시각화된 프로젝트 구조](#시각화된-프로젝트-구조)
    - [2-1. Class Diagram 🗺](#class-diagram-) 
    - [2-2. File Tree 🌲](#file-tree-) 
- [3. 타임라인 ⏰](#타임라인-) 
- [4. 실행 화면 🎬](#실행-화면-) 
- [5. 트러블슈팅 🚀](#트러블-슈팅-) 
- [6. Reference 📑](#reference-) 

</br>

## 팀원을 소개합니다 👀

|<center>[Rhode](https://github.com/Rhode-park)</center> | <center> [릴라](https://github.com/juun97)</center> | 
|--- | --- |
|<Img src = "https://i.imgur.com/XyDwGwe.jpg" width="300">| <img src="https://i.imgur.com/9M6jEo2.png" width=300>  |

</br>

## 시각화된 프로젝트 구조 

### Class Diagram 🗺

<Img src = "https://i.imgur.com/NNNsFuc.png" width="700">



</br>

### File Tree 🌲

```typescript
BoxOffice
├── BoxOffice
│   ├── Resources
│   │   ├── Assets
│   │   └── Info
│   ├── App
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Error
│   │   ├── NetworkError.swift
│   │   └── DecodeError.swift
│   ├── Extension
│   │   ├── Date+.swift
│   │   ├── URLSession+.swift
│   │   ├── URLSessionDataTask+.swift
│   │   ├── String+.swift
│   │   └── CALayer+.swift
│   ├── Extra
│   │   ├── DecodeManager.swift
│   │   └── LoadingIndicator.swift
│   ├── Network
│   │   ├── NetworkManager.swift
│   │   ├── URLMaker.swift
│   │   ├── URLSessionProtocol.swift
│   │   └── URLSessionDataTaskProtocol.swift
│   ├── Model
│   │   ├── DailyBoxOffice
│   │   │   ├── BoxOffice.swift
│   │   │   ├── BoxOfficeResult.swift
│   │   │   └── DailyBoxOffice.swift
│   │   └── DetailMovieInformation
│   │       ├── DetailMovieInformation.swift
│   │       ├── MovieInformationResult.swift
│   │       ├── MovieInformation.swift
│   │       ├── Nation.swift
│   │       ├── Genre.swift
│   │       ├── Director.swift
│   │       ├── Actor.swift
│   │       ├── ShowType.swift
│   │       ├── Company.swift
│   │       ├── Audit.swift
│   │       └── Staff.swift
│   ├── View
│   │   ├── LaunchScreen
│   │   └── CustomCollectionViewCell.swift
│   └── Controller
│       └── BoxOfficeListViewController.swift
└── BoxOfficeTests
    └── BoxOfficeTests
```


</br>

## 타임라인 ⏰

| <center>STEP</center> | <center>날짜</center> | <center>타임라인</center> |
| --- | --- | --- |
|**STEP1**| **2023.03.20** | - JSON 디코딩 위한 모델 구현 </br>- Decoder 객체 구현  |
|**STEP2**| **2023.03.21** | - 추가적으로 필요한 모델 구현 </br> - 서버 통신을 위한 NetworkManger 구현 |
|**STEP2**| **2023.03.22** | - 기능 분리 리팩토링 </br> - 기존 로직 최적화 리팩토링 |
|**STEP2**| **2023.03.23** | - 서버 통신에 대한 유닛 테스트 진행 |
|**STEP2**| **2023.03.24** | - 서버 통신에 대한 유닛 테스트 진행  |
|**STEP2**| **2023.03.27** | - CustomCell 구현 </br> - UICollecionView 구현을 위한 extension 내부 구현 |
|**STEP3**| **2023.03.28** | - 잡아당길 시 새로고침되는 기능을 위한 configureRefreshControll, handleRefreshControll 메서드 구현 |
|**STEP3**| **2023.03.29** | - CustomCell을 UICollectionViewListCell로 변경하는 리팩토링 </br> - LoadingIndicator 구현  |
|**STEP3**| **2023.03.30** |  - 추상화 레벨 맞추는 리팩토링 </br> - 프로퍼티를 줄이고 매개변수로 전달하는 리팩토링 |
|**STEP3**| **2023.03.31** |  - 공통된 로직 제네릭으로 병합하는 리팩토링 </br> - 오토레이아웃 사용하는 곳에서 정의하는 리팩토링  |


</br>

## 실행 화면 🎬


| <center> 처음 실행시 데이터 로딩</center> | <center>내부 데이터 새로고침</center>  | <center>항목들 List로 화면에 표시</center> |
| --- | --- | --- |
| <img src="https://i.imgur.com/LASoeY8.gif" width =400> | <img src="https://i.imgur.com/j2ZXMe0.gif" width =400> | <img src="https://i.imgur.com/MdMpHpH.gif" width =400> |






</br>

## 트러블 슈팅 🚀

### 1️⃣ iOS App HTTP 접근 허용하기


제대로 코드를 구현했다고 생각했음에도 불구하고 네트워크 통신이 제대로 되지 않는 문제가 생겼습니다.
Postman 에서 저희가 작성한 URL 을 보냈을 때 정상적인 값이 돌아오는 것을 확인 했으나 저희 프로젝트에서는 계속해서 통신오류가 발생 하였습니다.


iOS9버전 부터 애플에서 보안에 취약한 네트워크를 차단하기 위한 정책을 실행을 했고 차단된 접근 제한을 푸는 방법은 다음과 같습니다.

<img src="https://i.imgur.com/CaUnS7E.png" width = 600>

</br>

1. info.plist에 App Transport Security Setting항목을 만듭니다.
2. App Transport Security Setting항목의 하위에 Allow Arbitrary Loads항목을 만듭니다.
3. Allow Arbitrary Loads항목의 Value를 No에서 Yes로 변경해줍니다.

### 2️⃣ dataTask의 오류 처리

startLoad 메서드로 서버와 통신을 해 받아오는 데이터에 대해 어떻게 오류를 처리할까 몇 가지 고민을 해보았습니다.

```swift
struct NetworkManager {
    
    func startLoad(urlText: String, complete: @escaping (Result<Data, NetworkError>) -> ()) {
        //....
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //....                                           
        }
    }
```

1. startLoad 에서 return 이용하기
처음엔 막연하게 return 을 해주면 해결되지 않을까 생각했습니다. 하지만 저희가 실질적인 오류를 처리하는 위치는 URLSession.shared.dataTask 의 코드블럭에서 작업을 하고 있었고 해당 위치에서 return 을 하게 되면 startLoad 메서드가 return 되는게 아닌 dataTask의 코드블럭에서 return 되는 것이기에 적절한 방법이 아니었습니다.

2. dataTask 코드블럭 안에서 throw 하기
throw 를 통해 하기에는 startLoad 메서드에서 throw 하는게 아닌 dataTask 클로저가 throw 하는것이기에 적절하지 않다고 생각했고, 또한 해당 메서드를 사용하는 쪽에서도 처리가 애매할 것 같았습니다.
조금 더 고민해본 결과 Complete Handler 의 파라미터로 Result 타입을 사용하기로 결졍했습니다.

3. Complete Handler의 파라미터로 Result 넘기기
startLoad 의 파라미터로 escaping Clousre 을 사용해 해당 클로저가 startLoad 가 끝나는 후에 실행이 되도록 하였습니다.

또한 클로저에 파라미터로 Result 타입을 전달하도록 하여 dataTask 내부에서 통신의 결과에 대해 하나하나 검증을 하면서 통과하지 못할 경우 통과하지 못한 위치에 따라 알맞은 Error 를 failure 을 통해 전달 하도록 하였습니다.
    
    
    
### 3️⃣ verifyResult protocol을 이용해 하나로 구현하는 법

현재 저희는 디코딩 할때와 Network를 통해 GET 해올 때 총 2번의 Result의 검증 절차를 거쳐야 했습니다. 

```swift
private func verifyFetchingResult(result: Result<Data, NetworkError>) -> Data? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
    
    private func verifyDecodingResult<T: Decodable>(result: Result<T, DecodeError>) -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
```

작성을 하고보니 두 메서드의 로직이 똑같아 하나로 합칠 수 있지 않을까 싶어 시도해 보았습니다.

1. Result<NSObject, Error>

성공할 시 넘기는 타입과 에러타입을 각각 최상위 부모 클래스로 설정을 시도 해 보았습니다.
막연하게 부모 클래스라면 하위에 있는 클래스들도 자연스럽게 들어갈 수 있을 거라 생각하고 짜보았으나, 정상적으로 작동하질 않을 뿐 더러 애초에 문법상에서부터 맞질 않았습니다.


2. Result의 프로토콜 채택 후 프로토콜을 파라미터로 받기

Result 을 extension 해서 프로토콜을 채택해 모든 Result 타입에 대해 파라미터로 받을 수 있게 시도해보았습니다.

하지만 해당 프로토콜을 인자로 받게 되면서 성공과 실패에 대한 분기처리를 진행할 수 없었습니다.

3. Generic 사용

메서드에 제네릭을 적용해 Result에 들어가는 타입이 어떤 것이든 범용적으로 쓸 수 있게 설정 했습니다.

```swift
private func verifyResult<T, E: Error>(result: Result<T, E>) throws -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
```

### 4️⃣ 데이터 다운로드 완료 시점에 컬렉션 뷰 업데이트 하기

서버에서 데이터를 GET 하는 dataTask 는 비동기로 돌아가고 있었기에 해당 메서드를 실행한 후 collectionView 를 초기화 해주게 되면 비동기로 실행되던 다운로드 과정이 완료되지 않아 collectionView 내부에 아무런 정보도 들어가지 않던 이슈가 있었습니다.

```swift
   private func fetchBoxOfficeData(completion: @escaping () -> Void) {
        guard let url = urlMaker.makeBoxOfficeURL(date: Date.configureYesterday(isFormatted: false)) else { return }
        server.startLoad(url: url) { result in
          //...
            completion()
        }
    }
```

다운로드를 진행하는 메서드의 파라미터로 escaping 클로저를 사용해 해당 작업이 완료되면 collectionView 를 reload 하는 방법을 채택했습니다.

다만 고려해야할 점은 다운로드를 하는 과정은 메인스레드가 아닌 다른 스레드로 돌고 있었기에 collectionView를 수정하기 위해선 메인스레드서 작업하는 과정을 필요로 했습니다.

```swift
fetchBoxOfficeData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
```    

<br/>

## Reference 📑
- [Fetching Website Data into Memory - Apple Document](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [URLSession - Apple Document](https://developer.apple.com/documentation/foundation/urlsession#declaration)
