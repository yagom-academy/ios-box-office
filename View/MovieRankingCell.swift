//
//  MovieRankingCell.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/29.
//

import UIKit

final class MovieRankingCell: UICollectionViewListCell {
        
    static let identifier = "MovieRankingCell"
    
    // MARK: UI Properties
    private let rankStatusLabel = UILabel()
    private let audienceLabel = UILabel()
    private let rankStackView = UIStackView()
    private let movieInfoStackView = UIStackView()
    
    private let rankLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let movieNameLabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRankStackView()
        configureMovieInfoStackView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabelText(for manager: CellUIModel) {
        self.rankLabel.text = manager.rank
        self.rankStatusLabel.attributedText = manager.rankStatusAttributedText
        self.movieNameLabel.text = manager.name
        self.audienceLabel.text = manager.audienceInfoText
    }
}

// MARK: UI
extension MovieRankingCell {
    private func configureUI() {
        self.accessories = [.disclosureIndicator()]
        
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
    
    private func configureRankStackView() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankStatusLabel)
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.axis = .vertical
        rankStackView.alignment = .center
    }
    
    private func configureMovieInfoStackView() {
        movieInfoStackView.addArrangedSubview(movieNameLabel)
        movieInfoStackView.addArrangedSubview(audienceLabel)
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.axis = .vertical
    }
}
