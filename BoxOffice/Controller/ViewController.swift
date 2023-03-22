//
//  ViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

class ViewController: UIViewController {
    let networkManager = NetworkManager()
    
    lazy var dailyBoxofficeURL = DailyBoxOfficeURL(baseURL: dailyBoxofficeBaseURL, key: key, targetDate: targetDate)
    lazy var movieInformationURL = MovieInfomationURL(baseURL: movieURL, key: key, movieCode: movieCode)
    
    let dailyBoxofficeBaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    let targetDate = "20230321"
    let movieURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    let key = "f5eef3421c602c6cb7ea224104795888"
    let movieCode = "20124079"
    
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
