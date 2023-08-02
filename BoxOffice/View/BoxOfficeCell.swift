//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/02.
//

import UIKit

final class BoxOfficeCell: UICollectionViewCell {
    static let identifier = "boxOfficeCell"
    
    private let superStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemBackground
        
        return stackView
    }()
    
    // MARK: - InformationStackView
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - RankStackView
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let rankInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "▼▲1"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    // MARK: - Movie Name, Audience Information
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "TestTitle\nMoviewDetail"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    // MARK: - Separator
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.frame.size = CGSize(width: self.superStackView.frame.width, height: 1)
        
        return view
    }()
}

// MARK: - Constraints
extension BoxOfficeCell {
    func configureCell() {
        configureUI()
        setUpConstraints()
    }
    
    private func configureUI() {
        addSubview(superStackView)
        
        superStackView.addArrangedSubview(informationStackView)
        superStackView.addArrangedSubview(separatorLineView)
        
        informationStackView.addArrangedSubview(rankStackView)
        informationStackView.addArrangedSubview(detailLabel)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInformationLabel)
    }
    
    private func setUpConstraints() {
        setUpSuperStackViewConstraints()
        setUpInformationStackViewConstraints()
        setUpSeparatorLineViewConstraints()
        setUpRankStackViewConstraints()
        setUpDetailLabelConstraints()
    }
    
    private func setUpSuperStackViewConstraints() {
        NSLayoutConstraint.activate([
            superStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            superStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            superStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func setUpInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: superStackView.leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: superStackView.trailingAnchor),
            informationStackView.topAnchor.constraint(equalTo: superStackView.topAnchor),
            informationStackView.bottomAnchor.constraint(equalTo: superStackView.bottomAnchor)
        ])
    }
    
    private func setUpSeparatorLineViewConstraints() {
        NSLayoutConstraint.activate([
            separatorLineView.leadingAnchor.constraint(equalTo: superStackView.leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: superStackView.trailingAnchor),
            separatorLineView.bottomAnchor.constraint(equalTo: superStackView.bottomAnchor)
        ])
    }
    
    private func setUpRankStackViewConstraints() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor, constant: 8),
            rankStackView.widthAnchor.constraint(equalTo: superStackView.widthAnchor, multiplier: 0.15),
            rankStackView.topAnchor.constraint(equalTo: informationStackView.topAnchor)
        ])
    }
    
    private func setUpDetailLabelConstraints() {
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: informationStackView.trailingAnchor, constant: 4),
            detailLabel.centerYAnchor.constraint(equalTo: superStackView.centerYAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: superStackView.trailingAnchor, constant: -8)
        ])
    }
}
