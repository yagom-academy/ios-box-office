//
//  MovieDetailsViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/29.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let directorView = CategoryStackView()
    private let productionYearView = CategoryStackView()
    private let openDateView = CategoryStackView()
    private let runningTimeView = CategoryStackView()
    private let watchGradeView = CategoryStackView()
    private let nationView = CategoryStackView()
    private let genreView = CategoryStackView()
    private let actorView = CategoryStackView()
    private let posterView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var scrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    var movieDetails: MovieDetails?
    var searchedImage: SearchedImage?
    var movieCode: String
    var movieName: String
    
    init(movieCode: String, movieName: String) {
        self.movieCode = movieCode
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieName
        view.backgroundColor = .white
        loadMovieDetails()
        loadPosterImage()
        fillCategoryLabels()
        configureScrollView()
    }
    
    func loadMovieDetails() {
        var api = KobisAPI(service: .movieDetails)
        let queryName = "movieCd"
        api.addQuery(name: queryName, value: movieCode)
        
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        apiProvider.startLoad(decodingType: MovieDetails.self) { result in
            switch result {
            case .success(let movieDetails):
                self.movieDetails = movieDetails
                DispatchQueue.main.async {
                    self.filldetailLabels(with: movieDetails)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPosterImage() {
        var api = DaumImageAPI()
        let queryName = "query"
        let queryValue = movieName + " 영화 포스터"
        api.addQuery(name: queryName, value: queryValue)
        
        var apiProvider = APIProvider()
        apiProvider.target(api: api)
        apiProvider.startLoad(decodingType: SearchedImage.self) { result in
            switch result {
            case .success(let searchedImage):
                self.searchedImage = searchedImage
                guard let document = searchedImage.documents.first,
                      let url = URL(string: document.imageURL),
                      let data = try? Data(contentsOf: url) else { return }
            
                DispatchQueue.main.async {
                    LoadingIndicator.showLoading(in: self.posterView)
                    self.posterView.image = UIImage(data: data)
                    LoadingIndicator.hideLoading(in: self.posterView)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filldetailLabels(with movieDetails: MovieDetails) {
        let movieInfo = movieDetails.movieInfoResult.movieInfo
        
        directorView.detailLabel.text = movieInfo.directors
            .map { $0.personName }
            .reduce("") { $0 + ", " + $1 }
            .trimmingCharacters(in: [",", " "])
        productionYearView.detailLabel.text = movieInfo.productionYear
        openDateView.detailLabel.text = movieInfo.openDate
        runningTimeView.detailLabel.text = movieInfo.runningTime
        watchGradeView.detailLabel.text = movieInfo.audits.first?.watchGradeName
        nationView.detailLabel.text = movieInfo.nations.first?.nationName
        genreView.detailLabel.text = movieInfo.genres
            .map { $0.genreName }
            .reduce("") { $0 + ", " + $1 }
            .trimmingCharacters(in: [",", " "])
        actorView.detailLabel.text = movieInfo.actors
            .map { $0.personName }
            .reduce("") { $0 + ", " + $1 }
            .trimmingCharacters(in: [",", " "])
    }
    
    func fillCategoryLabels() {
        directorView.categoryLabel.text = "감독"
        productionYearView.categoryLabel.text = "제작년도"
        openDateView.categoryLabel.text = "개봉일"
        runningTimeView.categoryLabel.text = "상영시간"
        watchGradeView.categoryLabel.text = "관람등급"
        nationView.categoryLabel.text = "제작국가"
        genreView.categoryLabel.text = "장르"
        actorView.categoryLabel.text = "배우"
    }
    
    func configureScrollView() {
        let movieInformationView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let subviews = [
                directorView, productionYearView, openDateView,
                runningTimeView, watchGradeView, nationView, genreView, actorView
            ]
            subviews.forEach {
                stackView.addArrangedSubview($0)
            }
            
            return stackView
        }()
        
        let contentView = {
            let stackView = UIStackView()
            
            [posterView, movieInformationView].forEach {
                stackView.addArrangedSubview($0)
            }
            
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            return stackView
        }()
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            movieInformationView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        posterView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            posterView.widthAnchor.constraint(lessThanOrEqualTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.95),
            posterView.heightAnchor.constraint(lessThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
    }
}
