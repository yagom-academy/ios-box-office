//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchMovie(complitionHandler: { boxOffice in
            boxOffice?.boxOfficeResult.dailyBoxOfficeList.forEach { print($0) }
        })
    }
                                  
}

