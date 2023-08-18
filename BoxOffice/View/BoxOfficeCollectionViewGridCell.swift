//
//  BoxOfficeCollectionViewGridCell.swift
//  BoxOffice
//
//  Created by kyungmin on 2023/08/15.
//

import UIKit

final class BoxOfficeCollectionViewGridCell: UICollectionViewCell {
    static let identifier = String(describing: BoxOfficeCollectionViewGridCell.self)
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        
        return label
    }()
    
    private let rankChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupConstraint()
        setupComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankChangeLabel.attributedText = nil
    }
}

// MARK: setup Component
extension BoxOfficeCollectionViewGridCell {
    private func setupComponent() {
        setupContentView()
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGray.cgColor

    }
}

// MARK: setup Data
extension BoxOfficeCollectionViewGridCell {
    func setupLabels(_ dailyBoxOffice: DailyBoxOffice) {
        let rankStateColor = dailyBoxOffice.rankStateColor
        rankLabel.text = dailyBoxOffice.rank
        rankChangeLabel.text = dailyBoxOffice.rankState
        movieTitleLabel.text = dailyBoxOffice.movieTitle
        audienceCountLabel.text = dailyBoxOffice.dailyAndTotalAudience
        
        rankChangeLabel.convertColor(target: rankStateColor.targetString, as: rankStateColor.color)
    }
}

// MARK: configure UI
extension BoxOfficeCollectionViewGridCell {
    private func configureUI() {
        configureContentView()
        configureTotalStackView()
    }
    
    private func configureContentView() {
        contentView.addSubview(totalStackView)
    }
    
    private func configureTotalStackView() {
        totalStackView.addArrangedSubview(rankLabel)
        totalStackView.addArrangedSubview(movieTitleLabel)
        totalStackView.addArrangedSubview(rankChangeLabel)
        totalStackView.addArrangedSubview(audienceCountLabel)
    }
}
 
// MARK: setup Constraint
extension BoxOfficeCollectionViewGridCell {
    private func setupConstraint() {
        setupTotalStackVeiwConstraint()
    }
    
    private func setupTotalStackVeiwConstraint() {
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
}
