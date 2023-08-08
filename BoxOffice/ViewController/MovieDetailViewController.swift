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
        
        setTitle()
        configureBackgroundColor()
        loadMoviePoster()
        loadMovieDetail()
    }
    
    init(_ boxOfficeService: BoxOfficeService, _ dailyBoxOffice: DailyBoxOffice) {
        self.boxOfficeService = boxOfficeService
        self.dailyBoxOffice = dailyBoxOffice
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        self.title = dailyBoxOffice.movieName
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
            
            let cacheKey = NSString(string: imageDocument.imageUrl)
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
                DispatchQueue.main.async {
                    self.setPosterImage(imageDocument, cachedImage)
                }
            } else {
                if let imageUrl = URL(string: imageDocument.imageUrl),
                   let data = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.setPosterImage(imageDocument, image)
                        
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
    
    @objc private func loadMovieDetail() {
        boxOfficeService.loadMovieDetailData(movieCd: dailyBoxOffice.movieCode, fetchMovie)
    }
    
    private func fetchMovie(_ result: Result<Movie, NetworkManagerError>) {
        switch result {
        case .success(let movie):
            DispatchQueue.main.async {
                let movieInfo = movie.movieInformationResult.movieInformation
                
                let directors = movieInfo.directors.map{ $0.peopleName }.joined(separator: ", ")
                self.movieDetailView.directorDetailLabel.text = directors
                
                self.movieDetailView.productionYearDetailLabel.text = movieInfo.productionYear
                
                var formattedOpenDate = movieInfo.openDate
                formattedOpenDate.insert("-", at: formattedOpenDate.index(formattedOpenDate.startIndex, offsetBy: 4))
                formattedOpenDate.insert("-", at: formattedOpenDate.index(formattedOpenDate.endIndex, offsetBy: -2))
                self.movieDetailView.openDateDetailLabel.text = formattedOpenDate
                
                self.movieDetailView.showTimeDetailLabel.text = movieInfo.showTime
                
                self.movieDetailView.watchGradeNameDetailLabel.text = movieInfo.audits.first?.watchGradeName
                
                self.movieDetailView.nationNameDetailLabel.text = movieInfo.nations.map{ $0.nationName }.joined(separator: ", ")
                
                self.movieDetailView.genreNameDetailLabel.text = movieInfo.genres.map{ $0.genreName }.joined(separator: ", ")
                
                self.movieDetailView.actorsDetailLabel.text = movieInfo.actors.map{ $0.peopleName }.joined(separator: ", ")
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.showErrorAlert(in: self, "영화 상세 정보", error)
            }
        }
    }
}

extension MovieDetailViewController {
    private func setPosterImage(_ imageDocument: ImageDocument, _ image: UIImage) {
        let ratio = self.movieDetailView.posterImage.frame.width / CGFloat(integerLiteral: imageDocument.width)
        let height = ratio * CGFloat(integerLiteral: imageDocument.height)
        self.movieDetailView.posterImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.movieDetailView.posterImage.image = image
    }
}
