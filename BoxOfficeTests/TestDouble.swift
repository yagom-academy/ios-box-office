//
//  TestDouble.swift
//  BoxOfficeTests
//
//  Created by Yetti, Maxhyunm on 2023/07/28.
//

import Foundation
@testable import BoxOffice

struct DummyResponse {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: CompletionHandler? = nil
    
    func completion() {
        completionHandler?(data, response, error)
    }
}

final class StubURLSession: URLSessionProtocol {
    var dummyResponse: DummyResponse?
    
    init(_ dummy: DummyResponse) {
        self.dummyResponse = dummy
    }
    
    func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        dummyResponse?.completionHandler = completionHandler
        
        return StubURLSessionDataTask(dummyResponse)
    }
}

final class StubURLSessionDataTask: URLSessionDataTask {
    var dummyResponse: DummyResponse?
    
    init(_ dummy: DummyResponse?) {
        self.dummyResponse = dummy
    }
    
    override func resume() {
        dummyResponse?.completion()
    }
}
