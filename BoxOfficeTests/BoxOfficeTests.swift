//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Harry on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    private var sut: BoxOffice!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_jsonDecoder_decode_성공() {
        // when
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "BoxOffice") else {
            XCTFail("DataAsset Error")
            return
        }
        // then
        XCTAssertNoThrow(try jsonDecoder.decode(BoxOffice.self, from: dataAsset.data))
    }
    
    func test_첫번째_dailyBoxOfficeList_값이_json_데이터와_일치한다() {
        // given
        let result = DailyBoxOfficeList(number: "1", rank: "1", rankIncrement: "0", rankOldAndNew: .new, movieCode: "20199882", movieKoreanName: "경관의 피", openDate: "2022-01-05", salesAmount: "584559330", salesShare: "34.2", salesIncrement: "584559330", salesChange: "100", salesAccumulation: "631402330", audienceCount: "64050", audienceIncrement: "64050", audienceChange: "100", audienceAccumulation: "69228", screenCount: "1171", showCount: "4416")
        // when
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "BoxOffice") else {
            XCTFail("DataAsset Error")
            return
        }
        do {
            sut = try jsonDecoder.decode(BoxOffice.self, from: dataAsset.data)
        } catch {
            XCTFail(error.localizedDescription)
        }
        // then
        XCTAssertEqual(result, sut.boxOfficeResult.dailyBoxOfficeList[0])
    }
    
    func test_두번째_dailyBoxOfficeList_값이_json_데이터와_일치한다() {
        // given
        let result = DailyBoxOfficeList(number: "2", rank: "2", rankIncrement: "-1", rankOldAndNew: .old, movieCode: "20210028", movieKoreanName: "스파이더맨: 노 웨이 홈", openDate: "2021-12-15", salesAmount: "507028380", salesShare: "29.6", salesIncrement: "-91443730", salesChange: "-15.3", salesAccumulation: "62772471900", audienceCount: "50399", audienceIncrement: "-9564", audienceChange: "-15.9", audienceAccumulation: "6252827", screenCount: "1357", showCount: "4314")
        // when
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "BoxOffice") else {
            XCTFail("DataAsset Error")
            return
        }
        do {
            sut = try jsonDecoder.decode(BoxOffice.self, from: dataAsset.data)
        } catch {
            XCTFail(error.localizedDescription)
        }
        // then
        XCTAssertEqual(result, sut.boxOfficeResult.dailyBoxOfficeList[1])
    }
}
