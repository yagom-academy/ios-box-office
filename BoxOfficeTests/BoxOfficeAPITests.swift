//
//  BoxOfficeAPITests.swift
//  BoxOfficeTests
//
//  Created by Hyungmin Lee on 2023/07/28.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeAPITests: XCTestCase {
    private var sut: MockURLSessionDataTask!
    
    override func setUpWithError() throws {
//        sut = URLSession
        //MockURLSessionProvider(isRequestSuccess: true)
    }
    
    override func tearDownWithError() throws {
//        sut = nil
    }
    
    func test_테스트다() {
        let data = NSDataAsset(name: "Daily")
        
        let test = APIRequest(baseURL: BaseURL.boxOffice, path: nil, queryItems: nil)
        let session: URLSessionProtocol = MockURLSessionProvider(isRequestSuccess: true)
        
        URLSessionProvider.requestData(test, session) { (result: APIResult<BoxOfficeResult>) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
