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
    private var movieDetailInformation: MovieDetailInformationItem? {
        didSet {
            guard let information = movieDetailInformation else {
                return
            }
            directorStackView.setupInformationLabel(
                as: information.directors.map { $0.personName }.joined(separator: ", ")
            )
            productYearStackView.setupInformationLabel(as: information.productYear)
            openDateStackView.setupInformationLabel(as: information.openDate)
            showingTimeStackView.setupInformationLabel(as: information.showingTime)
            watchGradeStackView.setupInformationLabel(
                as: information.audits.map { $0.watchGradeName }.joined(separator: ", ")
            )
            nationStackView.setupInformationLabel(
                as: information.nations.map { $0.nationName }.joined(separator: ", ")
            )
            genreStackView.setupInformationLabel(
                as: information.genres.map { $0.genreName }.joined(separator: ", ")
            )
            actorStackView.setupInformationLabel(
                as: information.actors.map { $0.personName }.joined(separator: ", ")
            )
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
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
        fetchMovieDetail()
        fetchMoviePoster()
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
            stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
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
            posterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            
            directorStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            productYearStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            openDateStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            showingTimeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            watchGradeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            nationStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            genreStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            actorStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            
            directorStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            productYearStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            openDateStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            showingTimeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            watchGradeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            nationStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            genreStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            actorStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: productYearStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: openDateStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: showingTimeStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: watchGradeStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: nationStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: genreStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: actorStackView.categoryLabel.widthAnchor),
        ])
    }
    
    private func fetchMovieDetail() {
        let boxOfficeProvider = BoxOfficeProvider<BoxOfficeAPI>()
        boxOfficeProvider.fetchData(.detailMovieInformation(movieCode: self.movieCode),
                                    type: MovieInformationDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.movieDetailInformation = data.toDomain()
                }
            case .failure:
                print("실패")
            }
        }
    }
    
    private func fetchMoviePoster() {
        let boxOfficeProvider = BoxOfficeProvider<DaumAPI>()
        boxOfficeProvider.fetchData(.searchImage(movieName: "\(self.movieName) 영화 포스터"),
                                    type: SearchedMovieImageDTO.self) { [weak self] result in
            switch result {
            case .success(let data):
                guard let url = data.documents.first?.imageURL,
                      let imageUrl = URL(string: url) else {
                    return
                }
                guard let image = try? Data(contentsOf: imageUrl) else { return }
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(data: image)
                }
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

