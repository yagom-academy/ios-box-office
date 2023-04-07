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
    private let rankStatusLabel = UILabel()
    private let audienceLabel = UILabel()
    
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
        
        let mainStackView = UIStackView(arrangedSubviews: [rankLabel, movieNameLabel, rankStatusLabel, audienceLabel])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
