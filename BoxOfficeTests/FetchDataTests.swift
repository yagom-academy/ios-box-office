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
    
    func test_datatask_에러발생_케이스() throws {
        sut = APIClient(session: MockURLSession(errorStatus: true))
        sut?.fetchData(fileType: .json, date: nil) { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                guard let error = error as? APIError else {
                    XCTFail()
                    break
                }
                XCTAssertEqual(APIError.dataTaskError, error)
            }
        }
    }
    
    func test_response_stautsCode_200이_아닌_케이스() throws {
        sut = APIClient(session: MockURLSession(responseStatus: false))
        sut?.fetchData(fileType: .json, date: nil) { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                guard let error = error as? APIError else {
                    XCTFail()
                    break
                }
                XCTAssertEqual(APIError.invalidStatusCode, error)
            }
        }
    }
    
    func test_Data가_nil인_케이스() throws {
        sut = APIClient(session: MockURLSession(mockData: nil))
        sut?.fetchData(fileType: .json, date: nil) { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                guard let error = error as? APIError else {
                    XCTFail()
                    break
                }
                XCTAssertEqual(APIError.noData, error)
            }
        }
    }
    
    func test_Data가_비어있어_디코딩이_불가능한_케이스() throws {
        sut = APIClient(session: MockURLSession())
        sut?.fetchData(fileType: .json, date: nil) { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                guard let error = error as? APIError else {
                    XCTFail()
                    break
                }
                XCTAssertEqual(APIError.decodingError, error)
            }
        }
    }
    
    func test_mockData_url로_호출시_mockBoxOfficeData와_일치하는지() throws {
        sut = APIClient(session: MockURLSession())
        sut?.fetchData(fileType: nil, date: nil) { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(MockBoxOfficeData().boxOffice, data)
            case .failure:
                XCTFail()
            }
        }
    }
}
