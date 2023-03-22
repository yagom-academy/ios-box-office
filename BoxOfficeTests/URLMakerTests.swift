//
//  URLMakerTests.swift
//  BoxOfficeTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class URLMakerTests: XCTestCase {
    var sut: URLMaker!
    
    override func setUpWithError() throws {
        sut = URLMaker()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_makeDailyBoxOfficeURL호출시_예상하는URL값을_반환한다() {
        // given
        let date = "20230101"
        let URLString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=d975f8608af0d9e5a16e79768ca97127&targetDt=\(date)"
        let expectedResult = URL(string: URLString)
        
        // when
        let result = sut.makeDailyBoxOfficeURL(date: date)
        
        // then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_makeMovieDetailsURL호출시_예상하는URL값을_반환한다() {
        // given
        let code = "20124079"
        let URLString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=d975f8608af0d9e5a16e79768ca97127&movieCd=\(code)"
        let expectedResult = URL(string: URLString)
        
        // when
        let result = sut.makeMovieDetailsURL(code: code)
        
        // then
        XCTAssertEqual(result, expectedResult)
    }
}
