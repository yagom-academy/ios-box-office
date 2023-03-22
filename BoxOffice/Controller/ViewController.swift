//
//  ViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import UIKit

class ViewController: UIViewController {
    var boxOffice: BoxOffice? = nil
    let networking = NetworkManager()
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.networking.fetchData(url: URLMaker.dailyBoxOffice.url, type: BoxOffice.self) { result in
            switch result {
            case .success(let boxOffice):
                self.boxOffice = boxOffice
                print(self.boxOffice?.result.dailyBoxOfficeList.first)
            case .failure(let error):
                print(error)
                return
            }
        }
        
        self.networking.fetchData(url: URLMaker.movieInfo.url, type: Movie.self) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
                print(self.movie?.result.movieInfo.movieName)
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}
