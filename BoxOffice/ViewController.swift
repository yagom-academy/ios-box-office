//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {
    var networkingManager: NetworkingManager?
    let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=%@&movieCd=20124079"
    
    var receivedData: MovieDetailEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNetwork()
        loadData()
    }
    
    private func setUpNetwork() {
        let session = {
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = true
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        }()
        
        networkingManager = NetworkingManager(session)
    }
    
    private func loadData() {
        if let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String {
            networkingManager?.load(String(format: url, keyPath)) { [weak self] (result: Result<Data, BoxOfficeError>) in
                switch result {
                case .success(let data):
                    guard let decodedData: MovieDetailEntity = DecodingManager.shared.decode(data) else {
                        return
                    }
                    self?.receivedData = decodedData
                case .failure(let error):
                    print(error.description)
                }
            }
        }
    }
}

