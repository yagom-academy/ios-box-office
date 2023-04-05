//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewCell {
    static let identifier = "DailyBoxOfficeCell"
    
    private var viewModel: DailyBoxOfficeCellViewModel? {
        didSet {
            configureLabels()
        }
    }
    
    private let rankLabel = UILabel()
    private let rankDifferenceLabel = UILabel()
    private let movieTitleLabel = UILabel()
    private let audienceCountLabel = UILabel()
    private let rankStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let movieStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let accessoryView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        let symbolName = "chevron.right"
        
        imageView.image = UIImage(systemName: symbolName, withConfiguration: configuration)
        imageView.tintColor = UIColor.systemGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemGray6
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBorder()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankDifferenceLabel.textColor = .black
    }
    
    private func setBorder() {
        layer.addBorder(color: .systemGray5, width: 1)
    }
    
    private func configureSubviews() {
        configureViewHierarchy()
        configureSubviewConstraints()
    }
    
    private func configureViewHierarchy() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankDifferenceLabel)
        
        movieStackView.addArrangedSubview(movieTitleLabel)
        movieStackView.addArrangedSubview(audienceCountLabel)
        
        contentView.addSubview(rankStackView)
        contentView.addSubview(movieStackView)
        contentView.addSubview(accessoryView)
    }
    
    private func configureSubviewConstraints() {
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 10),
            movieStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            accessoryView.leadingAnchor.constraint(equalTo: movieStackView.trailingAnchor),
            accessoryView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            accessoryView.widthAnchor.constraint(equalToConstant: 10),
            accessoryView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureLabels() {
        configureRankLabel()
        configureRankDifferenceLabel()
        configureMovieTitleLabel()
        configureAudienceCountLabel()
    }
    
    private func configureMovieTitleLabel() {
        movieTitleLabel.text = viewModel?.movieTitle
        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieTitleLabel.numberOfLines = 0
    }
    
    private func configureAudienceCountLabel() {
        audienceCountLabel.text = viewModel?.audienceCount
        audienceCountLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private func configureRankLabel() {
        rankLabel.text = viewModel?.rank
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    func setupViewModel(with data: DailyBoxOfficeMovie) {
        self.viewModel = DailyBoxOfficeCellViewModel(data: data)
    }
    
    private func configureRankDifferenceLabel() {
        guard let viewModel = self.viewModel else { return }
        
        let text = viewModel.rankDifference
        
        switch viewModel.rankOldAndNew {
        case .new:
            rankDifferenceLabel.text = text
            rankDifferenceLabel.textColor = .systemRed
        case .old:
            if text.contains(Sign.down) {
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: Sign.down)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
                rankDifferenceLabel.attributedText = attributedString
            } else if text.contains(Sign.up) {
                let attributedString = NSMutableAttributedString(string: text)
                let range = NSString(string: text).range(of: Sign.up)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
                rankDifferenceLabel.attributedText = attributedString
            } else {
                rankDifferenceLabel.text = text
            }
            
            rankDifferenceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        }
    }
    
    private enum Sign {
        static let newMovie = "신작"
        static let minus = "-"
        static let zero = "0"
        static let down = "⏷"
        static let up = "⏶"
    }
}
