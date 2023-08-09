//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/09.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let movieDetailView: MovieDetailView = {
        let movieDetailView = MovieDetailView()
        
        return movieDetailView
    }()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
