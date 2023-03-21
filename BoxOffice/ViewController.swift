//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    var movie = DailyBoxoffice(targetDate: "20230320")
    var movieData: DailyBoxofficeObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movie.search { result in
            switch result {
            case .success(let data):
                self.movieData = data
                print(self.movieData)
            case .failure(let error):
                print(error)
            }
        }
    }


}

