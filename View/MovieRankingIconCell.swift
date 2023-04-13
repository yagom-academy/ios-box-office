//
//  MovieRankingIconCell.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/07.
//

import UIKit

final class MovieRankingIconCell: UICollectionViewCell {
    // MARK: UI Properties
    private let mainStackView = UIStackView()
    
    private let rankLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .largeTitle))
    private let movieNameLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .title3), numberOfLine: 2)
    private let rankStatusLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .body))
    private let audienceLabel = UILabel(fontStyle: .preferredFont(forTextStyle: .largeTitle))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
extension MovieRankingIconCell {
    private func configureUI() {
        self.layer.borderWidth = 0.5
        
        configureLabelTextAlignment()
        configureMainStackView()
        configureRankStackView()
        configureMovieNameStackView()
        configureStatusStackView()
    }
    
    private func configureLabelTextAlignment() {
        [rankLabel, movieNameLabel, movieNameLabel, audienceLabel].forEach { label in
            label.textAlignment = .center
        }
    }
    
    private func configureMainStackView() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func configureRankStackView() {
        let rankStackView = UIStackView(arrangedSubviews: [rankLabel])
        
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(rankStackView)
    }
    
    private func configureMovieNameStackView() {
        let movieNameStackView = UIStackView(arrangedSubviews: [movieNameLabel])
        
        movieNameStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(movieNameStackView)
    }
    
    private func configureStatusStackView() {
        let statusStackView = UIStackView(arrangedSubviews: [rankStatusLabel, audienceLabel])
        
        statusStackView.axis = .vertical
        statusStackView.spacing = 1
        statusStackView.alignment = .center
        statusStackView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        mainStackView.addArrangedSubview(statusStackView)
    }
}
