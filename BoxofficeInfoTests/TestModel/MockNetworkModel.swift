//
//  MockNetworkModel.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/28.
//

import XCTest
@testable import BoxOffice

final class MockNetworkModel: NetworkingProtocol {
    private var callCount = 0
    private var lastData: Data?
    private var lastResponse: HTTPURLResponse?
    private var lastError: BoxofficeError?
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func search(url: URL, completion: @escaping (Result<Data, BoxOffice.BoxofficeError>) -> Void) -> URLSessionDataTask {
        callCount += 1
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.lastResponse = response as? HTTPURLResponse
                self.lastError = .responseError
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
    
    func validateFailureTask(httpResponse: HTTPURLResponse, callCount: Int, error: BoxofficeError?) {
        XCTAssertNil(self.lastData)
        XCTAssertEqual(self.lastResponse?.statusCode, httpResponse.statusCode)
        XCTAssertEqual(self.lastResponse?.url, httpResponse.url)
        XCTAssertEqual(self.callCount, callCount)
        XCTAssertEqual(self.lastError, error)
    }
}
