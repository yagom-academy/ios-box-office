//
//  ViewController.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.getDailyBoxOfficeData()
    }
}
