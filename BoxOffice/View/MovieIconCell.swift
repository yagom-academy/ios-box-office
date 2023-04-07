//
//  MovieIconCell.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/04/05.
//

import UIKit

final class MovieIconCell: UICollectionViewCell {
    
    private let mainStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
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
        titleLabel.text = "\(item.movieName)"
        stateLabel.attributedText = createStateLabel(rankOldandNew: item.rankOldandNew, rankIntensity: Int(item.rankIntensity)!)
        subtitleLabel.text = "오늘 \(Int(item.audienceCount)?.decimalString ?? "0") / 총 \(Int(item.audienceAcc)?.decimalString ?? "0")"
    }
    
    private func createStateLabel(rankOldandNew: String, rankIntensity: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        if rankOldandNew == "OLD" {
            switch rankIntensity {
            case 0 :
                attributedString.add(string: "-")
            case let rankIntensity where rankIntensity > 0 :
                attributedString.add(string: "▲", color: .systemRed)
                attributedString.add(string: "\(rankIntensity)")
            case let rankIntensity where rankIntensity < 0 :
                attributedString.add(string: "▼", color: .systemBlue)
                attributedString.add(string: "\(-rankIntensity)")
            default:
                break
            }
        } else {
            attributedString.add(string: "신작", color: .systemRed)
        }
        
        return attributedString
        
    }
    
    private func setupSubviews() {
        contentView.addSubview(mainStackview)
        mainStackview.addArrangedSubview(rankingLabel)
        mainStackview.addArrangedSubview(titleLabel)
        mainStackview.addArrangedSubview(stateLabel)
        mainStackview.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            mainStackview.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            rankingLabel.heightAnchor.constraint(equalToConstant: 65),
            titleLabel.heightAnchor.constraint(equalToConstant: 65),
            stateLabel.heightAnchor.constraint(equalToConstant: 25),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
}
