//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/28.
//

import UIKit

final class MovieListCell: UICollectionViewListCell {
    
    let rankingStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .center
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 2
        return stackview
    }()
    
    let titleStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(rankingStackview)
        rankingStackview.addArrangedSubview(rankingLabel)
        rankingStackview.addArrangedSubview(stateLabel)
        NSLayoutConstraint.activate([
            rankingStackview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankingStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rankingStackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            rankingStackview.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        contentView.addSubview(titleStackview)
        titleStackview.addArrangedSubview(titleLabel)
        titleStackview.addArrangedSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            titleStackview.leadingAnchor.constraint(equalTo: rankingStackview.trailingAnchor, constant: 10),
            titleStackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleStackview.centerYAnchor.constraint(equalTo: rankingStackview.centerYAnchor),
        ])
        
    }
    
}
