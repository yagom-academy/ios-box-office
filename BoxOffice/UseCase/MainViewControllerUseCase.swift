//
//  MainViewControllerUseCase.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/31.
//

import Foundation

protocol MainViewControllerUseCase {
    var delegate: MainViewControllerUseCaseDelegate? { get set }
    func fetchDailyBoxOffice()
    func fetchMovieDetailInformation()
    func fetchDailyBoxOfficeForTest()
}

protocol MainViewControllerUseCaseDelegate: AnyObject {
    func completeFetchMovieDetailInformation(_ movieInformationDTOList: [MovieInformationDTO])
}

final class MainViewControllerUseCaseImpl: MainViewControllerUseCase {
    private let sessionProvider: URLSessionProvider
    weak var delegate: MainViewControllerUseCaseDelegate?
    
    init(_ sessionProvider: URLSessionProvider) {
        self.sessionProvider = sessionProvider
    }
    
    func fetchDailyBoxOffice() {
        let queryItems: [String: Any] = [
            "key": APIKey.boxOffice,
            "targetDt": "20230720"
        ]

        let requestURL = setUpRequestURL(BaseURL.boxOffice, BoxOfficeURLPath.daily, queryItems)

        sessionProvider.requestData(requestURL) { (result: Result<APIResponse<BoxOfficeResult>, APIError>) in
            switch result {
            case .success(let result):
                let movieInformationDTOList = self.setUpMovieInformationDTOList(result.data.daily.dailyBoxOfficeList)
                
                self.delegate?.completeFetchMovieDetailInformation(movieInformationDTOList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMovieDetailInformation() {
        let queryItems: [String: Any] = [
            "key": APIKey.boxOffice,
            "movieCd": "20218541"
        ]
        
        let requestURL = setUpRequestURL(BaseURL.boxOffice, BoxOfficeURLPath.movieDetail, queryItems)
        
        sessionProvider.requestData(requestURL) { (result: Result<APIResponse<MovieDetailResult>, APIError>) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDailyBoxOfficeForTest() {
        let queryItems: [String: Any] = [
            "key": APIKey.boxOffice,
            "targetDt": ""
        ]

        let requestURL = setUpRequestURL(BaseURL.boxOffice, BoxOfficeURLPath.daily, queryItems)

        sessionProvider.requestData(requestURL) { (result: Result<APIResponse<BoxOfficeResult>, APIError>) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
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
