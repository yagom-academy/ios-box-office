//
//  MovieDetailViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

protocol MovieDetailViewControllerUseCase {
    var delegate: MovieDetailViewControllerUseCaseDelegate? { get set }
    func fetchMovieDetailInformation(_ movieCode: String)
    func fetchMovieDetailImage(_ movieName: String)
}

final class MovieDetailViewControllerUseCaseImplementation: MovieDetailViewControllerUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    private let daumSearchRepository: DaumSearchRepository
    weak var delegate: MovieDetailViewControllerUseCaseDelegate?
    
    init(boxOfficeRepository: BoxOfficeRepository, daumSearchRepository: DaumSearchRepository) {
        self.boxOfficeRepository = boxOfficeRepository
        self.daumSearchRepository = daumSearchRepository
    }
    
    func fetchMovieDetailInformation(_ movieCode: String) {
        boxOfficeRepository.fetchMovieDetailInformation(movieCode) { result in
            switch result {
            case .success(let result):
                let movieDetailInformationDTO = self.setUpMovieDetailInformationDTO(result.movieInformationResult.movieInformation)
                
                self.delegate?.completeFetchMovieDetailInformation(movieDetailInformationDTO)
            case .failure(let error):
                self.delegate?.failFetchMovieDetailInformation(error.errorDescription)
            }
        }
    }
    
    func fetchMovieDetailImage(_ movieName: String) {
        daumSearchRepository.fetchDaumImageSearchInformation(movieName) { result in
            switch result {
            case .success(let result):
                guard let movieDetailImageDTO = self.setUpMovieDetailImageDTO(result) else {
                    // TODO : error Case 추가 (API Error)
                    return
                }
                
                self.delegate?.completeFetchMovieDetailImage(movieDetailImageDTO)
            case .failure(let error):
                self.delegate?.failFetchMovieDetailImage(error.errorDescription)
            }
        }
    }
}

extension MovieDetailViewControllerUseCaseImplementation {
    private func setUpMovieDetailImageDTO(_ daumSearchImageResult: DaumSearchImageResult) -> MovieDetailImageDTO? {
        guard let imageInformation = daumSearchImageResult.documents.first else { return nil }
        let movieDetailImageDTO = MovieDetailImageDTO(imageURL: imageInformation.imageURL,
                                            width: imageInformation.width,
                                            height: imageInformation.height)

        return movieDetailImageDTO
    }
    
    private func setUpMovieDetailInformationDTO(_ movieDetailResult: MovieDetail) -> MovieDetailInformationDTO {
        let movieDetailInformationDTO = MovieDetailInformationDTO(showTime: movieDetailResult.showTime,
                                                               productYear: movieDetailResult.productYear,
                                                               openDate: movieDetailResult.openDate,
                                                               nations: movieDetailResult.nations,
                                                               genres: movieDetailResult.genres,
                                                               directors: movieDetailResult.directors,
                                                               movieActors: movieDetailResult.actors,
                                                               audits: movieDetailResult.audits)
        
        return movieDetailInformationDTO
    }
}
