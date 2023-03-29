//
//  MovieRankingCell.swift
//  BoxOffice
//
//  Created by Andrew on 2023/03/29.
//

import UIKit

class MovieRankingCell: UICollectionViewListCell {
        
    static let identifier = "MovieRankingCell"
    
    var movieItem: InfoObject? {
        didSet {
            self.rankLabel.text = movieItem?.rank
            self.rankStatusLabel.text = movieItem?.rankStatus
            self.movieNameLabel.text = movieItem?.name
            self.audienceLabel.text = movieItem?.numberOfAudience
        }
    }
    
    private let rankLabel = {
        let label = UILabel()
        return label
    }()
    
    private let rankStatusLabel = {
        let label = UILabel()
        return label
    }()
    
    private let movieNameLabel = {
        let label = UILabel()
        return label
    }()
    
    private var audienceLabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var rankStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel, rankStatusLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var movieInfoStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, audienceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        self.accessories = [.disclosureIndicator()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(rankStackView)
        addSubview(movieInfoStackView)
        
        NSLayoutConstraint.activate([
            rankStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rankStackView.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 0.25),
            
            movieInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieInfoStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
}
