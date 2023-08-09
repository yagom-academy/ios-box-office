//
//  DaumSearchRepository.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/09.
//

import Foundation

protocol DaumSearchRepository {
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

extension DaumSearchRepositoryImplementation {
    private func setUpRequestURL(_ baseURL: String,_ path: String, _ queryItems: [String: Any]) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        
        urlComponents.path += path
        urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents.url else { return nil }
        let urlRequest = URLRequest(url: url) // TODO : 중복 코드 사용
        
        return urlRequest
    }
}
