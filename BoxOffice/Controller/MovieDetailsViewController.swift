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
    private let posterView = UIImageView()
    private var scrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    var movieDetails: MovieDetails?
    var movieCode: String
    
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadMovieDetails()
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
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        posterView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            posterView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95)
        ])
    }
}
