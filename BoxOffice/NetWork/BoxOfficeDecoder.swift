//
//  BoxOfficeDecoder.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

final class BoxOfficeDecoder<Element: Decodable> {
    private let apiType: KobisAPIType
    private let model: NetworkingProtocol
    private var task: URLSessionDataTask?

    init(apiType: KobisAPIType, model: NetworkingProtocol) {
        self.apiType = apiType
        self.model = model
    }

    private func decodeData(_ type: Element.Type, from data: Data) -> Element? {
        let decoder: JSONDecoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }

    func fetchData(handler: @escaping (Result<Element, BoxOfficeError>) -> Void) {
        guard let url = apiType.receiveUrl() else {
            handler(.failure(.urlError))
            return
        }

        task = model.getRequest(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                guard let decodingData = self?.decodeData(Element.self, from: data) else {
                    handler(.failure(.decodingFail))
                    return
                }
                handler(.success(decodingData))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
