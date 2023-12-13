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
        
        APIClient().fetchData(fileType: FileType.json, date: nil) { (result: Result<BoxOffice, Error>) in
            switch result {
            case .success(let boxOffice):
                print(boxOffice)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

