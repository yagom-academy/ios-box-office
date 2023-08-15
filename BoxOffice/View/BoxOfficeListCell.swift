//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/02.
//

import UIKit

final class BoxOfficeListCell: UICollectionViewListCell {
    static let identifier = "boxOfficeListCell"
    
    // MARK: - Separator
    private var separatorConstraint: NSLayoutConstraint?
    private func updateSeparatorConstraint() {
        if let existingConstraint = separatorConstraint, existingConstraint.isActive {
            return
        }
        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        constraint.isActive = true
        separatorConstraint = constraint
    }
    
    // MARK: - RankStackView
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        
        return stackView
    }()
    
    // MARK: - ContentStackView
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.init(1), for: .vertical)
        stackView.axis = .vertical
        
        return stackView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let rankInformationLabel: UILabel = DetailLabel(fontStyle: .body)
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(1), for: .vertical)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        
        return label
    }()
    
    let audienceCountLabel: UILabel = DetailLabel(fontStyle: .body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureListCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

// MARK: - Constraints
extension BoxOfficeListCell {
    private func configureListCell() {
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        addSubview(rankStackView)
        addSubview(contentStackView)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInformationLabel)
        
        contentStackView.addArrangedSubview(movieNameLabel)
        contentStackView.addArrangedSubview(audienceCountLabel)
    }
    
    private func setupConstraints() {
        updateSeparatorConstraint()
        setupRankStackViewConstraints()
        setupContentStackViewViewConstraints()
    }
    
    private func setupRankStackViewConstraints() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rankStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.15),
            rankStackView.topAnchor.constraint(equalTo: contentStackView.topAnchor)
        ])
        
        let bottomAnchor = rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        
        bottomAnchor.isActive = true
        bottomAnchor.priority = .defaultLow
    }
    
    private func setupContentStackViewViewConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
