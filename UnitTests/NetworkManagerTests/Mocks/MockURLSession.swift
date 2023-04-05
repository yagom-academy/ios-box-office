//
//  MockURLSession.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/23.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var makeRequestFail: Bool
    var request: URLRequest!
    var dataTaskCallCount = 0
    let sessionDataTask = MockURLSessionDataTask()
    
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        self.request = request
        self.dataTaskCallCount += 1
        
        let successResponse = HTTPURLResponse(url: request.url!,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        let failureResponse = HTTPURLResponse(url: request.url!,
                                              statusCode: 410,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(SampleData.boxOfficeData, successResponse, nil)
            }
        }
        
        return sessionDataTask
    }
}
