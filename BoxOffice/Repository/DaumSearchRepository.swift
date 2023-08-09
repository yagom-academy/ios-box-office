//
//  DaumSearchRepository.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/09.
//

import Foundation

protocol DaumSearchRepository {
    
}

final class DaumSearchRepositoryImplementation: DaumSearchRepository {
    private let sessionProvider: URLSessionProvider
    private let decoder: JSONDecoder
    
    init(sessionProvider: URLSessionProvider, decoder: JSONDecoder = JSONDecoder()) {
        self.sessionProvider = sessionProvider
        self.decoder = decoder
    }
}
