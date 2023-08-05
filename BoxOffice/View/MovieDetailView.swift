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
        imageView.image = UIImage(systemName: "xmark.bin.fill")
        imageView.tintColor = .systemGray
        
        return imageView
    }()
    
    private let movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
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
    private func informationStackView(title: String, information: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        let titleLabel = UILabel()
        titleLabel.text = title
        
        let informationLabel = UILabel()
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
}

// MARK: setup Constraint
extension MovieDetailView {
    private func setupConstraint() {
        setupScrollViewConstraint()
        setupContentViewConstraint()
        setupPosterImageViewConstraint()
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
    
    private func setupMovieInformationStackView() {
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
