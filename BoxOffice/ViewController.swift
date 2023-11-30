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
        networkTest()
    }
    
    func networkTest() {
        networkManager.fetchMovie(complitionHandler: { boxOffice in
            boxOffice?.boxOfficeResult.dailyBoxOfficeList.forEach { dump($0) }
        })
        networkManager.fetchMovie { boxOffice in
            guard let a = boxOffice?.boxOfficeResult.dailyBoxOfficeList[0].movieCode else { return }
            self.networkManager.fetchMovieInformation(movieCode: a) { movie in
                dump(movie?.movieDetailResult.movieDetail.self)
            }
        }
    }
}

