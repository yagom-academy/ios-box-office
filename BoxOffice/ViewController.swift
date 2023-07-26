//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {
    var networkManager: NetworkingManager = NetworkingManager()
    let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=%@&targetDt=20120101"
    
    var receivedData: BoxOfficeEntity?
    
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
        guard let newData: BoxOfficeEntity = DecodingManager.shared.decode(data) else {
            return
        }
        
        receivedData = newData
    }
}
