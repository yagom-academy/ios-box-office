//
//  URLSession.swift
//  BoxOfficeTests
//
//  Created by Hisop on 2023/12/01.
//

import Foundation
@testable import BoxOffice

class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: () -> Void = {}
    
    override func resume() {
        completionHandler()
    }
}

class MockURLSession: URLSessionProtocol {
    var mockData: Data
    let responseStatus: Bool
    
    init(mockData: Data = Data(), responseStatus: Bool = true) {
        self.mockData = mockData
        self.responseStatus = responseStatus
    }
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let statusCode: Int
        switch responseStatus {
        case true:
            statusCode = 200
        case false:
            statusCode = 402
        }
        
        let mockURLSessionDataTask = MockURLSessionDataTask()
        let mockURLResponse = HTTPURLResponse(url: url,
                                              statusCode: statusCode,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        mockURLSessionDataTask.completionHandler = {
            completionHandler(self.mockData, mockURLResponse, nil)
        }
        
        return mockURLSessionDataTask
    }
    
    
}

