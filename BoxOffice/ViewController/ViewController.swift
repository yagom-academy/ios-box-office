//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    let boxOfficeService = BoxOfficeService()
    var boxOffice: BoxOffice?
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDailyBoxOfficeData()
    }
    
    private func loadDailyBoxOfficeData() {
        boxOfficeService.loadDailyBoxOfficeData(fetchBoxOffice)
    }
    
    private func fetchBoxOffice(_ boxOffice: BoxOffice) {
        print(boxOffice)
        self.boxOffice = boxOffice
        if let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList.first?.movieCode {
            boxOfficeService.loadMovieDetailData(movieCd: movieCode, fetchMovie)
        }
    }

    private func fetchMovie(_ movie: Movie) {
        print(movie)
        self.movie = movie
    }
}

