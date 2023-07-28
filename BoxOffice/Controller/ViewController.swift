//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private let apiProtocol: MovieDataFetchable = MovieDataAPI()
    private let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestAPI(completion: @escaping (Result<[MovieInfo], Error>) -> ()) {
        apiProtocol.fetchMovieData(completion: completion)
    }
}

