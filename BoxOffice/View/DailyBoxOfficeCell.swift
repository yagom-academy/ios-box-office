//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewCell {
    var isConstraintNeeded = true
    var rankLabel = UILabel()
    var rankDifferenceLabel = UILabel()
    var movieTitleLable = UILabel()
    var audienceCountLabel = UILabel()
    let identifier = "DailyBoxOfficeCell"
    
    func configureSubviews() {
        let rankStackView = {
          let stackView = UIStackView()
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            return stackView
        }()
        
        let movieStackView = {
           let stackView = UIStackView()
            stackView.addArrangedSubview(movieTitleLable)
            stackView.addArrangedSubview(audienceCountLabel)
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            return stackView
        }()
        
        let accessoryView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "chevron.right")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        self.contentView.addSubview(rankStackView)
        self.contentView.addSubview(movieStackView)
        self.contentView.addSubview(accessoryView)
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            movieStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            accessoryView.leadingAnchor.constraint(equalTo: movieStackView.trailingAnchor),
            accessoryView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
