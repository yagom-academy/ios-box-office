//
//  ViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//


import UIKit

class ViewController: UIViewController {
    let decoder = DecodeManager<BoxOffice>()
    let fileName = "box_office_sample"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boxOfficeResult = decoder.decodeJSON(fileName: fileName)
        
        switch boxOfficeResult {
        case .success(let result):
            print(result.boxOfficeResult.dailyBoxOfficeList)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

}

