# 박스오피스 🎬
> 영화진흥위원회 API를 기반으로 박스오피스 리스트를 보여주는 프로젝트
---
## 목차 📋
1. [팀원 소개](#1-팀원-소개)
2. [타임 라인](#2-타임라인-230306--230310)
3. [파일 구조](#3-파일-구조)
4. [실행화면](#4-실행화면)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [Reference](#6-reference)

---
## 1. 팀원 소개
|Goat|songjun|
|:---:|:---:|
|<img src="https://i.imgur.com/yoWVC56.png" width="140" height="140"/>|<img src="https://i.imgur.com/9Bd6NIT.png" width="140">|

## 2. 타임라인 (23.03.06. ~ 23.03.10.)
|날짜|진행 내용|
|---|---|
|2023-03-20|step1 구현 및 PR 요청|
|2023-03-21|step1 리뷰사항 수정 및 merge|
|2023-03-22|Step2 진행 및|
|2023-03-23|step2 PR 요청 및 step3 진행|
|2023-03-24|step2 리뷰 반영 및 Readme 작성| 

## 3. 파일 구조

<details>
    <summary><big>폴더 구조</big></summary>

``` swift
BoxOffice
    │
    ├── Application
    │      ├── AppDelegate
    │      └── SceneDelegate
    ├── Model
    │      ├── DailyBoxOffice
    │      ├── MovieDetail
    │      ├── parser
    │      ├── BoxOfficeAPI
    │      └── URLEnum
    ├── View
    │      └── Main
    ├── Controller
    │      └── ViewController
    ├── Assests
    ├── LaunchScreen
    └── BoxOfficeTests
          └── BoxOfficeTests
    
```

<br>    
    
</details>
<br/>

## 4. 실행화면
step3에서 추가 예정

</details>

## 5. 트러블 슈팅

### :fire:HTTP 접근을 허용시켜주는 방법
>iOS 9 버전 이후부터 적용된 보안 정책으로, 보안에 취약한 네트워크를 차단시키기 때문에 아래와 같은 오류 메세지가 나왔습니다.

<img width="956" alt="스크린샷 2023-03-21 오후 5 48 32" src="https://user-images.githubusercontent.com/88870642/226558255-f45f8cfc-85db-4f61-90a4-8f50c566ba6c.png">

</br>

- 해결방법
1. `info.plist`에 들어간다.
2. `Transport Security Settings`에 접근하여 `App Transport Security Settings`의 값을 `YES`로 바꾼다.
<img src= https://i.imgur.com/8QmPtiz.png>

### :fire: URLSession의 completionHandler에서 error, response, data의 순서
>코드의 순서가 `error`와 `response`를 먼저 처리하고 데이터를 사용하는 것이 올바른 순서입니다. 하지만 변경 전과 같이 `error`와 `response`가 `data` 밑에서 처리 될 경우 `error`와 `response`에서 에러가 날 경우 처리해줄 수 없었습니다. 그렇기 때문에 `error`, `response`, `data`의 순서를 수정하였습니다.

- 변경 전
```swift
 URLSession.shared.dataTask(with: request) { data, response, error in
            guard let validData = data else { return }
            guard let parsedData = parserType.Parse(data: validData) else {return}
            delegate?.fetchAPIData(data: parsedData)
            guard error != nil else { return }

            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
        }.resume()
```
- 변경 후
```swift
URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
            completion(parsedData)
        }.resume()
```
### :fire:ViewController에 API로 불러온 데이터 전달하기
뷰컨트롤러에 API로 받아온 데이터를 전달하는 방법으로 처음에는 `delegate`패턴을 사용하여 뷰컨트롤러에 데이터를 전달하는 방법을 택했는데, `delegate`패턴이 불필요해보인다는 의견이있어서 `escaping Closure`를 사용하는 방법으로 변경했습니다. `delegate` 패턴 사용시 불필요한 전달용 매서드도 만들어야했고 코드도 불필요하게 길어지는게 단점으로 보였습니다.
```swift
func loadBoxOfficeAPI<T: Decodable>(urlAddress: String, parser: Parser<T>
                                    ,completion: @escaping (T) -> Void)

```


## 6. Reference
[Swift Language Guide - URLSession](https://developer.apple.com/documentation/foundation/urlsession)<br />
[Swift Language Guide - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)<br />

