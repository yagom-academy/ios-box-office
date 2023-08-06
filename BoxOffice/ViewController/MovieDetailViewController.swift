//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let boxOfficeService: BoxOfficeService
    private let dailyBoxOffice: DailyBoxOffice
    
    private lazy var movieDetailView: MovieDetailView = {
        let view = MovieDetailView()
        return view
    }()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor(.systemBackground)
    }
    
    init(_ boxOfficeService: BoxOfficeService, _ dailyBoxOffice: DailyBoxOffice) {
        self.boxOfficeService = boxOfficeService
        self.dailyBoxOffice = dailyBoxOffice
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
