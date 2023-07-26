//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {
    var networkManager: NetworkingManager = NetworkingManager()
    let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=%@&movieCd=20124079"
    
    var receivedData: MovieDetailEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        
        if let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String {
            networkManager.load(String(format: url, keyPath))
        }
    }
}


extension ViewController: NetworkingDelegate {
    func setReceivedData(_ data: Data) {
        guard let newData: MovieDetailEntity = DecodingManager.shared.decode(data) else {
            return
        }
        
        receivedData = newData
    }
}
