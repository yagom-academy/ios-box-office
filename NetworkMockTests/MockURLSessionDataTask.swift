//
//  MockURLSessionDataTask.swift
//  BoxOfficeTests
//
//  Created by Christy, Hyemory on 2023/03/23.
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
