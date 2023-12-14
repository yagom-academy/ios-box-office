//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    private var networkManager = NetworkManager()
    var data = BoxOfficeData()
    var detail = MovieDetailData(value: "20190324")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfiiceData()
        movieDetailData()
    }
    
    func boxOfiiceData() {
        data.getBoxOfficeData { result in
            result.forEach { dump($0) }
        }
    }
    
    func movieDetailData() {
        detail.getMovieDetailData { movie in
            dump(movie)
        }
    }
}

