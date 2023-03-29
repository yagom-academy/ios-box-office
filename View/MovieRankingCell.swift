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
            self.audienceLabel.text = movieItem?.audienceInfoText
        }
    }
    
    private let rankLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let rankStatusLabel = {
        let label = UILabel()
        return label
    }()
    
    private let movieNameLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
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
            rankStackView.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 0.25),
            rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            rankStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            movieInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieInfoStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            movieInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
    
}
