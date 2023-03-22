//
//  ViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = BoxOfficeEndPoint.fetchDailyBoxOffice(targetDate: "20120101")
        
        NetworkManager.shared.getData(url: a.createURL(), type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }


}

