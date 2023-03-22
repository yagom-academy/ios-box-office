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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.request(method: .get, url: dailyBoxofficeURL, body: nil, returnType: BoxOffice.self) {
            print($0)
        }
    }
}
