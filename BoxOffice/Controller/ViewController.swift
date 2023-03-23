//
//  ViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

final class ViewController: UIViewController {
    private var endPoint = EndPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNetworkManagerOfBoxOffice()
        NetworkManager.request(endPoint: endPoint, returnType: BoxOffice.self) {
            print($0)
            print("===")
        }
        
        setNetworkManagerOfMovieInformation()
        NetworkManager.request(endPoint: endPoint, returnType: MovieInformation.self) {
            print($0)
        }
    }
    
    private func setNetworkManagerOfBoxOffice() {
        endPoint.setEndPoint(method: .get , body: nil, baseURL: URLElement.dailyBoxofficeBaseURL, key: URLElement.key, targetDate: URLElement.targetDate)
    }
    
    private func setNetworkManagerOfMovieInformation() {
        endPoint.setEndPoint(method: .get, body: nil, baseURL: URLElement.movieInformationBaseURL, key: URLElement.key, movieCode: URLElement.movieCode)
    }
}
