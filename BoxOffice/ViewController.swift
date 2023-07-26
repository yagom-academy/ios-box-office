//
//  ViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {
    let networkManager: NetworkingManager = NetworkingManager()
    let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=%@&targetDt=20120101"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String {
            networkManager.load(String(format: url, keyPath))
        }
    }
}
