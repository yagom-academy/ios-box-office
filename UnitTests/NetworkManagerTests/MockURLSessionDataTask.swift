//
//  MockURLSessionDataTask.swift
//  BoxOffice
//
//  Created by kaki, Harry on 2023/03/23.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var resumeDidCall: (() -> ())?
    
    func resume() {
        resumeDidCall?()
    }
}
