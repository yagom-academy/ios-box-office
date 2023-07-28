//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by Hyungmin Lee on 2023/07/28.
//

import Foundation
@testable import BoxOffice

final class MockURLSessionProvider: URLSessionProtocol {
    var isRequestSuccess: Bool
    var urlSessionDataTask: MockURLSessionDataTask?
    
    init (isRequestSuccess: Bool) {
        self.isRequestSuccess = isRequestSuccess
    }
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let sessionDataTask = MockURLSessionDataTask()
        
        if isRequestSuccess {
            let suceessResponse = HTTPURLResponse(url: URL(string: BaseURL.boxOffice)!, statusCode: 200, httpVersion: "2", headerFields: nil)
            
            sessionDataTask.resumeDidCall = {
                completionHandler(BoxOfficeAPI.daily.sampleData, suceessResponse, nil)
            }
        } else {
            let failureResponse = HTTPURLResponse(url: URL(string: BaseURL.boxOffice)!, statusCode: 410, httpVersion: "2", headerFields: nil)
            
            sessionDataTask.resumeDidCall = {
                completionHandler(nil, failureResponse, nil)
            }
        }
        
        return sessionDataTask
    }
}
