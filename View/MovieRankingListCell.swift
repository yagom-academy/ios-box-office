//
//  MovieRankingCell.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/29.
//

import UIKit

final class MovieRankingListCell: UICollectionViewListCell {
    // MARK: UI Properties
    private let rankStackView = UIStackView()
    private let movieInfoStackView = UIStackView()
    
    private let rankLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .largeTitle))
    private let rankStatusLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .body))
    private let movieNameLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .title3), numberOfLine: 0)
    private let audienceLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .body))
    
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
extension MovieRankingListCell {
    private func configureRankStackView() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankStatusLabel)
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.axis = .vertical
        rankStackView.alignment = .center
        
        rankLabel.heightAnchor.constraint(equalTo: rankStackView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func configureMovieInfoStackView() {
        movieInfoStackView.addArrangedSubview(movieNameLabel)
        movieInfoStackView.addArrangedSubview(audienceLabel)
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.axis = .vertical
        
        movieNameLabel.heightAnchor.constraint(equalTo: movieInfoStackView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func configureUI() {
        self.accessories = [.disclosureIndicator()]
        
        contentView.addSubview(rankStackView)
        contentView.addSubview(movieInfoStackView)
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor , multiplier: 0.25),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            movieInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieInfoStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            movieInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            movieInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            movieInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
