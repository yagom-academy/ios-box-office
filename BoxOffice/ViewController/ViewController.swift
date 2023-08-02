//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private let boxOfficeService = BoxOfficeService()
    private var boxOffice: BoxOffice?
    private var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateBackgroundColor()
        
        loadDailyBoxOfficeData()
    }
    
    private func configurateBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func loadDailyBoxOfficeData() {
        boxOfficeService.loadDailyBoxOfficeData(fetchBoxOffice)
    }
    
    private func fetchBoxOffice(_ result: Result<BoxOffice, NetworkManagerError>) {
        switch result {
        case .success(let boxOffice):
            print(boxOffice)
            self.boxOffice = boxOffice
            if let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList.first?.movieCode {
                boxOfficeService.loadMovieDetailData(movieCd: movieCode, fetchMovie)
            }
        case .failure(let error):
            print(error)
        }
    }

    private func fetchMovie(_ result: Result<Movie, NetworkManagerError>) {
        switch result {
        case .success(let movie):
            print(movie)
            self.movie = movie
        case .failure(let error):
            print(error)
        }
    }
}

