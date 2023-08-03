//
//  MainCollectionViewCell.swift
//  BoxOffice
//
//  Created by 1 on 2023/08/03.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        return label
    }()
    
    private let rankIntenLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        return label
    }()
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        return stackView
    }()
    
    private let movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 25
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func configureUI() {
        [rankLabel, rankIntenLabel].forEach { rankStackView.addArrangedSubview($0) }
        [movieNameLabel, audienceCountLabel].forEach { movieDescriptionStackView.addArrangedSubview($0) }
        [rankStackView, movieDescriptionStackView].forEach { movieInformationStackView.addArrangedSubview($0) }
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            movieInformationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
