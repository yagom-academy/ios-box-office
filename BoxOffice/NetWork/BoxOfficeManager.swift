//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

final class BoxOfficeManager<Element: Decodable> {
    private let apiType: KobisAPIType
    private let model: NetworkService

    init(apiType: KobisAPIType, model: NetworkService) {
        self.apiType = apiType
        self.model = model
    }
    
    func fetchData(handler: @escaping (Result<Element, BoxOfficeError>) -> Void) {
        guard let url = URL(apiType: apiType),
              let request = makeRequest(url: url) else {
            handler(.failure(.invalidURL))
            return
        }

        model.fetchData(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleSuccess(data: data, handler: handler)
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    private func makeRequest(url: URL) -> URLRequest? {
        var urlRequest = URLRequest(url: url)
        
        guard let header = apiType.header else {
            return urlRequest
        }
        
        urlRequest.addValue(header, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    private func handleSuccess(data: Data, handler: @escaping (Result<Element, BoxOfficeError>) -> Void) {
        let dataDecoder = DefaultDecodingService()
        guard let decodingData = dataDecoder.decode(Element.self, from: data) else {
            handler(.failure(.failureDecoding))
            return
        }
        
        handler(.success(decodingData))
    }
}
