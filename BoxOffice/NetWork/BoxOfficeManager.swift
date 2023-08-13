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

    private func decodeData(_ type: Element.Type, from data: Data) -> Element? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
    
    func fetchData(handler: @escaping (Result<Element, BoxOfficeError>) -> Void) {
        guard let url = URL(apiType: apiType) else {
            handler(.failure(.invalidURL))
            return
        }

        model.getRequest(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleSuccess(data: data, handler: handler)
            case .failure(let error):
                handler(.failure(error))
            }
        }
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
