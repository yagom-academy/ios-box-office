//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import SwiftUI

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.preferredFont(for: .largeTitle, weight: .semibold)
        return label
    }()
    
    private let rankVariationLabel: UILabel = {
        let label = UILabel()
        label.text = "▼1"
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "경관의 피"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 64,050 / 총 69,228"
        return label
    }()

    override func prepareForReuse() {
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
    }
}

// MARK: - Constraints
extension BoxOfficeCollectionViewCell {
    private func setUpConstraints() {
        rankLabelConstraints()
        rankVariationLabelConstraints()
        movieNameLabelConstraints()
        audienceNumberLabelConstraints()
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
            rankVariationLabel.centerXAnchor.constraint(equalTo: rankLabel.centerXAnchor)
        ])
    }
    
    private func movieNameLabelConstraints() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 24),
            movieNameLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor)
        ])
    }
    
    private func audienceNumberLabelConstraints() {
        audienceNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audienceNumberLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            audienceNumberLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 4)
        ])
    }
}

// MARK: - Preview
struct PreView: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            BoxOfficeCollectionViewCell()
        }.previewLayout(.sizeThatFits)
    }
}
