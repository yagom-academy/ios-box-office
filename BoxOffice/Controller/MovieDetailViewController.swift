//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by karen on 2023/08/19.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    var movieName: String = DataNamespace.empty
    var movieCode: String = DataNamespace.empty
    private var dataManager: MovieManager?
    private let dispatchGroup = DispatchGroup()
    private let descriptionStackView = DescriptionStackView()
    private let loadingView = UIActivityIndicatorView()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMovieDescriptionManager()
        configureUI()
        startLoading()
        fetchImage()
        fetchData()
        stopLoading()
    }
    
    private func createMovieDescriptionManager() {
        self.dataManager = MovieManager(movieCode: movieCode, movieName: movieName)
    }
    
    private func fetchData() {
        dispatchGroup.enter()
        
        dataManager?.boxOfficeInfo.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                let infoUIModel = MovieDetailUIModel(data: data.movieInfoResult.movieInfo)
                DispatchQueue.main.async {
                    self?.descriptionStackView.update(infoUIModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentErrorAlert(error: error, title: "\(BoxOfficeError.failedToGetData)")
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
                    self?.presentErrorAlert(error: error, title: "\(BoxOfficeError.failedToGetImage)")
                }
                self?.dispatchGroup.leave()
            }
        }
    }
        
    private func startLoading() {
        loadingView.startAnimating()
        posterImageView.isHidden = true
        descriptionStackView.isHidden = true
    }
    
    private func stopLoading() {
        dispatchGroup.notify(queue: .main) {
            self.loadingView.stopAnimating()
            self.posterImageView.isHidden = false
            self.descriptionStackView.isHidden = false
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
        scrollView.addSubview(descriptionStackView)
        
        NSLayoutConstraint.activate([
            descriptionStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            descriptionStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            descriptionStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5),
            descriptionStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func configureActivityIndicatorView() {
        loadingView.center = view.center
        loadingView.style = .large
        
        view.addSubview(loadingView)
    }
}
