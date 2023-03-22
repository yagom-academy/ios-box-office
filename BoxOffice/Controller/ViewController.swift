//
//  ViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

final class ViewController: UIViewController {
    private let networkManager = NetworkManager()
    
    lazy private var dailyBoxofficeURL = DailyBoxOfficeURL(baseURL: URLElement.dailyBoxofficeBaseURL, key: URLElement.key, targetDate: URLElement.targetDate)
    lazy private var movieInformationURL = MovieInfomationURL(baseURL: URLElement.movieInformationBaseURL, key: URLElement.key, movieCode: URLElement.movieCode)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.request(method: .get, url: dailyBoxofficeURL, body: nil, returnType: BoxOffice.self) {
            print($0)
            print("===")
        }
        
        networkManager.request(method: .get, url: movieInformationURL, body: nil, returnType: MovieInformation.self) {
            print($0)
            print("===")
        }
    }
}

fileprivate enum URLElement {
    static let dailyBoxofficeBaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let movieInformationBaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    static let key = "f5eef3421c602c6cb7ea224104795888"
    static let targetDate = "20230321"
    static let movieCode = "20124079"
}
