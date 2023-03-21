//
//  ViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    let networkManager = NetworkManager()
    let dailyBoxofficeURL = DailyBoxOfficeURL(targetDate: "20230320")

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchData(dailyBoxofficeURL, returnType: BoxOffice.self)
    }
    
}
