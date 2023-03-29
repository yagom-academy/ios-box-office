//
//  MovieInformationStackView.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

class MovieInformationStackView: UIStackView {
    var movie: MovieInformation.MovieInformationResult.Movie?
    
    var moviePosterImage = UIImageView()
    
    var directorStackView = UIStackView()
    var productionYearStackView = UIStackView()
    var openDateStackView = UIStackView()
    var showTimeStackView = UIStackView()
    var productionStatusStackView = UIStackView()
    var nationStackView = UIStackView()
    var genresStackView = UIStackView()
    var actorsStackView = UIStackView()
    
    
    func configure() {
        self.spacing = 10
        self.axis = .vertical
        self.distribution = .fillEqually
        
        configureDirectorStackView()
        configureProductionYearStackView()
        configureOpenDateStackView()
        configureShowTimeStackView()
        configureProductionStatusStackView()
        configureNationStackView()
        configureGenreStackView()
        configureActorStackView()
    }
    
    private func configureDirectorStackView() {
        self.addArrangedSubview(productionYearStackView)
        productionYearStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "감독"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        productionYearStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: productionYearStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        productionYearStackView.addArrangedSubview(descriptionLabel)
        
        guard let count = movie?.directors.count else { return }
        
        for index in 0..<count {
            if index == 0 {
                descriptionLabel.text = movie?.directors[index].name
            } else {
                descriptionLabel.text! += ", " + (movie?.directors[index].name)!
            }
        }
    }
    
    private func configureProductionYearStackView() {
        self.addArrangedSubview(directorStackView)
        directorStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "제작년도"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
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
        self.addArrangedSubview(openDateStackView)
        openDateStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "개봉일"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
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
        self.addArrangedSubview(showTimeStackView)
        showTimeStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "상영시간"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        showTimeStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: showTimeStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie?.showTime
        
        showTimeStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureProductionStatusStackView() {
        self.addArrangedSubview(productionStatusStackView)
        productionStatusStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "관람등급"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        productionStatusStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: productionStatusStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie?.productionStatus
        
        productionStatusStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureNationStackView() {
        self.addArrangedSubview(nationStackView)
        nationStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "제작국가"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        nationStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: nationStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        nationStackView.addArrangedSubview(descriptionLabel)
        
        guard let count = movie?.nations.count else { return }
        
        for index in 0..<count {
            if index == 0 {
                descriptionLabel.text = movie?.nations[index].name
            } else {
                descriptionLabel.text! += ", " + (movie?.nations[index].name)!
            }
        }
    }
    
    private func configureGenreStackView() {
        self.addArrangedSubview(genresStackView)
        genresStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "장르"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        genresStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: genresStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        genresStackView.addArrangedSubview(descriptionLabel)
        
        guard let count = movie?.genres.count else { return }
        
        for index in 0..<count {
            if index == 0 {
                descriptionLabel.text = movie?.genres[index].name
            } else {
                descriptionLabel.text! += ", " + (movie?.genres[index].name)!
            }
        }
    }
    
    private func configureActorStackView() {
        self.addArrangedSubview(actorsStackView)
        actorsStackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = "배우"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        actorsStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: actorsStackView.widthAnchor, multiplier: 0.2)
        ])
        
        let descriptionLabel = UILabel()
        actorsStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        guard let count = movie?.actors.count else { return }
        
        for index in 0..<count {
            if index == 0 {
                descriptionLabel.text = movie?.actors[index].name
            } else {
                descriptionLabel.text! += ", " + (movie?.actors[index].name)!
            }
        }
    }
}
