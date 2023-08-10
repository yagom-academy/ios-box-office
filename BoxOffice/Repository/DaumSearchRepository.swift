//
//  DaumSearchRepository.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

import Foundation

protocol DaumSearchRepository: CanMakeURLRequest {
    func fetchDaumImageSearchInformation(_ movieName: String, _ completionHandler: @escaping (Result<DaumSearchImageResult, APIError>) -> Void)
}

final class DaumSearchRepositoryImplementation: DaumSearchRepository {
    private let sessionProvider: URLSessionProvider
    private let decoder: JSONDecoder
    
    init(sessionProvider: URLSessionProvider, decoder: JSONDecoder = JSONDecoder()) {
        self.sessionProvider = sessionProvider
        self.decoder = decoder
    }
    
    func fetchDaumImageSearchInformation(_ movieName: String, _ completionHandler: @escaping (Result<DaumSearchImageResult, APIError>) -> Void) {
        let queryItem: [String: Any] = ["query": "\(movieName) 영화 포스터"]
        let header = "KakaoAK \(APIKey.daumSearch)"
        var urlRequest = setUpRequestURL(BaseURL.daumSearch, DaumSearchURLPath.image, queryItem)
        
        urlRequest?.setValue(header, forHTTPHeaderField: "Authorization")
        sessionProvider.requestData(urlRequest) { result in
            switch result {
            case .success(let data):
                self.decoder.decodeResponseData(data, completionHandler)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
