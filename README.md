# 🎬📽️박스 오피스🎞️🎥

## 💬 소개
> 영화진흥위원회의 `API` 서버와 통신하여 일별 박스오피스 정보를 `JSON`데이터로 `Parsing`하여 하루 전의 박스오피스 목록을 조회하고 영화 상세 정보를 확인할 수 있는 프로젝트입니다.

</br>

## 🔖 목차 

1. [팀원](#1.)
2. [타임 라인](#2.)
3. [시각적 프로젝트 구조](#3.)
4. [트러블 슈팅](#4.)
5. [고민한 부분](#5.)
6. [참고 링크](#6.)


---

</br>

<a id="1."></a>

## 1. 🎙️ 팀원

|[Karen ♉️](https://github.com/karenyang835)|
| :-: |
| <Img src="https://github.com/karenyang835/ios-bank-manager/assets/124643896/c1954254-be28-4f53-bbe1-5aa01a3d0922" width="250"/>|

---

</br>

<a id="2."></a>

## 2. ⏰ 타임 라인
> 프로젝트 기간 : 2023.07.24. ~ 2023.07.28.

|**날 짜**|**내 용**|
|:-:|-|
| 2023.07.24.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `JSON` <br>|
| 2023.07.25.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `UnitTest` <br>|
| 2023.07.26.    | ✴️ `JSON`타입의 `Decoding`을 위한 `DailyBoxOffice` 구조체 구현 <br>✴️ `JSON`타입의 `Decoding`을 위한 `BoxOfficeResult`구조체 구현 <br>✴️ `JSON`타입의 `Decoding`을 위한 `MovieInfo` 구조체 구현<br> ✴️ `API`서버와의 통신시 구현할 메서드 정의를 위한 `Protocol` 구현 <br> ✴️ 실제 `API`서버와 통신시 실행할 `GetDataAPI`클래스 구현 <br> ✴️ `API`서버와의 통신시 실행 될 부분 `viewController`에 구현<br> ✴️ `DataNamespace` 구현 <br> ✅ `UnitTest` 구현|
| 2023.07.27.    | 🖨️ 부적절한 네이밍 전면 수정 및 컨벤션 동일하게 통일<br>|
| 2023.07.28.    | ✅`test`코드를 `DataManager`로 타겟을 맞추어 디코딩이 원활하게 되는지 테스트하는 코드로 전면 수정 <br> ✍️ README작성 <br>|

---

</br>

<a id="3."></a>

## 3.📊 시각적 프로젝트 구조
</br>

### 📂 폴더 구조
![스크린샷 2023-07-28 오후 3 10 47](https://github.com/karenyang835/ios-box-office/assets/124643896/55f4f615-b2c3-4c94-98fe-fb229727a1c5)

---

</br>

<a id="4."></a>

## 4. 🤔 고민한 부분

### 1️⃣ `CodingKeys`의 역할이 무엇인가?
- 만국박람회때는 `CodingKeys`의 사용 목적이 단순히 `JSON`에서 사용하는 스네이크케이스를 카멜케이스로 변환하는 용도로만 사용한다 생각되어졌지만 카멜케이스도 사용하는 `JSON`에서 축약적인 네이밍부분과 명확하지 않은 네이밍 부분도 변경하는 용도로도 활용해야된다고 생각되어졌습니다. 박스오피스에서는 스네이크케이스 뿐 아니라 네이밍이 명확하지 않거나 알아보기 힘든 네이밍 부분도 `swift`에서 추구하는 네이밍으로 변경하는 용도로 작성해보았습니다.

### 2️⃣ `UnitTest`를 하는 목적이 무엇이고 어디에 중점을 두어야 할까?
- 아직 `UnitTest`하는 부분은 어색하고 많이 어려운 것 같습니다. 
기존에 제가 생각하고 있던 `UnitTest`를 하는 목적은 현재 스텝으로 비유하면 디코딩에 대한 검증이라고 생각했었고 검증을 하는 대상이 애플에서 이미 검증해서 적용시켜 둔 메서드인 `decode`에 대한 검증을 했던 것 같습니다.
- 실상은 명확하게 `UnitTest`를 왜 해야되고 목적이 무엇인지를 명확하게 알지를 못하다보니 방향을 잘못 잡았던 것 같습니다.
- `UnitTest`를 하는 진짜 목적은 제가 작성한 코드가 제대로 자기 역할에 맞게 수행하는지를 검증하는 것이라는걸 알게되었습니다. 그리고 `UnitTest`를 작성할 때 이번 스텝에서는 비록 `API`데이터를 불러와서 연동하지는 않지만 추후에 연동할 것을 고려해서 코드를 작성해두고 그것을 기점으로 원래 들어올 데이터와 테스트용 코드를 각각 구현해서 작성한 코드가 잘 돌아가는지를 확인 할 수 있게 하는것도 중요하다고 생각되어서 되도록이면 어떤 상황에서도 유연하게 대처할 수 있는 코드를 작성하려고 노력했습니다.


---

</br>

<a id="5."></a>

## 5. 🚨 트러블 슈팅

### 1️⃣ .DS_Store는 무엇인가?
#### ⛔️ 문제점
- 평소 프로젝트를 진행할 때 한 번도 안떴던 파일인 것 같은데 이번 프로젝트 진행을 하니 해당 파일이 보였습니다.
![스크린샷 2023-07-28 오후 3 14 05](https://github.com/karenyang835/ios-box-office/assets/124643896/3e0ad7f2-e495-4d74-bbf1-5aa5aab642cf)


#### ✅ 해결 방법
- `DS_Store`파일은 `gitignore`가 생기기 전에 이미 추적을 하고 있는 상황이었기 때문에 `gitignore`에 등록이 되어져 있더라도 추적을 하고 있는 상황이었기에 해당 명령어로 삭제를 해주면 추후에 추적 대상에서 제외되었습니다.
  ![스크린샷 2023-07-28 오후 3 13 18](https://github.com/karenyang835/ios-box-office/assets/124643896/f1a06db7-f77f-4840-b5f0-3586b6a8a02f)


---

</br>



<a id="6."></a> 
## 6. 🔗 참고 링크
🍎 [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) <br>
🍏 [Apple Developer - JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)<br>
📚 [위키백과 - JSON](https://ko.wikipedia.org/wiki/JSON)<br>

---

</br>
