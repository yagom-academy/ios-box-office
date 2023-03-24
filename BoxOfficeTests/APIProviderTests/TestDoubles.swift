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

class MockURLSession: DataTaskMakeable {
    var makeRequestFail: Bool
    var makeServerError: Bool
    var kobisAPI: KobisAPI
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false, makeServerError: Bool = false, kobisAPI: KobisAPI = KobisAPI()) {
        self.makeRequestFail = makeRequestFail
        self.makeServerError = makeServerError
        self.kobisAPI = kobisAPI
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
                guard let service = self.kobisAPI.currentService else { return }
                
                completionHandler(service.sampleData, successResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        
        return sessionDataTask
    }
}
