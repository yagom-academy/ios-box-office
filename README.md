# 🎬📽️박스 오피스🎞️🎥

## 💬 소개
> 영화진흥위원회의 `API` 서버와 통신하여 일별 박스오피스 정보를 `JSON`데이터로 `Parsing`하여 하루 전의 박스오피스 목록을 조회하고 영화 상세 정보를 확인할 수 있는 프로젝트입니다.

</br>

## 🔖 목차 

1. [팀원](#1.)
2. [타임 라인](#2.)
3. [시각적 프로젝트 구조](#3.)
4. [핵심 경험](#4.)
5. [트러블 슈팅](#5.)
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
### 📂 폴더 구조
![스크린샷 2023-07-28 오후 3 10 47](https://github.com/karenyang835/ios-box-office/assets/124643896/55f4f615-b2c3-4c94-98fe-fb229727a1c5)

### 🎨 Class Diagram
</br>

![image](https://github.com/karenyang835/ios-box-office/assets/124643896/f710adb2-33ed-4001-8d9a-02b03038d099)

---

</br>

<a id="4."></a>

## 4. 🏆 핵심 경험 
### 1️⃣`CodingKeys`를 활용한 Json파싱
- `CodingKeys`의 사용 목적이 단순히 `JSON`에서 사용하는 스네이크케이스를 카멜케이스로 변환하는 용도로만 사용하지 않고`JSON`에서 축약적인 네이밍부분과 명확하지 않은 네이밍 부분도 변경하는 용도로도 활용하고 알아보기 힘든 네이밍 부분도 `swift`에서 추구하는 네이밍으로 변경하는 용도로 작성해 보았습니다.

### 2️⃣ `Generic`을 활용한 범용 메서드 구현
- 다양한 타입의 `Decoding`에 활용 할 수 있도록 `DecodingManager`의 메서드를 `Generic`으로 구현하였습니다.

### 3️⃣ `UnitTest`를 하는 목적과 중점 파악
- `UnitTest`를 하는 목적은 개발자가 작성한 코드가 제대로 자기 역할에 맞게 수행하는지를 검증하는 것이라는걸 알게 되었습니다. 
- `UnitTest`를 작성할 때 나무보다는 숲을 볼 수 있게 코드를 작성할 수 있게 해주는 방법 중 하나라고 생각되었습니다. 추후 진행되어질 부분까지 생각하고 염두해서 유연하게 대처할 수 있는 코드를 작성하려고 노력했습니다.

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
