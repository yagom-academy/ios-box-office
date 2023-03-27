//
//  MockURLSessionDataTask.swift
//  NetworkMockTests
//
//  Created by vetto, brody on 23/03/22.
//

import Foundation
@testable import BoxOffice

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let resumeHandler: () -> Void
    
    init(resumeHandler: @escaping () -> Void) {
        self.resumeHandler = resumeHandler
    }
    
    func resume() {
        resumeHandler()
    }
}
