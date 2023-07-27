//
//  MainViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 13/01/23.
//

import UIKit

final class MainViewController: UIViewController, CanShowNetworkFailAlert {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        requestMovieDailyInformation()
        requestMovieDetailInformation()
        
    }
}

// MARK: - NetworkRequests
extension MainViewController {
    private func requestMovieDetailInformation() {
        let queryItems: [String: Any] = [
            "key": NetworkKey.boxOffice,
            "movieCd": "202185411"
        ]
        
        let request = APIRequest(baseURL: BaseURL.boxOffice, path: BoxOfficeURLPath.movieDetail, queryItems: queryItems)
        
        Networking.dataTask(request) { (result: APIResult<MovieDetailResult>) in
            switch result {
            case .success(let result):
                print(result)
            case .fauilure(let error):
                DispatchQueue.main.async {
                    self.showNetworkFailAlert(message: error.description)
                }
                
                print(error)
            }
        }
    }
    
//    private func requestMovieDailyInformation() {
//        let queryItems: [String: Any] = [
//            "key": NetworkKey.boxOffice,
//            "targetDt": "20230720"
//        ]
//
//        let request = APIRequest(baseURL: BaseURL.boxOffice, path: BoxOfficeURLPath.daily, queryItems: queryItems)
//
//        Networking.dataTask(request) { (result: APIResult<BoxOfficeResult>) in
//            switch result {
//            case .success(let result):
//                print(result)
//            case .fauilure(let error):
//                print(error)
//            }
//        }
//    }
}
