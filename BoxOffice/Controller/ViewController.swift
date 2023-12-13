//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yesterday = Date().yesterday
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.view.backgroundColor = .white
        self.navigationItem.title = formatter.string(from: yesterday)
        

        
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

