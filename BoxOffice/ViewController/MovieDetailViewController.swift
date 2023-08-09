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
    
    private let usecase: MovieDetailViewControllerUseCase
    
    init(usecase: MovieDetailViewControllerUseCase) {
        self.usecase = usecase
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
