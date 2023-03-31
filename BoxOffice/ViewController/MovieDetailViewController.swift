//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/31.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    let movieName: String
    let movieCode: String
    private var movieDetailInformation: MovieDetailInformationItem?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let directorStackView = CategoryStackView(category: Category.director)
    private let productYearStackView = CategoryStackView(category: Category.productYear)
    private let openDateStackView = CategoryStackView(category: Category.openDate)
    private let showingTimeStackView = CategoryStackView(category: Category.showingTime)
    private let watchGradeStackView = CategoryStackView(category: Category.watchGrade)
    private let nationStackView = CategoryStackView(category: Category.nation)
    private let genreStackView = CategoryStackView(category: Category.genre)
    private let actorStackView = CategoryStackView(category: Category.actor)
    
    init(movieName: String, movieCode: String) {
        self.movieName = movieName
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        
        
        setupUI()
//        fetchMovieDetail()
    }
    
    private func setupUI() {
        self.navigationItem.title = movieName
        view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
        ])
    
        stackView.addArrangedSubview(posterImageView)
        
        stackView.addArrangedSubview(directorStackView)
        stackView.addArrangedSubview(productYearStackView)
        stackView.addArrangedSubview(openDateStackView)
        stackView.addArrangedSubview(showingTimeStackView)
        stackView.addArrangedSubview(watchGradeStackView)
        stackView.addArrangedSubview(nationStackView)
        stackView.addArrangedSubview(genreStackView)
        stackView.addArrangedSubview(actorStackView)
        
        NSLayoutConstraint.activate([
           
            posterImageView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5)
        ])
        
        
        
    }
    
//    private func addInformationStackViews() {
//
//        let label = UILabel()
//        label.text = "감독"
//        let label2 = UILabel()
//        label2.text = movieDetailInformation!.directors.map { $0.personName }.joined(separator: ",")
//
//        let stackView = UIStackView(arrangedSubviews: [label, label2])
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//    }
    
    private func fetchMovieDetail() {
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.detailMovieInformation(movieCode: self.movieCode),
                                    type: MovieInformationDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.movieDetailInformation = data.toDomain()
            case .failure:
                print("실패")
            }
        }
    }
}

fileprivate enum Category {
    static let director = "감독"
    static let productYear = "제작년도"
    static let openDate = "개봉일"
    static let showingTime = "상영시간"
    static let watchGrade = "관람등급"
    static let nation = "제작국가"
    static let genre = "장르"
    static let actor = "배우"
}

