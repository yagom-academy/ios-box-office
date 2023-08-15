//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/31.
//

import UIKit

final class BoxOfficeCollectionViewListCell: UICollectionViewCell {
    static let identifier = String(describing: BoxOfficeCollectionViewListCell.self)
    
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
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    private let rankChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
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
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        
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
extension BoxOfficeCollectionViewListCell {
    func setupLabels(_ dailyBoxOffice: DailyBoxOffice) {
        rankLabel.text = dailyBoxOffice.rank
        rankChangeLabel.text = dailyBoxOffice.rankState
        movieTitleLabel.text = dailyBoxOffice.movieTitle
        audienceCountLabel.text = dailyBoxOffice.dailyAndTotalAudience
        
        let rankStateColor = dailyBoxOffice.rankStateColor
        
        rankChangeLabel.convertColor(target: rankStateColor.targetString, as: rankStateColor.color)
    }
}

// MARK: configure UI
extension BoxOfficeCollectionViewListCell {
    private func configureUI() {
        configureRankStackView()
        configureMovieInfomationStackView()
        configureContentView()
    }
    
    private func configureRankStackView() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankChangeLabel)
    }
    
    private func configureMovieInfomationStackView() {
        movieInfomationStackView.addArrangedSubview(movieTitleLabel)
        movieInfomationStackView.addArrangedSubview(audienceCountLabel)
    }
    
    private func configureContentView() {
        contentView.addSubview(seperatorView)
        contentView.addSubview(rankStackView)
        contentView.addSubview(movieInfomationStackView)
        contentView.addSubview(forwardImageView)
    }
}
 
// MARK: setup Constraint
extension BoxOfficeCollectionViewListCell {
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
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupMovieInfomationStackViewConstraint() {
        NSLayoutConstraint.activate([
            movieInfomationStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 32),
            movieInfomationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieInfomationStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
            movieInfomationStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupForwardImageViewConstraint() {
        NSLayoutConstraint.activate([
            forwardImageView.leadingAnchor.constraint(greaterThanOrEqualTo: movieInfomationStackView.trailingAnchor, constant: 16),
            forwardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            forwardImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            forwardImageView.widthAnchor.constraint(equalToConstant: 12),
            forwardImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
