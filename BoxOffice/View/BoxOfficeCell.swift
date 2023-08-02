//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/02.
//

import UIKit

final class BoxOfficeCell: UICollectionViewCell {
    static let identifier = "boxOfficeCell"
    
    // MARK: - Separator
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.frame.size.width = view.frame.width
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - InformationStackView
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
//        stackView.spacing = 8
        stackView.backgroundColor = .systemBackground
        
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
    
    private let disclosureIndicatorLabel: UILabel = {
        var label = UILabel()
        label.text = "〉"
        label.textColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        return label
    }()
}

// MARK: - Constraints
extension BoxOfficeCell {
    func configureCell() {
        configureUI()
        setUpConstraints()
    }
    
    private func configureUI() {
        addSubview(separatorLineView)
        
        separatorLineView.addSubview(informationStackView)
        
        informationStackView.addArrangedSubview(rankStackView)
        informationStackView.addArrangedSubview(detailLabel)
        informationStackView.addArrangedSubview(disclosureIndicatorLabel)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInformationLabel)
    }
    
    private func setUpConstraints() {
        setUpSeparatorLineViewConstraints()
        setUpInformationStackViewConstraints()
        setUpRankStackViewConstraints()
        setUpDetailLabelConstraints()
        setUpDisclosureIndicatorImageConstraints()
    }
    
    private func setUpSeparatorLineViewConstraints() {
        NSLayoutConstraint.activate([
            separatorLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLineView.topAnchor.constraint(equalTo: topAnchor),
            separatorLineView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: separatorLineView.leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: separatorLineView.trailingAnchor),
            informationStackView.topAnchor.constraint(equalTo: separatorLineView.topAnchor, constant: 1),
            informationStackView.bottomAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: -1)
        ])
    }
    
    private func setUpRankStackViewConstraints() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor, constant: 8),
            rankStackView.widthAnchor.constraint(equalTo: separatorLineView.widthAnchor, multiplier: 0.15),
            rankStackView.topAnchor.constraint(equalTo: informationStackView.topAnchor, constant: -1)
        ])
    }
    
    private func setUpDetailLabelConstraints() {
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: informationStackView.trailingAnchor, constant: 4),
            detailLabel.centerYAnchor.constraint(equalTo: separatorLineView.centerYAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: disclosureIndicatorLabel.leadingAnchor)
        ])
    }
    
    private func setUpDisclosureIndicatorImageConstraints() {
        NSLayoutConstraint.activate([
            disclosureIndicatorLabel.widthAnchor.constraint(equalTo: separatorLineView.widthAnchor, multiplier: 0.08),
            disclosureIndicatorLabel.centerYAnchor.constraint(equalTo: detailLabel.centerYAnchor),
            disclosureIndicatorLabel.trailingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: 8)
        ])
    }
}
