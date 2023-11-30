//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    var jsonData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient().fetchData(dataType: .dailyBoxOffice, movieCode: nil) { [self] data in
            if let data = data {
                self.jsonData = data
                print(jsonData)
            }
        }
    }


}

