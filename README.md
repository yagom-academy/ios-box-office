# 박스오피스 📦
> 영화진흥위원회의 일별 박스오피스 및 영화 상세정보 API 문서에 있는 데이터를 가져와서 
> `원하는 날짜`의 `박스오피스 조회` 및 `영화 개별 상세 조회`를 할 수 있고
> `리스트` 및 `아이콘` 화면으로 레이아웃을 변경할 수 있는 앱  


> 프로젝트 기간: 2023.03.20 ~ 2023.04.14 

## 목차

1. [팀원👩🏻‍💻](#팀원👩🏻‍💻)
2. [타임라인⏰](#타임라인⏰)
3. [파일트리🌲](#파일트리🌲)
4. [실행화면↪️](#실행화면↪️)
5. [트러블슈팅☄️](#트러블슈팅☄️)
6. [참고링크🔗](#참고링크🔗)

## 팀원👩🏻‍💻

| Sehong   |
| :-----------: |
| <img height="210px" src="https://i.imgur.com/64dvDJl.jpg"> 
|[Github Profile](https://github.com/sehoong0429)

## 타임라인⏰

### Step 1 : UICalendarView를 활용해 날짜선택 화면 구현


| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 04.03 - 04.04    | UICalendarView를 그려주기 위한 Controller 생성 및 연결 함수 구현|



### Step 2 : 화면 모드 변경



| 날짜          | 주요 진행 사항                                             |
| ------------- | ----------------------------------------------------- |
| 04.05     | navigationToolbar 함수 구현             |
| 04.05     | 각 화면 모드에 맞는 list, icon 레이아웃 그려주는 함수 구현                 |
| 04.06     | icon화면에 셀을 그려주는 movieIconCell 생성 |
| 04.06     | list화면 및 detail화면에 dynamic type 적용     |



## 파일트리🌲

<details>

```
 BoxOffice
├── App
│   ├── AppDelegate.swift
│   ├── CustomLog.swift
│   └── SceneDelegate.swift
├── Base.lproj
├── Info.plist
├── Extensions
│   ├── Int+decimal.swift
│   ├── JoinedString.swift
│   ├── String+NSMutableAttributed.swift
│   ├── UIImageview+load.swift
│   └── URL+normalized.swift
├── Model
│   ├── BoxOfficeItem.swift
│   ├── DateFormatOption.swift
│   ├── ImageAPI.swift
│   ├── ImageSearchResult.swift
│   ├── MovieAPI.swift
│   ├── MovieInfoItem.swift
│   ├── MovieInfoTitle.swift
│   ├── MovieRankingItem.swift
│   ├── NameSpace.swift
│   ├── SecretKey.swift
│   └── ViewOption.swift
├── Network
│   ├── APIProvider.swift
│   ├── JSONConverter .swift
│   └── NetworkError.swift
├── Protocols
│   ├── URLSessionDataTaskable.swift
│   └── URLSessionable.swift
├── Resources
│   └── Assets.xcassets
├── View
│   ├── DetailMovieInfoViewController.swift
│   ├── MovieIconCell.swift
│   ├── MovieInfoView.swift
│   └── MovieListCell.swift
└── ViewController.swift
└── CalendarViewController.swift
└── DateManager.swift
BoxOfficeTests
├── TestHelpers
│   ├── MockURLSession.swift
│   ├── MockURLSessionDataTask.swift
│   └── URLSessionTests.swift
└── Tests
    └── BoxOfficeTests.swift

```
</details>

## 실행화면↪️

| 날짜 선택 📆   |  화면 모드 변경 📺 |
| :-----------: | :-----------: | 
| <img height="600px" width="300px" src="https://i.imgur.com/Z12PB6P.gif"> | <img  height="600px" width="300px"  src="https://i.imgur.com/Ld7UUN3.gif">



## 트러블슈팅☄️ 


### 1️⃣ UICalendarView와 UIDatePicker의 차이 
둘다 사용 경험이없어 먼저 차이점과 구현 방식에 대해 찾아보고 진행하였습니다. 

**UIDatePicker** 
A control for inputting date and time values
:날짜와 시간을 입력 하기 위한`control`

- UIDatePicker은 유저가 한번에 하나의 point만 선택할 수 있습니다.
- UIDatePicker은 날짜 및 시간 선택에 중점을 둔 단일 컴포넌트기때문에 
특정 시점에 대해 사용자로부터 입력을 받거나 해당 날짜를 처리하고 싶거나 시간을 선택하는 방식으로 구현하고 싶다면 UIDatePicker를 사용하면 됩니다.

**Calendar view** 
: 특정한 날짜가 있는 달력을 표시하고, 사용자가 단일 날짜 또는 여러 날짜를 선택할 수 있는 `view` 
- UICalendarView를 사용하면 추가 정보(예: 예정된 이벤트)가 있는 사용자의 특정 날짜를 표시할 수 있습니다.
- 달력을 보여주고 선택하는 것만 구현하려면 UICalendarView를 사용하면 됩니다.
<br>
UICalendarView와 UIDatePicker의 중요한 차이점은 
NSDate를 사용하는 특정 시점을 나타내는 UIDatePicker와 달리 UICalendarView는 NSDateComponents로 날짜를 나타낸다는 것입니다.

1. **NSDate**: NSDate는 특정 시점을 나타내는 클래스입니다. 
유닉스 시간인 1970년 1월 1일 00:00:00 UTC부터 현재 시점까지의 시간 간격을 초 단위로 저장합니다. NSDate는 시간대를 고려하지 않으며, 절대 시간을 나타냅니다.

2. **NSDateComponents**: NSDateComponents는 날짜 및 시간의 구성 요소를 나타내는 클래스입니다.<br> 이 클래스는 연도, 월, 일, 시간, 분, 초 등의 구성 요소를 개별적으로 저장하며, 시간대와 관련된 정보도 포함할 수 있습니다.
```swift
let calendarView = UICalendarView()
let selectedDateComponents = calendarView.selectedDateComponents
```

이 차이점은 날짜 및 시간 처리 방식에 영향을 미칩니다. 
UIDatePicker를 사용하면 NSDate를 사용하여 절대 시간을 처리하게 되며, UICalendarView를 사용하면 NSDateComponents를 사용하여 날짜 및 시간의 개별 구성 요소를 처리하게 됩니다. 이렇게 함으로써 UICalendarView는 선택한 날짜 및 시간에 대한 더 세밀한 제어를 가능하게 합니다.

*물론 UIDatePicker도 NSDateComponents를 사용하여 날짜 및 시간 구성 요소를 처리할 수 있었습니다.:
```swift
let datePicker = UIDatePicker()
let selectedDate = datePicker.date

let calendar = Calendar.current
let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
```



## 2️⃣ Map 사용하여 Optional 처리

map은 두 가지 주요 역할을 수행을 할 수 있습니다. 

`변환` : map은 배열, 옵셔널에 저장된 값을 가져와 주어진 클로저 내의 로직에 따라 새로운 값을 생성합니다.

`옵셔널 다루기`: 옵셔널 값에 map을 사용할 때, 옵셔널 값이 nil인 경우 클로저 내의 코드를 실행하지 않습니다. <br>
이를 통해 nil 값에 대한 처리를 간결하게 할 수 있으며, 옵셔널 값이 있는 경우에만 로직을 실행할 수 있습니다.

```swift 
private func setTitle(date: Date) {
        DateManager.formattedDateString(of: date, option: .calendar)
            .map { title = $0 }
    }
```

위의 setTitle 함수는 주어진 날짜의 제목을 설정합니다. DateManager.formattedDateString 함수의 반환값이 Optional이기때문에 map을 사용하여 nil이 아닌 경우에만 title 변수에 값을 할당합니다. 또한 위의 경우는 DateFormatOption을 하드코딩하지 않고 타입을 써서 nil이 아닌 경우를 보장할 수 있습니다. 이렇게 하면 안전하게 Optional 값을 처리할 수 있습니다. 
 

### 3️⃣ DateManager 구현
조언을 받았던대로 한 객체가 하나의 역할만 수행할 수 있도록 분리하여 date 관련된 함수들을 `DateManager`로 만들어서 분리해보았습니다.

1. `createYesterdayDate()`: 어제 날짜를 만들어주는 함수 
2. `formattedDateString()`: 날짜를 지정된 포맷 옵션에 따라 문자열로 변환하여 반환하는 함수
3. `formattedDateString()`: 날짜 문자열을 'yyyy-MM-dd' 형식에서 'MMMM dd, yyyy' 형식으로 변환하여 반환하는 함수
```swift
struct DateManager {
    
    static func createYesterdayDate() -> Date {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today) ?? today
        return yesterday
    }
    
    static func formattedDateString(of date: Date, option: DateFormatOption) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = option.rawValue
        return dateFormatter.string(from: date)
    }
    
    static func formattedDateString(of dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatOption.numerical.rawValue
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = DateFormatOption.calendar.rawValue
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
}
```

또한 DateFormat 문자열을 하드코딩하고 있었는데 해당부분도 
열거형으로 분리하여 코드를 전체적으로 정리해보았습니다. 
```swift
enum DateFormatOption: String {
    case calendar = "yyyy-MM-dd"
    case numerical = "yyyyMMdd"
}

```
### 4️⃣ 메인 화면의 뷰 모드 변경 기능 구현
사용자는 뷰 모드를 다음과 같이 변경할 수 있습니다.
1. 리스트 모드
2. 아이콘 모드

`UIAlertController`를 이용하여 뷰 모드 변경 버튼을 생성해주었고
이 버튼을 누르면 현재 모드를 변경 할 수 있습니다. 
```swift 
@objc private func changeViewMode() {
    let alert = UIAlertController(title: "화면모드변경",
                                  message: nil,
                                  preferredStyle: .actionSheet)
    
    let actionTitle: String = currentViewOption == .list ? ViewOption.icon.rawValue : ViewOption.list.rawValue
    let viewModeAction = UIAlertAction(title: actionTitle, style: .default) { [weak self] _ in
        guard let self else { return }
        self.changeView()
    }
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alert.addAction(viewModeAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
}

```

changeView() 함수를 통해 뷰 모드를 변경하고, 뷰를 새로고침하는 방식입니다. 
```swift 
private func changeView() {
    if case .list = currentViewOption {
        collectionView.setCollectionViewLayout(createIconLayout(),
                                               animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                    at: .top, animated: false)
        currentViewOption = .icon
    } else if case .icon = currentViewOption {
        collectionView.setCollectionViewLayout(createListLayout(),
                                               animated: true)
        currentViewOption = .list
    }
    collectionView.reloadData()
}

```

### 5️⃣ CompositionalLayout을 이용한 화면 icon 모드 구현

NSCollectionLayoutSize, NSCollectionLayoutItem, NSCollectionLayoutGroup, 및 NSCollectionLayoutSection을 사용하여 아이콘 모드의 레이아웃을 구성하고 있습니다. 
이를 통해 아이콘 모드에서 영화 포스터가 가로로 2개씩 표시되도록 설정해주었습니다. 

```swift
private func createIconLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                          heightDimension: .absolute(180))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(180))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    section.interGroupSpacing = 10
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}

```






## 참고링크🔗

### step1, step2

- [UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
- [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
- [What’s new in Swift? - WWDC22](https://www.notion.so/UICalendarView-8c9f04597fed4a86bcf846a087ac17d6) 
- [How to Use UICalendarView in iOS 16](https://betterprogramming.pub/uicalendarview-tutorial-593731e52b72)
