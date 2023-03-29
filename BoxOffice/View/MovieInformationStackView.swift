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
    var nationsStackView = UIStackView()
    var genresStackView = UIStackView()
    var actorsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       configureDirectorStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDirectorStackView() {
        directorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        directorStackView.distribution = .fill
        self.addArrangedSubview(directorStackView)
        let titleLabel = UILabel()
        titleLabel.text = "감독"
        directorStackView.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
            ])
        
        let descriptionLabel = UILabel()
        directorStackView.addArrangedSubview(descriptionLabel)
        guard let count = movie?.directors.count else { return }
        for index in 0..<count {
            if index == 0 {
                descriptionLabel.text = movie!.directors[index].name
            } else {
                descriptionLabel.text! += ", " + movie!.directors[index].name
            }
        }
    }
}
