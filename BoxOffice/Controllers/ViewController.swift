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
        networkManager.fetchMovie(url: MovieURL.kobisURLString, type: BoxOffice.self, complitionHandler: { boxOffice in
            boxOffice?.boxOfficeResult.dailyBoxOfficeList.forEach {dump($0)}
            guard let code = boxOffice?.boxOfficeResult.dailyBoxOfficeList[0].movieCode else { return }
            self.networkManager.fetchMovie(url: MovieURL.detailURLString(movieCode: code), type: Movie.self) { movie in
                dump(movie?.infomationResult.movieInfomation)
            }
        })
    }
}

