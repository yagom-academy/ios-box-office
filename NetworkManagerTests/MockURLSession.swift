//
//  MockURLSession.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import Foundation
@testable import BoxOffice

final class MockURLSession: URLSessionProtocol {
    
    typealias Response = (data: Data?, urlResponse: URLResponse?, error: Error?)
    
    private let response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask(resumeHandler: {
            completionHandler(
                self.response.data,
                self.response.urlResponse,
                self.response.error
            )
        })
    }
    
    static func make(url: String, data: Data?, statusCode: Int) -> MockURLSession {
        let mockURLSession: MockURLSession = {
            let urlResponse = HTTPURLResponse(
                url: URL(string: url)!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            
            let mockResponse: MockURLSession.Response = (
                data: data,
                urlResponse: urlResponse,
                error: nil
            )
            
            let mockUrlSession = MockURLSession(response: mockResponse)
            
            return mockUrlSession
        }()
        
        return mockURLSession
    }
}
