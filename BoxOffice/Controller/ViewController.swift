//
//  ViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    var officeData: BoxOfficeResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func parseData() {
        DataManager.parse()
    }

}

