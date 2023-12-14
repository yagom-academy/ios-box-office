//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    private let data = BoxOfficeData()
    private let detail = MovieDetailData(value: "20190324")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfiiceData()
        movieDetailData()
    }
    
    private func boxOfiiceData() {
        data.getBoxOfficeData { result in
            result.forEach { dump($0) }
        }
    }
    
    private func movieDetailData() {
        detail.getMovieDetailData { movie in
            dump(movie)
        }
    }
}

