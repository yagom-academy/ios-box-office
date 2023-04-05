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
    private let dataLoader = DataLoader()
    private let imageLoader = ImageLoader()
    
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
        activityIndicator.startAnimating()
        
        dataLoader.loadMovieInfo(movieCode: movieCode) { [weak self] movie, error in
            guard let error = error else {
                self?.movieInfo = movie
                self?.checkFetchComplete()
                return
            }
            
            self?.showFailAlert(error: error)
        }
        
        dataLoader.loadMoviePosterURL(movieName: movieName) { [weak self] url, error in
            guard let error = error else {
                self?.imageLoader.loadPosterImage(url: url, completion: { [weak self] image in
                    self?.posterImage = image
                    self?.checkFetchComplete()
                })
                return
            }
            
            self?.showFailAlert(error: error)
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
