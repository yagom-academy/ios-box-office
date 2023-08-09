//
//  MovieDetailViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/09.
//

protocol MovieDetailViewControllerUseCase {
    
}

final class MovieDetailViewControllerUseCaseImplementation: MovieDetailViewControllerUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    private let daumSearchRepository: DaumSearchRepository
    
    init(boxOfficeRepository: BoxOfficeRepository, daumSearchRepository: DaumSearchRepository) {
        self.boxOfficeRepository = boxOfficeRepository
        self.daumSearchRepository = daumSearchRepository
    }
}
