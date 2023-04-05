//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/29.
//

import UIKit

final class MovieInfoViewController: UIViewController {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var productionYearLabel: UILabel!
    @IBOutlet private weak var openDateLabel: UILabel!
    @IBOutlet private weak var showTimeLabel: UILabel!
    @IBOutlet private weak var nationLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var watchGradeLabel: UILabel!
    @IBOutlet private weak var actorLabel: UILabel!
    @IBOutlet private weak var contentStackView: UIStackView!
    
    private let movieCode: String?
    private let movieName: String?
    private var movieInfo: Movie?
    private var posterImage: UIImage?
    private let movieInfoDataLoader = MovieInfoDataLoader()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = self.view.center
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialView()
    }
    
    init?(movieCode: String?, movieName: String?, coder: NSCoder) {
        self.movieCode = movieCode
        self.movieName = movieName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureInitialView() {
        navigationItem.title = movieName
        contentStackView.isHidden = true
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        fetchMovieInfo(completion: checkFetchComplete)
        fetchMoviePoster()
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        
        movieInfoDataLoader.loadMovieInfo(movieCode: movieCode) { [weak self] movie, error in
            guard let error = error else {
                self?.movieInfo = movie
                self?.checkFetchComplete()
                return
            }
            
            self?.showFailAlert(error: error)
        }
    }
    
    private func fetchMoviePoster() {
        guard let movieName = movieName else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMoviePoster(movieName: movieName)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: MoviePoster.self) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let url = self.searchPosterURL(data: data)
                self.loadPosterImage(url: url, completion: self.checkFetchComplete)
            case .failure(let error):
                print(error.localizedDescription)
                self.showFailAlert(error: error)
            }
        }
    }
    
    private func searchPosterURL(data: MoviePoster) -> URL? {
        guard let firstItem = data.items.first else { return nil }
        
        let urlText = firstItem.imageURLText
        
        return URL(string: urlText)
    }
    
    private func loadPosterImage(url: URL?, completion: @escaping () -> ()) {
        guard let url = url else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.posterImage = image
                completion()
            }
        }
    }
    
    private func configureLabels(data: Movie) {
        let info = data.movieInfoResult.info
        
        directorLabel.text = info.directors.map { $0.peopleName }.concatenate()
        productionYearLabel.text = info.productionYearText
        openDateLabel.text = DateFormatter.hyphenText(text: info.openDateText)
        showTimeLabel.text = info.showTimeText
        nationLabel.text = info.nations.map { $0.nationName }.concatenate()
        genreLabel.text = info.genres.map { $0.genreName }.concatenate()
        watchGradeLabel.text = info.audits.map { $0.watchGradeName }.concatenate()
        actorLabel.text = info.actors.map { $0.peopleName }.concatenate()
    }
    
    private func checkFetchComplete() {
        guard posterImage != nil && movieInfo != nil,
              let movieInfo = movieInfo else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicator.stopAnimating()
            self.posterImageView.image = self.posterImage
            self.configureLabels(data: movieInfo)
            self.contentStackView.isHidden = false
        }
    }
}

fileprivate extension Array where Element == String {
    func concatenate() -> String {
        if self.isEmpty {
            return "정보 없음"
        }
        
        return self.joined(separator: ", ")
    }
}
