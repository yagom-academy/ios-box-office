//
//  DailyBoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeListCollectionViewCell: UICollectionViewCell, LabelSetter {
    static let reuseIdentifier = "DailyBoxOfficeListCollectionViewCell"

    private let accessoryImageView = UIImageView()
    private let separatorView = UIView()
    private let mainStackView = UIStackView()
    
    private let movieRankStackView = UIStackView()
    private let rankLabel = UILabel()
    
    private let movieRankVarianceStackView = UIStackView()
    private let rankMarkLabel = UILabel()
    private let audienceVarianceLabel = UILabel()
    
    private let movieListStackView = UIStackView()
    private let nameLabel = UILabel()
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
        configureSeparatorView()
        configureMainStackView()
        configureAccessoryImageView()
        configureMovieRankStackView()
        configureMovieRankVarianceStackView()
        configureMovieListStackView()
        configureLabels()
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1.0),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureSeparatorView() {
        separatorView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 1)
        separatorView.autoresizingMask = .flexibleWidth
        separatorView.backgroundColor = .placeholderText
        
        addSubview(separatorView)
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.addArrangedSubview(movieRankStackView)
        mainStackView.addArrangedSubview(movieListStackView)
        mainStackView.addArrangedSubview(accessoryImageView)
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureMovieRankStackView() {
        movieRankStackView.axis = .vertical
        movieRankStackView.distribution = .fill
        movieRankStackView.alignment = .center
        
        movieRankStackView.addArrangedSubview(rankLabel)
        movieRankStackView.addArrangedSubview(movieRankVarianceStackView)
        
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRankStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureMovieRankVarianceStackView() {
        movieRankVarianceStackView.axis = .horizontal
        movieRankVarianceStackView.distribution = .fill
        
        movieRankVarianceStackView.addArrangedSubview(rankMarkLabel)
        movieRankVarianceStackView.addArrangedSubview(audienceVarianceLabel)
    }
    
    private func configureMovieListStackView() {
        movieListStackView.axis = .vertical
        movieListStackView.distribution = .fillProportionally
        movieListStackView.spacing = 5
        
        movieListStackView.addArrangedSubview(nameLabel)
        movieListStackView.addArrangedSubview(audienceInformationLabel)
    }
    
    private func configureAccessoryImageView() {
        accessoryImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.systemGray2, renderingMode: .alwaysOriginal)
        
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessoryImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            accessoryImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.025),
            accessoryImageView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureLabels() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        nameLabel.numberOfLines = 0
        
        audienceInformationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankLabel.textAlignment = .center
        
        audienceVarianceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceVarianceLabel.textAlignment = .center
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
