//
//  BoxOfficeIconCell.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/04/11.
//

import UIKit

final class BoxOfficeIconCell: UICollectionViewCell {
    private let rankLabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()
    
    private let rankInfoLabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private let movieNameLabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(rawValue: 1), for: .vertical)
        
        return label
    }()
    
    private let audienceCountLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let boxOfficeStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
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
        boxOfficeStackView.addArrangedSubview(rankLabel)
        boxOfficeStackView.addArrangedSubview(movieNameLabel)
        boxOfficeStackView.addArrangedSubview(rankInfoLabel)
        boxOfficeStackView.addArrangedSubview(audienceCountLabel)
        
        contentView.addSubview(boxOfficeStackView)
        
        NSLayoutConstraint.activate([
            boxOfficeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            boxOfficeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            boxOfficeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            boxOfficeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    private func drawCellBorder() {
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 5
    }
    
    private func configureRankLabel(data: DailyBoxOfficeItem){
        rankLabel.text = data.rank
    }
    
    private func configureRankInfoLabel(data: DailyBoxOfficeItem){
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
    
    private func configureMovieNameLabel(data: DailyBoxOfficeItem){
        movieNameLabel.text = data.movieName
    }
    
    private func configureAudienceCountLabel(data: DailyBoxOfficeItem){
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
    
    enum RankInfo {
        case new
        case noChange
        case increase(Int)
        case decrease(Int)
        
        var description: String {
            switch self {
            case .new:
                return "신작"
            case .noChange:
                return "-"
            case .increase(let variance):
                return "▲\(variance)"
            case .decrease(let variance):
                return "▼\(variance * -1)"
            }
        }
        
        var fontColor: UIColor {
            switch self {
            case .new:
                return .systemRed
            case .noChange:
                return .black
            case .increase:
                return .systemRed
            case .decrease:
                return .systemBlue
            }
        }
    }
}
