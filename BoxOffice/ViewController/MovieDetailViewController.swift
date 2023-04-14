//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/31.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let movieName: String
    private let movieCode: String
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
        imageView.contentMode = .scaleAspectFit
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
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            
            posterImageView.centerXAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.heightAnchor, multiplier: 0.6),
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
            case .success(let movieInformationDTOData):
                DispatchQueue.main.async {
                    self?.movieDetailInformation = movieInformationDTOData.convertToMovieDetailInformationItem()
                }
            case .failure:
                let alertViewController = AlertManager.shared.showFailureAlert()
                self?.present(alertViewController, animated: true)
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
                
                boxOfficeProvider.fetchImage(url: imageUrl) { result in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            self?.posterImageView.image = UIImage(data: imageData)
                            self?.activityIndicator.stopAnimating()
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            let alertController = AlertManager.shared.showFailureAlert()
                            self?.present(alertController, animated: true)
                        }
                    }
                }
            case .failure:
                let alertViewController = AlertManager.shared.showFailureAlert()
                self?.present(alertViewController, animated: true)
            }
        }
    }
}


