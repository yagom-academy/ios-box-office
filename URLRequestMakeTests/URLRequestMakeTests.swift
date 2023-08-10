//
//  URLRequestMakeTests.swift
//  URLRequestMakeTests
//
//  Created by Zion, Hemg on 2023/08/10.
//

import XCTest
@testable import BoxOffice

final class URLRequestMakeTests: XCTestCase {
    struct StubURLRequestMake: CanMakeURLRequest {}
    
    private var sut: CanMakeURLRequest!

    override func setUpWithError() throws {
        sut = StubURLRequestMake()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_SetUpRequestURL() {
        //given
        let expectaion = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20190201"
        let expectionURL = URL(string: expectaion)
        let expectaionURLRequest = URLRequest(url: expectionURL!)

        //when
        let baseURL = BaseURL.boxOffice
        let path = BoxOfficeURLPath.daily
        let queryItems: [String: Any] = [
            "targetDt": "20190201"
        ]
        let urlRequest = sut.setUpRequestURL(baseURL, path, queryItems)
        
        //then
        XCTAssertEqual(expectaionURLRequest, urlRequest)
    }
    
}
