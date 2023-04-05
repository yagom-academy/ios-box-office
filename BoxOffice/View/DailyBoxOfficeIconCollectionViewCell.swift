//
//  DailyBoxOfficeIconCollectionViewCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/04.
//

import UIKit

final class DailyBoxOfficeIconCollectionViewCell: UICollectionViewCell, LabelSetter {
    static let reuseIdentifier = "DailyBoxOfficeIconCollectionViewCell"

    private let mainStackView = UIStackView()
    private let rankLabel = UILabel()
    private let nameLabel = UILabel()
    
    private let movieRankVarianceStackView = UIStackView()
    private let rankMarkLabel = UILabel()
    private let audienceVarianceLabel = UILabel()

    private let audienceInformationLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureCell() {
        configureContentView()
        configureMainStackView()
        configureLabels()
        configureMovieRankVarianceStackView()
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1.0),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 5
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func configureLabels() {
        mainStackView.addArrangedSubview(rankLabel)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(movieRankVarianceStackView)
        mainStackView.addArrangedSubview(audienceInformationLabel)
        
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankLabel.textAlignment = .center
        rankLabel.adjustsFontForContentSizeCategory = true
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontForContentSizeCategory = true
        
        rankMarkLabel.font = UIFont.preferredFont(forTextStyle: .body)
        rankMarkLabel.adjustsFontForContentSizeCategory = true
        
        audienceVarianceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceVarianceLabel.textAlignment = .center
        audienceVarianceLabel.adjustsFontForContentSizeCategory = true
        
        audienceInformationLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        audienceInformationLabel.numberOfLines = 0
        audienceInformationLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func configureMovieRankVarianceStackView() {
        movieRankVarianceStackView.axis = .horizontal
        movieRankVarianceStackView.distribution = .fill
        
        movieRankVarianceStackView.addArrangedSubview(rankMarkLabel)
        movieRankVarianceStackView.addArrangedSubview(audienceVarianceLabel)
    }
    
    func setupLabels(name: String, audienceInformation: String, rank: String, rankMark: String, audienceVariance: String, rankMarkColor: MovieRankMarkColor) {
        nameLabel.text = name
        audienceInformationLabel.text = audienceInformation
        rankLabel.text = rank
        rankMarkLabel.text = rankMark
        audienceVarianceLabel.text = audienceVariance
        
        switch rankMarkColor {
        case .red:
            rankMarkLabel.textColor = .systemRed
        case .black:
            rankMarkLabel.textColor = .black
        case .blue:
            rankMarkLabel.textColor = .systemBlue
        }
    }
}
