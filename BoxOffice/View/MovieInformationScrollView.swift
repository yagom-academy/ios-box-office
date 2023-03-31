//
//  MovieInformationScrollView.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationScrollView: UIScrollView {
    private let movieInformationContentView = UIView()
    private let movieInformationStackView = UIStackView()
    private let moviePosterImageView = UIImageView()
    
    private let directorStackView = UIStackView()
    private let productionYearStackView = UIStackView()
    private let openDateStackView = UIStackView()
    private let showTimeStackView = UIStackView()
    private let watchGradeStackView = UIStackView()
    private let nationStackView = UIStackView()
    private let genresStackView = UIStackView()
    private let actorsStackView = UIStackView()
    
    func configure(by movie: MovieInformationItem) {
        self.addSubview(movieInformationContentView)
        
        configureContentView()
        configureStackView()
        configureImageView()
        configureDirectorStackView(by: movie)
        configureProductionYearStackView(by: movie)
        configureOpenDateStackView(by: movie)
        configureShowTimeStackView(by: movie)
        configureWatchGradeStackView(by: movie)
        configureNationStackView(by: movie)
        configureGenreStackView(by: movie)
        configureActorStackView(by: movie)
    }
    
    func setupMoviePoterImage(_ image: UIImage) {
        self.moviePosterImageView.image = image
    }

    private func configureContentView() {
        movieInformationContentView.addSubview(movieInformationStackView)
        
        movieInformationContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationContentView.topAnchor.constraint(equalTo: self.topAnchor),
            movieInformationContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieInformationContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieInformationContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieInformationContentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureStackView() {
        movieInformationStackView.addArrangedSubview(moviePosterImageView)
        movieInformationStackView.spacing = 10
        movieInformationStackView.axis = .vertical
        
        movieInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: movieInformationContentView.topAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: movieInformationContentView.leadingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: movieInformationContentView.bottomAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: movieInformationContentView.trailingAnchor)
        ])
    }
    
    private func configureImageView() {
        moviePosterImageView.contentMode = .scaleAspectFit
        moviePosterImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterImageView.heightAnchor.constraint(lessThanOrEqualTo: self.frameLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureDirectorStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(productionYearStackView)
        productionYearStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "감독"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        productionYearStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: productionYearStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        productionYearStackView.addArrangedSubview(descriptionLabel)
        
        descriptionLabel.text = movie.directors
    }
    
    private func configureProductionYearStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(directorStackView)
        
        let titleLabel = UILabel()
        titleLabel.text = "제작년도"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        directorStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: directorStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.productionYear
        
        directorStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureOpenDateStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(openDateStackView)
        openDateStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "개봉일"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        openDateStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: openDateStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.openDate
        
        openDateStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureShowTimeStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(showTimeStackView)
        showTimeStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "상영시간"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        showTimeStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: showTimeStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.showTime
        
        showTimeStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureWatchGradeStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(watchGradeStackView)
        watchGradeStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "관람등급"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        watchGradeStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: watchGradeStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.audits
        
        watchGradeStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureNationStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(nationStackView)
        nationStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "제작국가"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        nationStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: nationStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.nations
        
        nationStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureGenreStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(genresStackView)
        genresStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "장르"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        genresStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: genresStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.genres
        
        genresStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureActorStackView(by movie: MovieInformationItem) {
        movieInformationStackView.addArrangedSubview(actorsStackView)
        actorsStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "배우"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        actorsStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: actorsStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.actors
        descriptionLabel.numberOfLines = 0
        
        actorsStackView.addArrangedSubview(descriptionLabel)
        
    }
}
