//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


