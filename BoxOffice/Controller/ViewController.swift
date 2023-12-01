//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    var jsonData: Data?
    let decoder = JSONDecoder()
    var boxOfficeData: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient().fetchData(dataType: .dailyBoxOffice, value: "20231130") { [self] data in
            if let data = data {
                self.jsonData = data
                print(jsonData)
                
                boxOfficeData = try? decoder.decode(BoxOffice.self, from: data)
                guard boxOfficeData != nil else {
                    return
                }
                print(boxOfficeData)
            }
        }
    }


}

