//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/04/03.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    var movieName: String = ""
    var movieCode: String = ""
    private var dataManager: MovieDescManager?
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - UI Properties
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let descStackView = DescStackView()
    private let loadingView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMovieDescManager()
        configureUI()
        startLoading()
        fetchImage()
        fetchData()
        stopLoading()
    }
    
    private func createMovieDescManager() {
        self.dataManager = MovieDescManager(movieCode: movieCode, movieName: movieName)
    }
    
    private func fetchData() {
        dispatchGroup.enter()
        
        dataManager?.boxofficeInfo.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                let infoUIModel = MovieInfoUIModel(data: data.movieInfoResult.movieInfo)
                DispatchQueue.main.async {
                    self?.descStackView.updateTextLabel(infoUIModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentErrorAlert(error: error, title: "영화 상세 정보")
                }
            }
            self?.dispatchGroup.leave()
        }
    }
    
    private func fetchImage() {
        dispatchGroup.enter()
        
        dataManager?.fetchMoviePosterImage { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success((let image, let imageSize)):
                    self?.posterImageView.image = image
                    self?.configureImageWidthConstraint(size: imageSize)
                case .failure(let error):
                    self?.presentErrorAlert(error: error, title: "영화 포스터 이미지")
                }
                self?.dispatchGroup.leave()
            }
        }
    }
        
    private func startLoading() {
        loadingView.startAnimating()
        posterImageView.isHidden = true
        descStackView.isHidden = true
    }
    
    private func stopLoading() {
        dispatchGroup.notify(queue: .main) {
            self.loadingView.stopAnimating()
            self.posterImageView.isHidden = false
            self.descStackView.isHidden = false
        }
    }
}

// MARK: - UI
extension MovieDetailViewController {
    private func configureImageWidthConstraint(size: CGSize) {
        let width = CGFloat(size.width)
        let height = CGFloat(size.height)
        
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: height / width).isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = movieName
        
        configureScrollView()
        configurePosterImageView()
        configureDescStackView()
        configureActivityIndicatorView()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func configurePosterImageView() {
        scrollView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            posterImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5)
        ])
    }
    
    private func configureDescStackView() {
        scrollView.addSubview(descStackView)
        
        NSLayoutConstraint.activate([
            descStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            descStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            descStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5),
            descStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func configureActivityIndicatorView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
}
