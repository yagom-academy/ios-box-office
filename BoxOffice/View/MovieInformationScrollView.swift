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
    
    private let directorDescriptionLabel = UILabel()
    private let productionYearDescriptionLabel = UILabel()
    private let openDateDescriptionLabel = UILabel()
    private let showTimeDescriptionLabel = UILabel()
    private let watchGradeDescriptionLabel = UILabel()
    private let nationDescriptionLabel = UILabel()
    private let genreDescriptionLabel = UILabel()
    private let actorDescriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(movieInformationContentView)
        
        configureContentView()
        configureImageView()
        configureStackView()
        
        configureDirectorStackView()
        configureProductionYearStackView()
        configureOpenDateStackView()
        configureShowTimeStackView()
        configureWatchGradeStackView()
        configureNationStackView()
        configureGenreStackView()
        configureActorStackView()
    }
    
    func setupMoviePoterImage(_ image: UIImage) {
        self.moviePosterImageView.image = image
    }
    
    private func configureContentView() {
        movieInformationContentView.addSubview(moviePosterImageView)
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
    
    private func configureImageView() {
        moviePosterImageView.contentMode = .scaleAspectFit
        moviePosterImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: movieInformationContentView.topAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: movieInformationContentView.leadingAnchor),
            moviePosterImageView.trailingAnchor.constraint(equalTo: movieInformationContentView.trailingAnchor),
            moviePosterImageView.heightAnchor.constraint(lessThanOrEqualTo: self.frameLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureStackView() {
        movieInformationStackView.spacing = 10
        movieInformationStackView.axis = .vertical
        
        movieInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 10),
            movieInformationStackView.leadingAnchor.constraint(equalTo: movieInformationContentView.leadingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: movieInformationContentView.bottomAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: movieInformationContentView.trailingAnchor)
        ])
        
        movieInformationStackView.addArrangedSubview(directorStackView)
        movieInformationStackView.addArrangedSubview(productionYearStackView)
        movieInformationStackView.addArrangedSubview(openDateStackView)
        movieInformationStackView.addArrangedSubview(showTimeStackView)
        movieInformationStackView.addArrangedSubview(watchGradeStackView)
        movieInformationStackView.addArrangedSubview(nationStackView)
        movieInformationStackView.addArrangedSubview(genresStackView)
        movieInformationStackView.addArrangedSubview(actorsStackView)
    }
    
    private func configureDirectorStackView() {
        directorStackView.distribution = .fill
        directorStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "감독"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        directorStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        directorDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        directorDescriptionLabel.numberOfLines = 0
        directorDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        directorStackView.addArrangedSubview(directorDescriptionLabel)
        
        directorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            directorDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureProductionYearStackView() {
        productionYearStackView.distribution = .fill
        productionYearStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "제작년도"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        productionYearStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        productionYearDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        productionYearDescriptionLabel.numberOfLines = 0
        productionYearDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        productionYearStackView.addArrangedSubview(productionYearDescriptionLabel)
        
        productionYearDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productionYearDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureOpenDateStackView() {
        openDateStackView.distribution = .fill
        openDateStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "개봉일"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        openDateStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        openDateDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        openDateDescriptionLabel.numberOfLines = 0
        openDateDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        openDateStackView.addArrangedSubview(openDateDescriptionLabel)
        
        openDateDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openDateDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureShowTimeStackView() {
        showTimeStackView.distribution = .fill
        showTimeStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "상영시간"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        showTimeStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        showTimeDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        showTimeDescriptionLabel.numberOfLines = 0
        showTimeDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        showTimeStackView.addArrangedSubview(showTimeDescriptionLabel)
        
        showTimeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showTimeDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureWatchGradeStackView() {
        watchGradeStackView.distribution = .fill
        watchGradeStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "관람등급"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        watchGradeStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        watchGradeDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        watchGradeDescriptionLabel.numberOfLines = 0
        watchGradeDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        watchGradeStackView.addArrangedSubview(watchGradeDescriptionLabel)
        
        watchGradeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            watchGradeDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureNationStackView() {
        nationStackView.distribution = .fill
        nationStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "제작국가"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        nationStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        nationDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nationDescriptionLabel.numberOfLines = 0
        nationDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        nationStackView.addArrangedSubview(nationDescriptionLabel)
        
        nationDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nationDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureGenreStackView() {
        genresStackView.distribution = .fill
        genresStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "장르"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        genresStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        genreDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        genreDescriptionLabel.numberOfLines = 0
        genreDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        genresStackView.addArrangedSubview(genreDescriptionLabel)
        
        genreDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    private func configureActorStackView() {
        actorsStackView.distribution = .fill
        actorsStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "배우"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        actorsStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieInformationStackView.leadingAnchor, constant: 10)
        ])
        
        actorDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        actorDescriptionLabel.numberOfLines = 0
        actorDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        actorsStackView.addArrangedSubview(actorDescriptionLabel)
        
        actorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: movieInformationStackView.leadingAnchor, constant: 90)
        ])
    }
    
    func setupDescriptionLabels(director: String, productionYear: String, openDate: String, showTime: String, watchGrade: String, nation: String, genre: String, actor: String) {
        directorDescriptionLabel.text = director
        productionYearDescriptionLabel.text = productionYear
        openDateDescriptionLabel.text = openDate
        showTimeDescriptionLabel.text = showTime
        watchGradeDescriptionLabel.text = watchGrade
        nationDescriptionLabel.text = nation
        genreDescriptionLabel.text = genre
        actorDescriptionLabel.text = actor
    }
}
