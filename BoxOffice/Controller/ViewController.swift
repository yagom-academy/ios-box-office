//
//  ViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

class ViewController: UIViewController {
    let networkManager = NetworkManager()
    let dailyBoxofficeURL = DailyBoxOfficeURL(targetDate: "20230320")
    
    let movieURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    let key = "f5eef3421c602c6cb7ea224104795888"
    let code = "20124079"
    
    lazy var movieInformationURL = MovieInfomationURL(urlComponents: movieURL, key: key, movieCode: code)

    override func viewDidLoad() {
        super.viewDidLoad()
        print(movieInformationURL.url!)
        networkManager.request(method: .get, url: movieInformationURL, body: nil, returnType: Welcome.self) {
            print($0)
        }
    }
}
