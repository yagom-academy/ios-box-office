//
//  DailyBoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by JSB on 2023/08/03.
//

import UIKit

class DailyBoxOfficeCollectionViewCell: UICollectionViewCell {
    let cellIdentifier: String = "DailyBoxOfficeCollectionViewCell"
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visitorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankChangeValueLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rankStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let movieStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let dailyBoxOfficeStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setUpAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        rankStackView.addSubview(rankLabel)
        rankStackView.addSubview(rankChangeValueLabel)
        
        movieStackView.addSubview(titleLabel)
        movieStackView.addSubview(visitorLabel)
        
        dailyBoxOfficeStackView.addSubview(rankStackView)
        dailyBoxOfficeStackView.addSubview(movieStackView)
        
        contentView.addSubview(dailyBoxOfficeStackView)
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: rankStackView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: rankStackView.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            rankLabel.bottomAnchor.constraint(equalTo: rankChangeValueLabel.topAnchor),
        
            rankChangeValueLabel.leadingAnchor.constraint(equalTo: rankStackView.leadingAnchor),
            rankChangeValueLabel.trailingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            rankChangeValueLabel.bottomAnchor.constraint(equalTo: rankStackView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieStackView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: movieStackView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: visitorLabel.topAnchor),
            
            visitorLabel.leadingAnchor.constraint(equalTo: movieStackView.leadingAnchor),
            visitorLabel.trailingAnchor.constraint(equalTo: movieStackView.trailingAnchor),
            visitorLabel.bottomAnchor.constraint(equalTo: movieStackView.bottomAnchor),
            
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            rankStackView.trailingAnchor.constraint(equalTo: movieStackView.leadingAnchor),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            movieStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            movieStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])
    }
    
}

