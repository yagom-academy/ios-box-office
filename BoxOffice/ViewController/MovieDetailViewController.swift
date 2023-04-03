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
            movieInformationStackView.setupInformation(information: information)
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieInformationStackView = MovieInformationStackView(frame: .zero)
    
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
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.activityIndicator)
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.movieInformationStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            
            posterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.posterImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.posterImageView.centerYAnchor),
            
            movieInformationStackView.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 10),
            movieInformationStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            movieInformationStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            movieInformationStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
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
                    self?.activityIndicator.stopAnimating()
                }
            case .failure:
                print("실패")
            }
        }
    }
}


