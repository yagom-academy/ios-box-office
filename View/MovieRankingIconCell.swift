//
//  MovieRankingIconCell.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/07.
//

import UIKit

class MovieRankingIconCell: UICollectionViewCell {
    static let identifier = "MovieRankingIconCell"
    
    // MARK: UI Properties
    private let rankLabel = UILabel(fontStyle: .largeTitle)
    private let movieNameLabel = UILabel(fontStyle: .title3, numberOfLine: 0)
    private let rankStatusLabel = UILabel(fontStyle: .body)
    private let audienceLabel = UILabel(fontStyle: .largeTitle)
    
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
        
        let mainStackView = UIStackView()
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
        
        let rankStackView = UIStackView(arrangedSubviews: [rankLabel])
        
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(rankStackView)
        
        let movieNameStackView = UIStackView(arrangedSubviews: [movieNameLabel])
        
        movieNameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(movieNameStackView)
        
        let statusStackView = UIStackView(arrangedSubviews: [rankStatusLabel, audienceLabel])
        
        statusStackView.axis = .vertical
        statusStackView.spacing = 1
        statusStackView.alignment = .center
        statusStackView.distribution = .fillEqually
        
        mainStackView.addArrangedSubview(statusStackView)
    }
}
