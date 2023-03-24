//
//  BoxOfficeEndPoint.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

struct BoxOfficeEndPoint: NetworkRequestable {
    var urlRequest: URLRequest?
    var url: URL?
        
    mutating func configureURLRequest(method: HttpMethod, body: Data?) {
        guard let url = self.url else {
            print(NetworkError.invalidURL)
            return
        }
        urlRequest = .init(url: url)
        urlRequest?.httpMethod = method.description
        urlRequest?.httpBody = body
    }
}
