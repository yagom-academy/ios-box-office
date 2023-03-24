//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private var boxOfficeEndPoint = BoxOfficeEndPoint()
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNetworkManagerOfBoxOffice()
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: BoxOffice.self) {
            print($0)
            print("===")
        }
        
        setNetworkManagerOfMovieInformation()
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: MovieInformation.self) {
            print($0)
        }
    }
    
    private func setNetworkManagerOfBoxOffice() {
        boxOfficeEndPoint.configureEndPoint(method: .get , body: nil, baseURL: URLElement.dailyBoxofficeBaseURL, key: URLElement.key, targetDate: URLElement.targetDate)
    }
    
    private func setNetworkManagerOfMovieInformation() {
        boxOfficeEndPoint.configureEndPoint(method: .get, body: nil, baseURL: URLElement.movieInformationBaseURL, key: URLElement.key, movieCode: URLElement.movieCode)
    }
}
