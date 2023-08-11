//
//  MockNetworkModel.swift
//  BoxOfficeTests
//
//  Created by karen on 2023/08/06.
//

import XCTest
@testable import BoxOffice

final class MockNetworkModel: NetworkService {
    private var lastData: Data?
    private var lastResponse: HTTPURLResponse?
    private var lastError: BoxOfficeError?
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getRequest(url: URL, completion: @escaping (Result<Data, BoxOffice.BoxOfficeError>) -> Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.lastResponse = response as? HTTPURLResponse
                self.lastError = .failureReseponse
                completion(.failure(.failureReseponse))
                return
            }
            self.lastResponse = httpResponse
            
            guard data != nil else {
                self.lastData = data
                completion(.failure(.invalidType))
                return
            }
            completion(.success(data!))
            self.lastData = data
        }
        task.resume()
    }
}
