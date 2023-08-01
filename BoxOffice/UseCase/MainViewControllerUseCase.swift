//
//  MainViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/31.
//

import Foundation

protocol MainViewControllerUseCase {
    var delegate: MainViewControllerUseCaseDelegate? { get set }
    func fetchDailyBoxOffice(isTest: Bool)
    func fetchMovieDetailInformation()
}

final class MainViewControllerUseCaseImpl: MainViewControllerUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    weak var delegate: MainViewControllerUseCaseDelegate?
    
    init(boxOfficeRepository: BoxOfficeRepository) {
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    func fetchDailyBoxOffice(isTest: Bool) {
        let targetDate = isTest ? "" : "20230720"
        
        boxOfficeRepository.fetchDailyBoxOffice(targetDate) { result in
            switch result {
            case .success(let result):
                let movieInformationDTOList = self.setUpMovieInformationDTOList(result.daily.dailyBoxOfficeList)

                self.delegate?.completeFetchDailyBoxOfficeInformation(movieInformationDTOList)
            case .failure(let error):
                self.delegate?.failFetchDailyBoxOfficeInformation(error.errorDescription)
            }
        }
    }
    
    func fetchMovieDetailInformation() {
        let movieCode = "20218541"
        boxOfficeRepository.fetchMovieDetailInformation(movieCode) { result in
            switch result {
            case .success(let result):
                self.delegate?.completeFetchMovieDetailInformation(result)
            case .failure(let error):
                self.delegate?.failFetchMovieDetailInformaion(error.errorDescription)
            }
        }
    }
}

//MARK: - Private
extension MainViewControllerUseCaseImpl {
    private func setUpRequestURL(_ baseURL: String,_ path: String, _ queryItems: [String: Any]) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        
        urlComponents.path += path
        urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        return urlComponents.url
    }
    
    private func setUpMovieInformationDTOList(_ dailyBoxOfficeMovieInformationList: [MovieInformation]) -> [MovieInformationDTO] {
        var movieInformationDTOList = [MovieInformationDTO]()
        
        dailyBoxOfficeMovieInformationList.forEach {
            let movieInformationDTO = MovieInformationDTO(rank: $0.rank,
                                                          rankInten: $0.rankInten,
                                                          OldAndNew: $0.rankOldAndNew,
                                                          movieName: $0.movieName,
                                                          audienceCount: $0.audienceCount,
                                                          audienceAccumulate: $0.audienceAccumulate)
            
            movieInformationDTOList.append(movieInformationDTO)
        }
        
        return movieInformationDTOList
    }
}
