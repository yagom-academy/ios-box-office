//
//  MockURLSessionDataTask.swift
//  NetworkManagerTests
//
//  Created by Rhode, Rilla on 2023/03/23.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    var resumeHandler: () -> Void
    
    override func resume() {
        resumeHandler()
    }
}
