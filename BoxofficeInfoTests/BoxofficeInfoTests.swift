//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by 강민수 on 2023/03/28.
//

import XCTest
@testable import BoxOffice

final class MockNetworkModel: NetworkingProtocol {
    init(session: URLSession) {
        self.session = session
    }
    
    var callCount = 0
    var lastData: Data?
    var lastResponse: HTTPURLResponse?
    var lastError: Error?
    var session: URLSession
    
    func search(url: URL, completion: @escaping (Result<Data, BoxOffice.BoxofficeError>) -> Void) -> URLSessionDataTask {
        callCount += 1
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.lastResponse = response as? HTTPURLResponse
                completion(.failure(.responseError))
                return
            }
            self.lastResponse = httpResponse
            
            guard data != nil else {
                self.lastData = data
                completion(.failure(.incorrectDataTypeError))
                return
            }
            completion(.success(data!))
            self.lastData = data
        }
        task.resume()
        return task
    }
    
    func vaildateSuccessTask(data: Data, httpResponse: HTTPURLResponse, callCount: Int) {
        XCTAssertEqual(self.lastData, data)
        XCTAssertEqual(self.lastResponse?.statusCode, httpResponse.statusCode)
        XCTAssertEqual(self.lastResponse?.url, httpResponse.url)
        XCTAssertEqual(self.callCount, callCount)
    }
}

final class BoxofficeInfoTests: XCTestCase {
    
    var sut: BoxofficeInfo<DailyBoxofficeObject>!
    var model: MockNetworkModel!
    var url = APIType.boxoffice("20230322").receiveUrl()!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocolObject.self]
        let session = URLSession(configuration: configuration)
        
        model = MockNetworkModel(session: session)
        sut = BoxofficeInfo(apiType: .boxoffice("20230322"), model: model)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        model = nil
    }
    
    func test_URLResponse가_200번대라면_Data타입을_받아온다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == self.url else {
                throw BoxofficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            let data = StubBoxoffice().data
            return (response, data)
        }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
        let asyncTest = XCTestExpectation()
        
        // when
        sut.fetchData { _ in
            asyncTest.fulfill()
        }

        wait(for: [asyncTest], timeout: 3)
        
        // then
        model.vaildateSuccessTask(data: StubBoxoffice().data, httpResponse: response, callCount: 1)
    }
    
    
}
