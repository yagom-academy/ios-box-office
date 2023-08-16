//
//  MovieDetailViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//
import Foundation

protocol MovieDetailViewControllerUseCase {
    var delegate: MovieDetailViewControllerUseCaseDelegate? { get set }
    var movieName: String { get }
    func fetchMovieDetailInformation()
}

final class MovieDetailViewControllerUseCaseImplementation: MovieDetailViewControllerUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    private let daumSearchRepository: DaumSearchRepository
    private let movieCode: String
    let movieName: String
    weak var delegate: MovieDetailViewControllerUseCaseDelegate?
    
    init(boxOfficeRepository: BoxOfficeRepository, daumSearchRepository: DaumSearchRepository, movieName: String, movieCode: String) {
        self.boxOfficeRepository = boxOfficeRepository
        self.daumSearchRepository = daumSearchRepository
        self.movieName = movieName
        self.movieCode = movieCode
    }
    
    func fetchMovieDetailInformation() {
        DispatchQueue.global().async {
            let dispatchGroup = DispatchGroup()
            
            self.fetchMovieDetailDescription(dispatchGroup)
            self.fetchMovieDetailImage(dispatchGroup)
            
            let status = dispatchGroup.wait(timeout: .now() + 15)
            
            if status == .success {
                self.delegate?.completeFetchMovieDetailInformation()
            } else {
                let error = APIError.requestTimeOut
                
                self.delegate?.failFetchMovieDetailInformation(error.errorDescription)
            }
        }
    }
    
    private func fetchMovieDetailDescription(_ dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        self.boxOfficeRepository.fetchMovieDetailInformation(self.movieCode) { result in
            dispatchGroup.leave()
            switch result {
            case .success(let result):
                let movieDetailInformationDTO = self.setUpMovieDetailInformationDTO(result.movieInformationResult.movieInformation)
                
                self.delegate?.completFetchMovieDetailDescription(movieDetailInformationDTO)
            case .failure(let error):
                self.delegate?.failFetchMovieDetailInformation(error.errorDescription)
            }
        }
    }
    
    private func fetchMovieDetailImage(_ dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        self.daumSearchRepository.fetchDaumImageSearchInformation(self.movieName) { result in
            switch result {
            case .success(let result):
                guard let imageInformation = result.documents.first else {
                    let error = APIError.dataTransferFail
                    
                    self.delegate?.failFetchMovieDetailInformation(error.errorDescription)
                    return
                }
                
                self.fetchImageFromURL(dispatchGroup, imageInformation)
            case .failure(let error):
                self.delegate?.failFetchMovieDetailInformation(error.errorDescription)
            }
        }
    }
    
    private func fetchImageFromURL(_ dispatchGroup: DispatchGroup, _ imageInformation: DaumSearchImageResult.ImageInformation) {
        self.daumSearchRepository.fetchImageDataFromURL(imageInformation.imageURL) { result in
            dispatchGroup.leave()
            switch result {
            case .success(let data):
                let movieDetailImageDTO = self.setUpMovieDetailImageDTO(imageInformation, data)
                
                self.delegate?.completeFetchMovieDetailImage(movieDetailImageDTO)
            case .failure(let error):
                self.delegate?.failFetchMovieDetailInformation(error.errorDescription)
            }
        }
    }
}

extension MovieDetailViewControllerUseCaseImplementation {
    private func setUpMovieDetailImageDTO(_ imageInformation: DaumSearchImageResult.ImageInformation, _ imageData: Data) -> MovieDetailImageDTO {
        let movieDetailImageDTO = MovieDetailImageDTO(imageData: imageData,
                                            width: imageInformation.width,
                                            height: imageInformation.height)

        return movieDetailImageDTO
    }
    
    private func setUpMovieDetailInformationDTO(_ movieDetailResult: MovieDetail) -> MovieDetailInformationDTO {
        let movieDetailInformationDTO = MovieDetailInformationDTO(showTime: movieDetailResult.showTime,
                                                               productYear: movieDetailResult.productYear,
                                                               openDate: movieDetailResult.openDate,
                                                                nations: movieDetailResult.nations.map { $0.nationName },
                                                                  genres: movieDetailResult.genres.map { $0.genreName },
                                                                  directors: movieDetailResult.directors.map { $0.peopleName },
                                                                  movieActors: movieDetailResult.actors.map { $0.peopleName },
                                                                  watchGrade: movieDetailResult.audits.first?.watchGradeName ?? "")
        
        return movieDetailInformationDTO
    }
}
