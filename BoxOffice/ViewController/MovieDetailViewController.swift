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
        
        configureBackgroundColor()
        loadMoviePoster()
    }
    
    init(_ boxOfficeService: BoxOfficeService, _ dailyBoxOffice: DailyBoxOffice) {
        self.boxOfficeService = boxOfficeService
        self.dailyBoxOffice = dailyBoxOffice
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Load Data
    @objc private func loadMoviePoster() {
        boxOfficeService.loadMoviePoster(movieNm: dailyBoxOffice.movieName, fetchMoviePoster)
    }
    
    private func fetchMoviePoster(_ result: Result<DaumSearchMainText<ImageDocument>, NetworkManagerError>) {
        switch result {
        case .success(let daumSearchMainText):
            guard let imageDocument = daumSearchMainText.documents.first else { return }
            print("imageDocument : \(imageDocument)")
            if let imageUrl = URL(string: imageDocument.imageUrl),
               let data = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self.movieDetailView.posterImage.image = image
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.showErrorAlert(in: self, "상세 정보", error)
            }
        }
    }
}
