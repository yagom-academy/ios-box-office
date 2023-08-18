//
//  BoxOfficeIconCell.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/15.
//

import UIKit

final class BoxOfficeIconCell: UICollectionViewListCell {
    static let identifier = "boxOfficeIconCell"
    
    // MARK: - InformationStackView
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let movieNameLabel: UILabel = DetailLabel(fontStyle: .body)
    let rankInformationLabel: UILabel = DetailLabel(fontStyle: .body)
    let audienceCountLabel: UILabel = DetailLabel(fontStyle: .caption1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureIconCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

// MARK: - Constraints
extension BoxOfficeIconCell {
    private func configureIconCell() {
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(rankLabel)
        contentStackView.addArrangedSubview(movieNameLabel)
        contentStackView.addArrangedSubview(rankInformationLabel)
        contentStackView.addArrangedSubview(audienceCountLabel)
    }
    
    private func setupConstraints() {
        setupContentStackViewConstraints()
    }
    
    private func setupContentStackViewConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
