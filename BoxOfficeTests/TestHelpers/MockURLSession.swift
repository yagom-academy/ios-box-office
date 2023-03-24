//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation
@testable import BoxOffice

enum URLError: Error {
    case differentURL
}

final class MockURLSession: URLSessionable {
    
    typealias Response = (data: Data?, urlResponse: URLResponse?, error: Error?)
    
    private(set) var response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskable {
        return MockURLSessionDataTask { [weak self] in
            guard let self else { return }
            
            if request.url?.normalizedURL != self.response.urlResponse?.url?.normalizedURL {
                self.response.error = URLError.differentURL
            }
            
            completionHandler(self.response.data, self.response.urlResponse, self.response.error)
        }
    }
    
    static func create(with urlString: String, data: Data?, statusCode: Int) -> MockURLSession {
        let urlResponse = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        let mockResponse = MockURLSession.Response(data: data, urlResponse: urlResponse, error: nil)
        return MockURLSession(response: mockResponse)
    }
    
}

