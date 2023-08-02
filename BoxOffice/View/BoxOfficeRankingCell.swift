//
//  BoxOfficeRankingCell.swift
//  BoxOffice
//
//  Created by 예찬 on 2023/08/02.
//

import UIKit

@available(iOS 14.0, *)
class BoxOfficeRankingCell: UICollectionViewListCell {
    let rankLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let rankIntensityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(audienceLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(rankIntensityLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            rankIntensityLabel.widthAnchor.constraint(equalTo: rankLabel.widthAnchor),
            rankIntensityLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankIntensityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankIntensityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setUpLabelText(_ data: BoxOfficeEntity.BoxOfficeResult.DailyBoxOffice) {
        rankLabel.text = "\(data.rank)"
        rankIntensityLabel.text = "\(data.rankIntensity)"
        movieNameLabel.text = data.movieName
        audienceLabel.text = "오늘 \(data.audienceCount) / 총 \(data.audienceAccumulate)"
    }
}
