//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import SwiftUI

final class BoxOfficeCollectionViewCell: UICollectionViewListCell, Reusable {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.preferredFont(for: .largeTitle, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let rankVariationLabel: UILabel = {
        let label = UILabel()
        label.text = "▼1"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "경관의 피asdfasdfasdfasdfaasdffeqwef\nasdf"
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 64,050 / 총 69,228"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    func configureCell() {
        addSubviews()
        setUpConstraints()
    }
}

// MARK: - Add Subviews
extension BoxOfficeCollectionViewCell {
    private func addSubviews() {
        [rankLabel, rankVariationLabel, movieNameLabel, audienceNumberLabel].forEach {
            addSubview($0)
        }
        
        accessories = [.disclosureIndicator()]
    }
}

// MARK: - Constraints
extension BoxOfficeCollectionViewCell {
    private func setUpConstraints() {
        rankLabelConstraints()
        rankVariationLabelConstraints()
        movieNameLabelConstraints()
        audienceNumberLabelConstraints()
        separatorConstraints()
    }
    
    private func separatorConstraints() {
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    private func rankLabelConstraints() {
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        ])
    }
    
    private func rankVariationLabelConstraints() {
        rankVariationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankVariationLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankVariationLabel.centerXAnchor.constraint(equalTo: rankLabel.centerXAnchor),
            rankVariationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func movieNameLabelConstraints() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 24),
            movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieNameLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            movieNameLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8)
        ])
    }
    
    private func audienceNumberLabelConstraints() {
        audienceNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audienceNumberLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            audienceNumberLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 4),
            audienceNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Preview
struct BoxOfficeCollectionViewCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            BoxOfficeCollectionViewCell()
        }.previewLayout(.sizeThatFits)
    }
}
