//
//  DailyBoxOfficeIconCell.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/06.
//

import UIKit

final class DailyBoxOfficeIconCell: UICollectionViewCell {
    var dailyBoxOfficeData: DailyBoxOfficeMovie?
    let rankLabel = UILabel()
    let rankDifferenceLabel = UILabel()
    let movieTitleLabel = UILabel()
    let audienceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayoutConstraints() {
        let dailyBoxOfficeStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.addArrangedSubview(rankLabel)
            stackView.addArrangedSubview(movieTitleLabel)
            stackView.addArrangedSubview(rankDifferenceLabel)
            stackView.addArrangedSubview(audienceLabel)
            
            return stackView
        }()
        
        self.contentView.addSubview(dailyBoxOfficeStackView)
        
        NSLayoutConstraint.activate([
            dailyBoxOfficeStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dailyBoxOfficeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dailyBoxOfficeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dailyBoxOfficeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
