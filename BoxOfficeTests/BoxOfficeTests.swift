//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by JSB on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    func test_boxofficesample파일을_DailyBoxOffice인스턴스에디코딩했을때_값이정상적으로추가된다() {
        //given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        
        //when
        let boxOffice = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let firstDailyBoxOffice = boxOffice.boxOfficeResult.dailyBoxOfficeList[0]
        
        //then
        XCTAssertEqual(boxOffice.boxOfficeResult.boxOfficeType, "일별 박스오피스")
        XCTAssertEqual(boxOffice.boxOfficeResult.showRange, "20220105~20220105")
        XCTAssertEqual(firstDailyBoxOffice.rowNumber, "1")
        XCTAssertEqual(firstDailyBoxOffice.rank, "1")
        XCTAssertEqual(firstDailyBoxOffice.rankChangeValue, "0")
        XCTAssertEqual(firstDailyBoxOffice.rankOldAndNew, "NEW")
        XCTAssertEqual(firstDailyBoxOffice.movieCode, "20199882")
        XCTAssertEqual(firstDailyBoxOffice.movieName, "경관의 피")
        XCTAssertEqual(firstDailyBoxOffice.openDate, "2022-01-05")
        XCTAssertEqual(firstDailyBoxOffice.salesAmount, "584559330")
        XCTAssertEqual(firstDailyBoxOffice.salesShare, "34.2")
        XCTAssertEqual(firstDailyBoxOffice.salesChangeValue, "584559330")
        XCTAssertEqual(firstDailyBoxOffice.salesChangeRatio, "100")
        XCTAssertEqual(firstDailyBoxOffice.salesAccumulate, "631402330")
        XCTAssertEqual(firstDailyBoxOffice.audienceCount, "64050")
        XCTAssertEqual(firstDailyBoxOffice.audienceChangeValue, "64050")
        XCTAssertEqual(firstDailyBoxOffice.audienceChangeRatio, "100")
        XCTAssertEqual(firstDailyBoxOffice.audienceAccumulate, "69228")
        XCTAssertEqual(firstDailyBoxOffice.screenCount, "1171")
        XCTAssertEqual(firstDailyBoxOffice.showCount, "4416")
    }
    
    func test_boxofficesample프로퍼티와_DailyBoxOffice프로퍼티가다르면_파싱에실패한다() {
        //given
        let json = """
        {"boxOfficeResult":{"boxOfficeType":"일별 박스오피스","showRange":"20220105~20220105","dailyBoxOfficeList":[{"rnum":"1","rank":"1","rankInten":"0","rankOldAndNew":"NEW","movieCd":"20199882","movieNm":"경관의 피","openDt":"2022-01-05","salesAmt":"584559330","salesShare":"34.2","salesInten":"584559330","salesChange":"100","salesAcc":"631402330","audiCnt":"64050","audiInten":"64050","audiChange":"100","audiAcc":"69228","scrnCnt":"1171","showCnt":"4416"}]}}
        """
        //when
        guard let dataAsset = json.data(using: .utf8) else { return }
        let test = try? JSONDecoder().decode(BoxOffice.self, from: dataAsset)
        
        //then
        XCTAssertNil(test)
    }
}

