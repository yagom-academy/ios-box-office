//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Kiseok on 12/5/23.
//

import UIKit

class MovieListCell: UICollectionViewListCell {
    private var rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private var rankFluctuationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
            
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addSubview(rankLabel)
        stackView.addSubview(rankFluctuationLabel)
        return stackView
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
            
        return label
    }()
    
    private var audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
            
        return label
    }()
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        
        stackView.addSubview(movieNameLabel)
        stackView.addSubview(audienceCountLabel)
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessories = [.disclosureIndicator()]
        addSubview(rankStackView)
        addSubview(movieStackView)
        
        autoLayout()
    }
    
    func configureLabelText(_ movie: DailyBoxOfficeList) {
        rankLabel.text = movie.rank
        rankFluctuationLabel.text = movie.audienceFluctuation
        movieNameLabel.text = movie.movieName
        audienceCountLabel.text = "오늘 \(movie.audienceCount)명 / 총 \(movie.audienceAccumulation)명"
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 30),
            rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rankStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            movieStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 20),
            movieStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20)
        ])
    }
}
