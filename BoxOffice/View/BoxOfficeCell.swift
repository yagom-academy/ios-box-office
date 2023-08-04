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
        
        return stackView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    let rankInformationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    // MARK: - Movie Name, Audience Information
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
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
    func configureCell() {
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
        setUpDetailLabelConstraints()
    }
    
    private func setUpInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            informationStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setUpRankStackViewConstraints() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor, constant: 8),
            rankStackView.widthAnchor.constraint(equalTo: informationStackView.widthAnchor, multiplier: 0.15),
            rankStackView.topAnchor.constraint(equalTo: informationStackView.topAnchor, constant: -1)
        ])
    }
    
    private func setUpDetailLabelConstraints() {
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: informationStackView.trailingAnchor, constant: 4),
            detailLabel.centerYAnchor.constraint(equalTo: informationStackView.centerYAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: informationStackView.leadingAnchor)
        ])
    }
}
