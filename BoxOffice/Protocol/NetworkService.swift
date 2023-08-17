//
//  NetworkService.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//
import Foundation

protocol NetworkService {
    init(session: URLSession)
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, BoxOfficeError>) -> Void)
}
