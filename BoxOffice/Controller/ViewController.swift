//
//  ViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

final class ViewController: UIViewController {
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNetworkManagerOfBoxOffice()
        networkManager.request(returnType: BoxOffice.self) {
            print($0)
            print("===")
        }
        
        setNetworkManagerOfMovieInformation()
        networkManager.request(returnType: MovieInformation.self) {
            print($0)
        }
    }
    
    private func setNetworkManagerOfBoxOffice() {
        networkManager.receiveParameter(baseURL: URLElement.dailyBoxofficeBaseURL, key: URLElement.key, targetDate: URLElement.targetDate, nationCode: .foreign)
        networkManager.setUrlRequest(method: .get, body: nil)
    }
    
    private func setNetworkManagerOfMovieInformation() {
        networkManager.receiveParameter(baseURL: URLElement.movieInformationBaseURL, key: URLElement.key, movieCode: URLElement.movieCode)
        networkManager.setUrlRequest(method: .get, body: nil)
    }
}

enum URLElement {
    static let dailyBoxofficeBaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let movieInformationBaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    static let key = "f5eef3421c602c6cb7ea224104795888"
    static let targetDate = "20230321"
    static let movieCode = "20124079"
}
