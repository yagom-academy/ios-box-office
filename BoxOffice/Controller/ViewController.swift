//
//  ViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    var dailyBoxOfficeAPI = DailyBoxOfficeAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyBoxOfficeAPI.loadDailyBoxOffice()
    }
}
