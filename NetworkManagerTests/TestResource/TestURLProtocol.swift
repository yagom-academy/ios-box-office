//
//  TestURLProtocol.swift
//  BoxOffice
//
//  Created by jyubong on 12/1/23.
//

import Foundation

final class TestURLProtocol: URLProtocol {
    static var loadingHandler: ((URLRequest) -> (Data?, URLResponse?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = TestURLProtocol.loadingHandler else { return }
        
        let (data, response, error) = handler(request)
        
        if let data = data, let response = response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
