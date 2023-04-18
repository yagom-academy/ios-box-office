//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

final class BoxOfficeListCell: UICollectionViewCell {
    private let rankLabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let rankInfoLabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let movieNameLabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let audienceCountLabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
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
        stackView.setContentHuggingPriority(.init(rawValue: 1), for: .horizontal)
        
        return stackView
    }()
    
    private let accessoryView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        let symbolName = "chevron.right"
        
        imageView.image = UIImage(systemName: symbolName, withConfiguration: configuration)
        imageView.tintColor = UIColor.systemGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return imageView
    }()
    
    private let boxOfficeStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemGray5
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureBoxOfficeStackView()
        drawCellBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureBoxOfficeStackView() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInfoLabel)
        
        movieStackView.addArrangedSubview(movieNameLabel)
        movieStackView.addArrangedSubview(audienceCountLabel)
        
        boxOfficeStackView.addArrangedSubview(rankStackView)
        boxOfficeStackView.addArrangedSubview(movieStackView)
        boxOfficeStackView.addArrangedSubview(accessoryView)
        
        contentView.addSubview(boxOfficeStackView)
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalTo: boxOfficeStackView.widthAnchor, multiplier: 0.2),
            
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            
            accessoryView.trailingAnchor.constraint(equalTo: boxOfficeStackView.trailingAnchor),

            boxOfficeStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            boxOfficeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            boxOfficeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            boxOfficeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func drawCellBorder() {
        layer.drawBorder(color: .systemGray5, width: 1)
    }
    
    private func configureRankLabel(data: DailyBoxOfficeItem) {
        rankLabel.text = data.rank
    }
    
    private func configureRankInfoLabel(data: DailyBoxOfficeItem) {
        let oldAndNew = data.rankOldAndNew
        
        if oldAndNew == .new {
            rankInfoLabel.textColor = RankInfo.new.fontColor
            rankInfoLabel.text = RankInfo.new.description
        } else {
            guard let variance = Int(data.rankingIntensity) else { return }
            
            switch variance {
            case ..<0:
                rankInfoLabel.textColor = RankInfo.decrease(variance).fontColor
                rankInfoLabel.attributedText = RankInfo.decrease(variance).description.attributeText()
            case 1...:
                rankInfoLabel.textColor = RankInfo.increase(variance).fontColor
                rankInfoLabel.attributedText = RankInfo.increase(variance).description.attributeText()
            default:
                rankInfoLabel.textColor = RankInfo.noChange.fontColor
                rankInfoLabel.text = RankInfo.noChange.description
            }
        }
    }
    
    private func configureMovieNameLabel(data: DailyBoxOfficeItem) {
        movieNameLabel.text = data.movieName
    }
    
    private func configureAudienceCountLabel(data: DailyBoxOfficeItem) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        audienceCountLabel.text = "오늘 \(data.audienceCount.applyNumberFormatter(formatter: numberFormatter)) / 총 \(data.audienceAccumulation.applyNumberFormatter(formatter: numberFormatter))"
    }
    
    func configure(with boxOfficeItem: DailyBoxOfficeItem) {
        configureRankLabel(data: boxOfficeItem)
        configureRankInfoLabel(data: boxOfficeItem)
        configureMovieNameLabel(data: boxOfficeItem)
        configureAudienceCountLabel(data: boxOfficeItem)
    }
}

// MARK: - variance String extension

extension String {
    func attributeText() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: String(self.dropFirst(1)))
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        
        return attributedString
    }
}
