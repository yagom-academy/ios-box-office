//
//  TestDoubles.swift
//  BoxOfficeTests
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var makeServerError: Bool
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, makeServerError: Bool = false) {
        self.makeRequestFail = makeRequestFail
        self.makeServerError = makeServerError
    }
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)

        let failureResponse = HTTPURLResponse(url: url,
                                              statusCode: 410,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)
        
        let sessionDataTask = MockURLSessionDataTask()
        
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, nil, NetworkError.request)
            } else if self.makeServerError {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(KobisAPI.dailyBoxOffice.sampleData, successResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        
        return sessionDataTask
    }
}
