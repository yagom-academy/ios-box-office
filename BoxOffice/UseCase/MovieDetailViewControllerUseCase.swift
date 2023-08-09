//
//  MovieDetailViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/09.
//

protocol MovieDetailViewControllerUseCase {
    var delegate: MovieDetailViewControllerUseCaseDelegate? { get set }
}

final class MovieDetailViewControllerUseCaseImplementation: MovieDetailViewControllerUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    private let daumSearchRepository: DaumSearchRepository
    weak var delegate: MovieDetailViewControllerUseCaseDelegate?
    
    init(boxOfficeRepository: BoxOfficeRepository, daumSearchRepository: DaumSearchRepository) {
        self.boxOfficeRepository = boxOfficeRepository
        self.daumSearchRepository = daumSearchRepository
    }
    
    func fetchDetailMovieInformation(_ movieCode: String) {
        boxOfficeRepository.fetchMovieDetailInformation(movieCode) { result in
            switch result {
            case .success(let result):
                let movieDetailInformation = self.setUpMovieDetailInformationDTO(result.movieInformationResult.movieInformation)
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDetailMovieImage(_ movieName: String) {
        daumSearchRepository.fetchDaumImageSearchInformation(movieName) { result in
            switch result {
            case .success(let result):
                guard let movieDetailImageDTO = self.setUpMovieDetailImageDTO(result) else {
                    return
                }
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieDetailViewControllerUseCaseImplementation {
    private func setUpMovieDetailImageDTO(_ daumSearchImageResult: DaumSearchImageResult) -> MovieDetailImageDTO? {
        guard let imageInformation = daumSearchImageResult.documents.first else { return nil }
        let movieDetailDTO = MovieDetailImageDTO(imageURL: imageInformation.imageURL,
                                            width: imageInformation.width,
                                            height: imageInformation.height)

        return movieDetailDTO
    }
    
    private func setUpMovieDetailInformationDTO(_ movieDetailResult: MovieDetail) -> MovieDetailInformationDTO {
        let movieDetailInformation = MovieDetailInformationDTO(showTime: movieDetailResult.showTime,
                                                               productYear: movieDetailResult.productYear,
                                                               openDate: movieDetailResult.openDate,
                                                               nations: movieDetailResult.nations,
                                                               genres: movieDetailResult.genres,
                                                               directors: movieDetailResult.directors,
                                                               actors: movieDetailResult.actors,
                                                               audits: movieDetailResult.audits)
        
        return movieDetailInformation
    }
}
