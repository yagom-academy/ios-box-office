//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    var boxOffice: BoxOffice?
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        
        networkManager.loadDailyBoxOfficeData(fetchBoxOffice)
        
        func fetchBoxOffice(_ boxOffice: BoxOffice) {
            print(boxOffice)
            self.boxOffice = boxOffice
            if let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList.first?.movieCode {
                networkManager.loadMovieDetailData(movieCd: movieCode, fetchMovie)
            }
        }
    
        func fetchMovie(_ movie: Movie) {
            print(movie)
            self.movie = movie
        }
    }
}

