//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/08.
//

import UIKit

class CustomListCell: ItemListCell {
    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
    private lazy var listContentView = UIListContentView(configuration: defaultContentConfiguration())
    
    let rankNumberLabel = UILabel()
    let rankChangeLabel = UILabel()
    
    var setupViewsIfNeededFlag: Bool? = nil
}

extension CustomListCell {
    func setupViewsIfNeeded() {
        let movieRankStackView = UIStackView(arrangedSubviews: [rankNumberLabel, rankChangeLabel])
        movieRankStackView.alignment = .center
        movieRankStackView.distribution = .fillProportionally
        movieRankStackView.spacing = 0
        movieRankStackView.axis = .vertical
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [listContentView, movieRankStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 100)
        contentViewHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            contentViewHeightConstraint,
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            listContentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieRankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            movieRankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        setupViewsIfNeededFlag = true
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        var content = defaultListContentConfiguration().updated(for: state)
        
        content.text = state.item?.movieName
        content.textProperties.font = .preferredFont(forTextStyle: .subheadline)
        content.secondaryText = "오늘 \(state.item?.audienceCount ?? "오류") / 총 \(state.item?.audienceAccumulated ?? "오류")"
        
        rankNumberLabel.text = state.item?.rankNumber
        rankChangeLabel.text = state.item?.rankIntensity
        rankNumberLabel.font = .preferredFont(forTextStyle: .title1)
        listContentView.configuration = content
    }
}
