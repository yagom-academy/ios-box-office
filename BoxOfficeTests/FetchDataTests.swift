//
//  fetchDataTests.swift
//  BoxOfficeTests
//
//  Created by Hisop on 2023/12/01.
//

import XCTest
@testable import BoxOffice

final class FetchDataTests: XCTestCase {
    var sut: APIClient?
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchData_에서전달한_data가_mockData와_일치하는지() throws {
        var result: BoxOffice
        let mockData = """
                        test
                        """.data(using: .utf8)!
        //디코딩테스트는 이미 진행했는데 추가적으로 디코딩을 테스트해야할 이유가 있나?
        //디코딩 과정이 APIClient 코드에 포함되어버려서 테스트를 변경해야하는 상황
        //
        
        
        sut = APIClient(session: MockURLSession(mockData: mockData))
        sut?.fetchData(url: URL(string: "test")!) { data, response in
            guard let data = data else {
                XCTFail()
                return
            }
            result = data
        }
        XCTAssertEqual(mockData, result)
    }
    
    func test_fetchData_성공시_response_stautsCode가_200인지() throws {
        var resultStatus = 0
        
        sut = APIClient(session: MockURLSession(responseStatus: true))
        sut?.fetchData(url: URL(string: "test")!) { data, response in
            guard let statusCode = response?.statusCode else {
                XCTFail()
                return
            }
            resultStatus = statusCode
        }
        XCTAssertEqual(200, resultStatus)
    }
    
    func test_fetchData_실패시_response_stautsCode가_402인지() throws {
        var resultStatus = 0
        
        sut = APIClient(session: MockURLSession(responseStatus: false))
        sut?.fetchData(url: URL(string: "test")!) { data, response in
            guard let statusCode = response?.statusCode else {
                XCTFail()
                return
            }
            resultStatus = statusCode
        }
        XCTAssertEqual(402, resultStatus)
    }

}
