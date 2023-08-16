//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

import Foundation

struct NetworkManager {
    private let boxOfficeDataCompletion: (Result<Data, NetworkError>) -> Void = { result in
        switch result {
        case .success(let data):
            guard let decodedData = BoxOfficeData.decode(data: data) else {
                return
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private let movieInformationCompletion: (Result<Data, NetworkError>) -> Void = { result in
        switch result {
        case .success(let data):
            guard let decodedData = MovieInformation.decode(data: data) else {
                return
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    enum completion {
        case boxOfficeData
        case movieInformation
        
        var handler: (Result<Data, NetworkError>) -> Void {
            switch self {
            case .boxOfficeData:
                return NetworkManager().boxOfficeDataCompletion
            case .movieInformation:
                return NetworkManager().movieInformationCompletion
            }
        }
    }
    
    func configureRequest(url: URL, method: String = HTTPMethod.get.typeName) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        return request
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.dataTaskFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseCasting))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatus))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
