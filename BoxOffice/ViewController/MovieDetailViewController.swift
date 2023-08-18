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
    
    init(_ boxOfficeService: BoxOfficeService, _ dailyBoxOffice: DailyBoxOffice) {
        self.boxOfficeService = boxOfficeService
        self.dailyBoxOffice = dailyBoxOffice
        
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
        
        setupTitle()
        configureBackgroundColor()
        loadMovieDetail()
        loadMoviePoster()
        movieDetailView.startLoadingImage()
    }
    
    private func setupTitle() {
        self.title = dailyBoxOffice.movieName
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Load Data
    private func loadMoviePoster() {
        boxOfficeService.loadMoviePoster(movieNm: dailyBoxOffice.movieName, fetchMoviePoster)
    }
    
    private func fetchMoviePoster(_ result: Result<DaumSearchMainText<ImageDocument>, NetworkManagerError>) {
        switch result {
        case .success(let daumSearchMainText):
            guard let imageDocument = daumSearchMainText.documents.first else { return }
            
            let cacheKey = NSString(string: dailyBoxOffice.movieCode)
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
                DispatchQueue.main.async {
                    self.setupPosterImage(imageDocument, cachedImage)
                }
            } else {
                if let imageURL = URL(string: imageDocument.imageURL),
                   let data = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.setupPosterImage(imageDocument, image)
                        
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    }
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.showErrorAlert(in: self, "상세 정보", error)
            }
        }
    }
    
    private func loadMovieDetail() {
        boxOfficeService.loadMovieDetailData(movieCd: dailyBoxOffice.movieCode, fetchMovie)
    }
    
    private func fetchMovie(_ result: Result<Movie, NetworkManagerError>) {
        switch result {
        case .success(let movie):
            DispatchQueue.main.async {
                self.setupLabels(movie)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.showErrorAlert(in: self, "영화 상세 정보", error)
            }
        }
    }
}

extension MovieDetailViewController {
    private func setupPosterImage(_ imageDocument: ImageDocument, _ image: UIImage) {
        usleep(500000)
        movieDetailView.stopLoadingImage()
        let ratio = self.movieDetailView.posterImage.frame.width / CGFloat(integerLiteral: imageDocument.width)
        let height = ratio * CGFloat(integerLiteral: imageDocument.height)
        self.movieDetailView.posterImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.movieDetailView.posterImage.image = image
    }
    
    private func setupLabels(_ movie: Movie) {
        let movieInfo = movie.movieInformationResult.movieInformation
        let directors = movieInfo.directors.map{ $0.peopleName }.joined(separator: ", ")
        var formattedOpenDate = movieInfo.openDate
        formattedOpenDate.insert("-", at: formattedOpenDate.index(formattedOpenDate.startIndex, offsetBy: 4))
        formattedOpenDate.insert("-", at: formattedOpenDate.index(formattedOpenDate.endIndex, offsetBy: -2))
        
        movieDetailView.directorDetailLabel.text = directors
        movieDetailView.productionYearDetailLabel.text = movieInfo.productionYear
        movieDetailView.openDateDetailLabel.text = formattedOpenDate
        movieDetailView.showTimeDetailLabel.text = movieInfo.showTime
        movieDetailView.watchGradeNameDetailLabel.text = movieInfo.audits.first?.watchGradeName
        movieDetailView.nationNameDetailLabel.text = movieInfo.nations.map{ $0.nationName }.joined(separator: ", ")
        movieDetailView.genreNameDetailLabel.text = movieInfo.genres.map{ $0.genreName }.joined(separator: ", ")
        movieDetailView.actorDetailLabel.text = movieInfo.actors.map{ $0.peopleName }.joined(separator: ", ")
    }
}
