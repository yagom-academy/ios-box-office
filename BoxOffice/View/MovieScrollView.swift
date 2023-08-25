//
//  MovieScrollView.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/14.
//

import UIKit

final class MovieScrollView: UIScrollView {
    private var movieInformation: MovieInformation?
    private var image: UIImage?
    private var movieInformationStackView: MovieInformationStackView?
    
    private let movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return imageView
    }()
    
    init(frame: CGRect, image: UIImage, movieInformation: MovieInformation) {
        super.init(frame: frame)
        self.image = image
        self.movieInformation = movieInformation
        
        configureUI()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieScrollView {
    private func configureUI() {
        configureMovieImageView()
        configureMovieInformationStackView()
        
        guard let movieInformationStackView = movieInformationStackView else { return }
        
        self.addSubview(movieStackView)
        movieStackView.addArrangedSubview(movieImageView)
        movieStackView.addArrangedSubview(movieInformationStackView)
    }
    
    private func configureMovieImageView() {
        movieImageView.image = image
    }
    
    private func configureMovieInformationStackView() {
        if let movieInformation = movieInformation {
            movieInformationStackView = MovieInformationStackView(frame: .zero, movieInformation: movieInformation)
        }
    }
    
    private func setUpConstraints() {
        guard let movieInformationStackView = movieInformationStackView else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let imageRatio = calculateImageRatio()
        
        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            movieImageView.widthAnchor.constraint(
                equalTo: movieStackView.widthAnchor,
                constant: Constraints.movieImageViewFromMovieStackViewWidth
            ),
            movieImageView.heightAnchor.constraint(
                equalTo: movieImageView.widthAnchor,
                multiplier: imageRatio
            ),
            
            movieInformationStackView.widthAnchor.constraint(
                equalTo: movieStackView.widthAnchor,
                constant: Constraints.movieInformationStackViewFromMovieStackViewWidth
            )
        ])
    }
    
    private func calculateImageRatio() -> Double {
        guard let image = image else { return 0 }
        
        return Double(image.size.height) / Double(image.size.width)
    }
}
