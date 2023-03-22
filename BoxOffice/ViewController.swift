//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    var movie = BoxofficeInfo<MovieInfoObject>(interfaceValue: "20228555", apiType: .movie)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movie.search { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }


}

