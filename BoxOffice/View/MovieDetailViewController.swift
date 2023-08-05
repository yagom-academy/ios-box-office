//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by kyungmin on 2023/08/05.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    
    override func loadView() {
        self.view = movieDetailView
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
