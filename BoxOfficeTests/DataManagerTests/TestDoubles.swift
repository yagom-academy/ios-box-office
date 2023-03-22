//
//  TestDoubles.swift
//  BoxOfficeTests
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

enum KobisAPI {
    case
    var dailyOfficeSampleData: Data {
        let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
        return sampleData
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: KobisURLSession {
    var makeRequestFail: Bool
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
    }
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        // 성공시 callback 으로 넘겨줄 response
        let successResponse = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)
        // 실패시 callback 으로 넘겨줄 response
        let failureResponse = HTTPURLResponse(url: url,
                                              statusCode: 410,
                                              httpVersion: "HTTP/1.1",
                                              headerFields: nil)
        
        let sessionDataTask = MockURLSessionDataTask()
        
        // resume() 이 호출되면 completionHandler() 가 호출되도록 합니다.
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(KobisAPI().dailyOfficeSampleData, successResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        return sessionDataTask
    }
}
