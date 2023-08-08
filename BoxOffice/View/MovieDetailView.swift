//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/05.
//

import UIKit

final class MovieDetailView: UIView {
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
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()
    
    private let movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: add MovieDetailStackVeiw
extension MovieDetailView {
    func setupMovieInformationStackView(movieInformation: MovieInformation) {
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.movieTitle, information: movieInformation.movieTitle))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.productionYear, information: movieInformation.productionYear))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.openDate, information: movieInformation.openDate))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.showTime, information: movieInformation.showTime))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.watchGradeName, information: movieInformation.watchGradeName))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.nationName, information: movieInformation.nationName))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.genreName, information: movieInformation.genreName))
        movieInformationStackView.addArrangedSubview(informationStackView(title: MovieInformation.PropertyName.actors, information: movieInformation.actors))
    }
    
    func setupPosterImageView(image: UIImage?) {
        posterImageView.image = image
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    private func informationStackView(title: String, information: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        
        let titleLabel = UILabel()
        let titleLabelConstraint = titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.2)
        titleLabelConstraint.isActive = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        let informationLabel = UILabel()
        informationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        informationLabel.textAlignment = .left
        informationLabel.numberOfLines = 0
        informationLabel.text = information
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(informationLabel)
        
        return stackView
    }
}

// MARK: configure UI
extension MovieDetailView {
    private func configureUI() {
        configureView()
        configureScrollView()
        configureContentView()
        configureImageView()
    }
    
    private func configureView() {
        self.addSubview(scrollView)
    }
    
    private func configureScrollView() {
        scrollView.addSubview(contentView)
    }
    
    private func configureContentView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieInformationStackView)
    }
    
    private func configureImageView() {
        posterImageView.addSubview(activityIndicator)
    }
}

// MARK: setup Constraint
extension MovieDetailView {
    private func setupConstraint() {
        setupScrollViewConstraint()
        setupContentViewConstraint()
        setupPosterImageViewConstraint()
        setupActivityIndicatorConstraint()
        setupMovieInformationStackView()
    }
    
    private func setupScrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupContentViewConstraint() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupPosterImageViewConstraint() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: self.frame.width * 0.25),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            posterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.3)
        ])
    }
    
    private func setupActivityIndicatorConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor)
        ])
    }
    
    private func setupMovieInformationStackView() {
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
