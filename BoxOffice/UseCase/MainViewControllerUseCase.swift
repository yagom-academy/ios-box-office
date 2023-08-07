//
//  MainViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/31.
//

import Foundation

protocol MainViewControllerUseCase {
    var delegate: MainViewControllerUseCaseDelegate? { get set }
    func fetchDailyBoxOffice(targetDate: String)
}

final class MainViewControllerUseCaseImplementation: MainViewControllerUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    weak var delegate: MainViewControllerUseCaseDelegate?
    
    init(boxOfficeRepository: BoxOfficeRepository) {
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    func fetchDailyBoxOffice(targetDate: String) {
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
}

//MARK: - Private
extension MainViewControllerUseCaseImplementation {
    private func setUpMovieInformationDTOList(_ dailyBoxOfficeMovieInformationList: [MovieInformation]) -> [MovieInformationDTO] {
        let movieInformationDTOList = dailyBoxOfficeMovieInformationList.map { movieInformation in
            MovieInformationDTO(rank: movieInformation.rank,
                                rankInten: movieInformation.rankInten,
                                oldAndNew: movieInformation.rankOldAndNew,
                                movieName: movieInformation.movieName,
                                audienceCount: movieInformation.audienceCount,
                                audienceAccumulate: movieInformation.audienceAccumulate)
        }
        
        return movieInformationDTOList
    }
}
