//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/31.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: BoxOfficeCollectionViewCell.self)
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemFill
        
        return view
    }()
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = .zero
        
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        
        return label
    }()
    
    private let rankChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        
        return label
    }()
    
    private let movieInfomationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = .zero
        
        return stackView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let forwardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = .systemGray
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankChangeLabel.attributedText = nil
    }
}

// MARK: setup Data
extension BoxOfficeCollectionViewCell {
    func setupBoxOfficeData(_ dailyBoxOfficeData: DailyBoxOffice) {
        rankLabel.text = dailyBoxOfficeData.rank
        rankChangeLabel.text = dailyBoxOfficeData.rankState
        movieTitleLabel.text = dailyBoxOfficeData.movieTitle
        audienceCountLabel.text = dailyBoxOfficeData.dailyAndTotalAudience
        
        let rankStateColor = dailyBoxOfficeData.rankStateColor
        
        rankChangeLabel.convertColor(target: rankStateColor.targetString, as: rankStateColor.color)
    }
}

// MARK: setup UI
extension BoxOfficeCollectionViewCell {
    private func configureUI() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankChangeLabel)
        movieInfomationStackView.addArrangedSubview(movieTitleLabel)
        movieInfomationStackView.addArrangedSubview(audienceCountLabel)
        
        contentView.addSubview(seperatorView)
        contentView.addSubview(rankStackView)
        contentView.addSubview(movieInfomationStackView)
        contentView.addSubview(forwardImageView)
    }
    
    private func setupConstraint() {
        setupSeperatorVeiwConstraint()
        setupRankStackVeiwConstraint()
        setupMovieInfomationStackViewConstraint()
        setupForwardImageViewConstraint()
    }
    
    private func setupSeperatorVeiwConstraint() {
        NSLayoutConstraint.activate([
            seperatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            seperatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            seperatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupRankStackVeiwConstraint() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupMovieInfomationStackViewConstraint() {
        NSLayoutConstraint.activate([
            movieInfomationStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 32),
            movieInfomationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupForwardImageViewConstraint() {
        NSLayoutConstraint.activate([
            forwardImageView.leadingAnchor.constraint(greaterThanOrEqualTo: movieInfomationStackView.trailingAnchor, constant: 32),
            forwardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            forwardImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            forwardImageView.widthAnchor.constraint(equalToConstant: 12),
            forwardImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
