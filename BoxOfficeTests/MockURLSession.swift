//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by karen on 2023/08/06.
//

import XCTest
@testable import BoxOffice

final class MockNetworkModel: NetworkingProtocol {
    private var lastData: Data?
    private var lastResponse: HTTPURLResponse?
    private var lastError: BoxOfficeError?
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getRequest(url: URL, completion: @escaping (Result<Data, BoxOffice.BoxOfficeError>) -> Void) -> URLSessionDataTask {
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.lastResponse = response as? HTTPURLResponse
                self.lastError = .responseFail
                completion(.failure(.responseFail))
                return
            }
            self.lastResponse = httpResponse
            
            guard data != nil else {
                self.lastData = data
                completion(.failure(.typeError))
                return
            }
            completion(.success(data!))
            self.lastData = data
        }
        task.resume()
        return task
    }
}
