//
//  DailyBoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "DailyBoxOfficeCollectionViewCell"

    private let accessoryImageView = UIImageView()
    private let separatorView = UIView()
    private let mainStackView = UIStackView()
    private let movieRankStackView = UIStackView()
    private let movieListStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieListStackView.subviews.forEach { $0.removeFromSuperview() }
        movieRankStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureCell() {
        configureContentView()
        configureSeparatorView()
        configureMainStackView()
        configureAccessoryImageView()
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
    
    func configureMovieRankStackView(_ rankLabel: UILabel, and audienceVarianceLabel: UILabel) {
        movieRankStackView.axis = .vertical
        movieRankStackView.distribution = .fill
        
        movieRankStackView.addArrangedSubview(rankLabel)
        movieRankStackView.addArrangedSubview(audienceVarianceLabel)
        
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRankStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    func configureMovieListStackView(_ listLabel: UILabel, and audienceInformationLabel: UILabel) {
        movieListStackView.axis = .vertical
        movieListStackView.distribution = .fillProportionally
        movieListStackView.spacing = 5
        
        movieListStackView.addArrangedSubview(listLabel)
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
}

