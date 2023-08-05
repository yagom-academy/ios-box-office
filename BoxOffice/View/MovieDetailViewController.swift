//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by kyungmin on 2023/08/05.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let boxOfficeManager: BoxOfficeManager
    private let movieCode: String
    private let movieDetailView = MovieDetailView()
    
    init(boxOfficeManager: BoxOfficeManager, movieCode: String) {
        self.movieCode = movieCode
        self.boxOfficeManager = boxOfficeManager
        
        super.init(nibName: nil, bundle: nil)
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
