//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    let manager = NetworkManager()
    var movieArray = [DailyBoxOfficeItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test1()
    }
    
    func test1() {
        manager.fetchMovie { d in
            print(d?.boxOfficeResult.dailyBoxOfficeList)
        }
    }
}

