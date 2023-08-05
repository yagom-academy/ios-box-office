//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by kyungmin on 2023/08/05.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieCode: String
    let movieDetailView = MovieDetailView()
    
    init(movieCode: String) {
        self.movieCode = movieCode
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = movieDetailView
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
