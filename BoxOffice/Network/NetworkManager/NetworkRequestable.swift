//
//  NetworkRequestable.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

import Foundation

protocol NetworkRequestable {
    func request<element: Decodable>(returnType: element.Type, completion: @escaping (Result<element, NetworkError>) -> Void)
}
