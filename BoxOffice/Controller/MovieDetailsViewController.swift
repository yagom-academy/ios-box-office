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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private var movieDetails: MovieDetails?
    private var searchedImage: SearchedImage?
    private var movieCode: String
    private var movieName: String
    
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
        baseSettings()
        loadMovieDetails()
        loadPosterImage()
        fillCategoryLabels()
        configureScrollView()
        LoadingIndicator.showLoading(in: posterView)
    }
    
    private func baseSettings() {
        title = movieName
        view.backgroundColor = .white
    }
    
    private func loadMovieDetails() {
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
                    self.fillDetailLabels(with: movieDetails)
                }
            case .failure(let error):
                AlertController.showAlert(for: error, to: self)
            }
        }
    }
    
    private func loadPosterImage() {
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
                    self.posterView.image = UIImage(data: data)
                    LoadingIndicator.hideLoading(in: self.posterView)
                }
            case .failure(let error):
                AlertController.showAlert(for: error, to: self)
                LoadingIndicator.hideLoading(in: self.posterView)
            }
        }
    }
    
    private func fillDetailLabels(with movieDetails: MovieDetails) {
        let movieInfo = movieDetails.movieInfoResult.movieInfo
        
        directorView.detailLabel.text = movieInfo.directors
            .map { $0.personName }
            .joined(separator: ", ")
        productionYearView.detailLabel.text = movieInfo.productionYear
        let date = DateFormatter.shared.converFormat(of: movieInfo.openDate,
                                                     from: "yyyyMMdd",
                                                     to: "yyyy-MM-dd")
        openDateView.detailLabel.text = date
        runningTimeView.detailLabel.text = movieInfo.runningTime + "분"
        watchGradeView.detailLabel.text = movieInfo.audits.first?.watchGradeName
        nationView.detailLabel.text = movieInfo.nations.first?.nationName
        genreView.detailLabel.text = movieInfo.genres
            .map { $0.genreName }
            .joined(separator: ", ")
        actorView.detailLabel.text = movieInfo.actors
            .map { $0.personName }
            .joined(separator: ", ")
    }
    
    private func fillCategoryLabels() {
        directorView.categoryLabel.text = "감독"
        productionYearView.categoryLabel.text = "제작년도"
        openDateView.categoryLabel.text = "개봉일"
        runningTimeView.categoryLabel.text = "상영시간"
        watchGradeView.categoryLabel.text = "관람등급"
        nationView.categoryLabel.text = "제작국가"
        genreView.categoryLabel.text = "장르"
        actorView.categoryLabel.text = "배우"
    }
    
    private func configureScrollView() {
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
            subviews.forEach { stackView.addArrangedSubview($0) }
            
            return stackView
        }()
        
        let contentView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            [posterView, movieInformationView].forEach { view.addSubview($0) }
            
            return view
        }()
    
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 15),
            posterView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterView.bottomAnchor.constraint(equalTo: movieInformationView.topAnchor),
            posterView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.9),
            posterView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 0.8),
            movieInformationView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            movieInformationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieInformationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieInformationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
