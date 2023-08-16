//
//  BoxOfficeEndPointTests.swift
//  BoxOfficeEndPointTests
//
//  Created by Hyungmin Lee on 2023/08/16.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeEndPointTests: XCTestCase {
    private var sut: BoxOfficeEndPoint!
    
    override func setUpWithError() throws {
        sut = BoxOfficeEndPoint(.daily(targetDate: "20220415"))
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_날짜별_dailyBoxOfficeURL을_만들어주는지() {
        //given
        let expectation = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=a38f2bee3ae1dc5696060047ce83c935&targetDt=20220415")
        //when
        let result = sut.url
        
        //then
        XCTAssertEqual(expectation, result)
    }
    
    func test_영화의_구체적인_Description을_요청하는_URL을_만들어주는지() {
        //given
        sut = BoxOfficeEndPoint(.movieDetail(movieCode: "121212"))
        let expectation = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=a38f2bee3ae1dc5696060047ce83c935&movieCd=121212")
        //when
        let result = sut.url
        
        //then
        XCTAssertEqual(expectation, result)
    }
}
