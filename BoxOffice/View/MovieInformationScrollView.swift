//
//  MovieInformationScrollView.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationScrollView: UIScrollView {
    var movie: MovieInformation.MovieInformationResult.Movie?
    
    private let movieInformationContentView = UIView()
    private let movieInformationStackView = UIStackView()
    let moviePosterImageView = UIImageView()
    
    private var directorStackView = UIStackView()
    private var productionYearStackView = UIStackView()
    private var openDateStackView = UIStackView()
    private var showTimeStackView = UIStackView()
    private var watchGradeStackView = UIStackView()
    private var nationStackView = UIStackView()
    private var genresStackView = UIStackView()
    private var actorsStackView = UIStackView()
    
    func configure() {
        self.addSubview(movieInformationContentView)
        
        configureContentView()
        configureStackView()
        configureImageView()
        configureDirectorStackView()
        configureProductionYearStackView()
        configureOpenDateStackView()
        configureShowTimeStackView()
        configureWatchGradeStackView()
        configureNationStackView()
        configureGenreStackView()
        configureActorStackView()
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
    
    private func configureDirectorStackView() {
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
        
        guard let movie = movie else { return }
        
        for index in 0..<movie.directors.count {
            if index == 0 {
                descriptionLabel.text = movie.directors[index].name
            } else {
                guard let description = descriptionLabel.text else { return }
                descriptionLabel.text = description + ", " + movie.directors[index].name
            }
        }
    }
    
    private func configureProductionYearStackView() {
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
        descriptionLabel.text = movie?.productionYear
        
        directorStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureOpenDateStackView() {
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
        descriptionLabel.text = movie?.openDate
        
        openDateStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureShowTimeStackView() {
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
        descriptionLabel.text = movie?.showTime
        
        showTimeStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureWatchGradeStackView() {
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
        descriptionLabel.text = movie?.productionStatus
        
        guard let movie = movie else { return }
        
        for index in 0..<movie.audits.count {
            if index == 0 {
                descriptionLabel.text = movie.audits[index].watchGrade
            } else {
                guard let description = descriptionLabel.text else { return }
                descriptionLabel.text = description + ", " + movie.audits[index].watchGrade
            }
        }
        
        watchGradeStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureNationStackView() {
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
        nationStackView.addArrangedSubview(descriptionLabel)
        
        guard let movie = movie else { return }
        
        for index in 0..<movie.nations.count {
            if index == 0 {
                descriptionLabel.text = movie.nations[index].name
            } else {
                guard let description = descriptionLabel.text else { return }
                descriptionLabel.text = description + ", " + movie.nations[index].name
            }
        }
    }
    
    private func configureGenreStackView() {
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
        genresStackView.addArrangedSubview(descriptionLabel)
        
        guard let movie = movie else { return }
        
        for index in 0..<movie.genres.count {
            if index == 0 {
                descriptionLabel.text = movie.genres[index].name
            } else {
                guard let description = descriptionLabel.text else { return }
                descriptionLabel.text = description + ", " + movie.genres[index].name
            }
        }
    }
    
    private func configureActorStackView() {
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
        actorsStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        
        guard let movie = movie else { return }
        
        for index in 0..<movie.actors.count {
            if index == 0 {
                descriptionLabel.text = movie.actors[index].name
            } else {
                guard let description = descriptionLabel.text else { return }
                descriptionLabel.text = description + ", " + movie.actors[index].name
            }
        }
    }
}
