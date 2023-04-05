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
        loadData()
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
    }
    
    private func loadData() {
        let group = DispatchGroup()
        
        activityIndicator.startAnimating()
        group.enter()
        movieInfoDataLoader.loadMovieInfo(movieCode: movieCode) {
            [weak self] movie, error in
            guard let error = error else {
                self?.configureLabels(data: movie)
                group.leave()
                return
            }
            
            self?.showFailAlert(error: error)
        }
        
        group.enter()
        movieInfoDataLoader.loadMoviePosterImage(movieName: movieName) {
            [weak self] image, error in
            guard let error = error else {
                self?.posterImageView.image = image
                group.leave()
                return
            }
            
            self?.showFailAlert(error: error)
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.showMovieInfo()
        }
    }
    
    private func configureLabels(data: Movie?) {
        guard let data = data else { return }
        
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
    
    private func showMovieInfo() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.contentStackView.isHidden = false
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
