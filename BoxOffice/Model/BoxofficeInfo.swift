//
//  BoxofficeInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/28.
//

import Foundation

class BoxofficeInfo<T: Decodable> {
    private let apiType: APIType
    private let model: NetworkingProtocol
    private var task: URLSessionDataTask?
    private var isRunningOnlyOneTask: Bool
    
    init(apiType: APIType, model: NetworkingProtocol, isRunningOnlyOneTask: Bool = false) {
        self.apiType = apiType
        self.model = model
        self.isRunningOnlyOneTask = isRunningOnlyOneTask
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
        
        if isRunningOnlyOneTask {
            cancelTask()
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
