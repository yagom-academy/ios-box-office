//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/02.
//

import UIKit

final class BoxOfficeCell: UICollectionViewListCell {
    static let identifier = "boxOfficeCell"
    
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
    
    // MARK: - InformationStackView
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    // MARK: - RankStackView
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        return stackView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let rankInformationLabel: UILabel = DetailLabel()
    let detailLabel: UILabel = DetailLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

// MARK: - Constraints
extension BoxOfficeCell {
    private func configureCell() {
        configureUI()
        setUpConstraints()
    }
    
    private func configureUI() {
        addSubview(informationStackView)
        
        informationStackView.addArrangedSubview(rankStackView)
        informationStackView.addArrangedSubview(detailLabel)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInformationLabel)
    }
    
    private func setUpConstraints() {
        updateSeparatorConstraint()
        setUpInformationStackViewConstraints()
        setUpRankStackViewConstraints()
    }
    
    private func setUpInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            informationStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setUpRankStackViewConstraints() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            rankStackView.widthAnchor.constraint(equalTo: informationStackView.widthAnchor, multiplier: 0.15),
            rankStackView.topAnchor.constraint(equalTo: informationStackView.topAnchor)
        ])
    }
}
