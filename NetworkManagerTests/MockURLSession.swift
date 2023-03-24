//
//  MockURLSession.swift
//  NetworkManagerTests
//
//  Created by Rhode, Rilla on 2023/03/23.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    typealias T = MockURLSessionDataTask
    
    var makeRequestFail = false
    
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
    }
    
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionDataTask {
        
        let testURL = request.url!
        let successResponse = HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: "2", headerFields: nil)
        let failureResponse = HTTPURLResponse(url: testURL, statusCode: 301, httpVersion: "2", headerFields: nil)
        
        let sessionDataTask = MockURLSessionDataTask {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(nil, successResponse, nil)
            }
        }
        
        
        return sessionDataTask
    }
}
