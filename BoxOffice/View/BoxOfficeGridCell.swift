//
//  BoxOfficeGridCell.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/05.
//

import UIKit

final class BoxOfficeGridCell: UICollectionViewCell {
    static let identifier = "boxOfficeGridCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let rankIntensityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankIntensityLabel.textColor = .black
    }
    
    func updateLabel(with boxOfficeData: BoxOfficeData, _ rankIntensityText: NSMutableAttributedString) {
        rankLabel.text = boxOfficeData.rank
        rankIntensityLabel.text = boxOfficeData.rankIntensity
        movieNameLabel.text = boxOfficeData.movieName
        
        guard let audienceCount = CountFormatter.decimal.string(for: Int(boxOfficeData.audienceCount)),
              let audienceAccumulate = CountFormatter.decimal.string(for: Int(boxOfficeData.audienceAccumulate))
        else { return }
        
        audienceLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulate)"
        rankIntensityLabel.attributedText = rankIntensityText
    }
}

extension BoxOfficeGridCell {
    private func configureUI() {
        self.layer.borderWidth = 1
        
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(rankIntensityLabel)
        stackView.addArrangedSubview(audienceLabel)
        
        contentView.addSubview(stackView)
        setUpStackViewConstraints()
    }
    
    private func setUpStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 10
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -10
            ),
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
        ])
    }
}
