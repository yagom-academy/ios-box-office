//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchMovie(complitionHandler: { boxOffice in
            boxOffice?.boxOfficeResult.dailyBoxOfficeList.forEach { dump($0) }
        })
        networkManager.fetchMovieInformation(movieCode: "20124079") { movie in
            dump(movie?.movieDetailResult.movieDetail.self)
        }
    }
                                  
}

