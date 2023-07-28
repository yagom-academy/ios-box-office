//
//  MockURLSessionDataTask.swift
//  BoxOfficeTests
//
//  Created by Zion, Hemg on 2023/07/28.
//

import Foundation
@testable import BoxOffice

final class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: (() -> Void)!
    
    override func resume() {
        resumeDidCall()
    }
}
