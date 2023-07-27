//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        
        func printBoxOffice(_ boxOffice: BoxOffice) {
            print(boxOffice)
        }
        
        networkManager.loadData(printBoxOffice)
    }


}

