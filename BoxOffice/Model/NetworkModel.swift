//
//  BoxofficeInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import Foundation

class BoxofficeInfo<T: Decodable> {
    private let apiType: APIType
    private let model: NetworkModel
    private var task: URLSessionDataTask?
    
    init(apiType: APIType, model: NetworkModel) {
        self.apiType = apiType
        self.model = model
    }
    
    private func decodeData(_ data: Data) -> T? {
        do {
            let decodingData = try JSONDecoder().decode(T.self, from: data)
            return decodingData
        } catch {
            return nil
        }
    }
    
    func fetchData(handler: @escaping (Result<T, BoxofficeError>) -> Void) {
        guard let url = apiType.receiveUrl() else {
            handler(.failure(.urlError))
            return
        }
        
        task = model.search(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                guard let decodingData = self?.decodeData(data) else {
                    handler(.failure(.decodingError))
                    return
                }
                handler(.success(decodingData))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func cancelTask() {
        task?.cancel()
    }
    
}

struct NetworkModel {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func search(url: URL, completion: @escaping (Result<Data, BoxofficeError>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.sessionError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            
            guard let mimeType = httpResponse.mimeType,
                  mimeType == "application/json",
                  let data = data else {
                completion(.failure(.incorrectDataTypeError))
                return
            }
            completion(.success(data))
        }
        
        task.resume()
        
        return task
    }
}
