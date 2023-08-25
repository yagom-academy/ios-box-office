//
//  NetworkService.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//
import UIKit

protocol NetworkService {
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, BoxOfficeError>) -> Void)
    func fetchImage(from url: URL, completion: @escaping (Result<(UIImage, CGSize), BoxOfficeError>) -> Void)
}

extension NetworkService {
    func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
        guard error == nil else {
            completion(.failure(.failureRequest))
            return
        }

        guard let response = response,
              let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(.failureResponse))
            return
        }

        guard let data = data else {
            completion(.failure(.invalidDataType))
            return
        }

        completion(.success(data))
    }
}
