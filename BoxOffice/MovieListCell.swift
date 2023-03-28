//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/28.
//

import UIKit

final class MovieListCell: UICollectionViewListCell {
    
    private let rankingStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .center
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 2
        return stackview
    }()
    
    private let titleStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let stateLabel: UILabel = {
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
    
    func updateCell(with item: ListItem) {
        rankingLabel.text = "\(item.rank)"
        stateLabel.attributedText = createStateLabel(rankOldandNew: item.rankOldandNew, rankInten: Int(item.rankInten)!)
        titleLabel.text = "\(item.movieName)"
        subtitleLabel.text = "오늘 \(Int(item.audienceCount)?.decimalString ?? "0") / 총 \(Int(item.audienceAcc)?.decimalString ?? "0")"
    }
    
    private func createStateLabel(rankOldandNew: String, rankInten: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        if rankOldandNew == "OLD" {
            if rankInten == 0 {
                attributedString.add(string: "-")
            } else if rankInten > 0 {
                attributedString.add(string: "▲", color: .systemRed)
                attributedString.add(string: "\(rankInten)")
            } else {
                attributedString.add(string: "▼", color: .systemBlue)
                attributedString.add(string: "\(-rankInten)")
            }
        } else {
            attributedString.add(string: "신작", color: .systemRed)
        }
        
        return attributedString
        
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
