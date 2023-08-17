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
        content.secondaryText = "오늘 \(state.item?.audienceCount?.changeNumberFormat() ?? "오류") / 총 \(state.item?.audienceAccumulated?.changeNumberFormat() ?? "오류")"
        
        rankNumberLabel.text = state.item?.rankNumber
        rankNumberLabel.font = .preferredFont(forTextStyle: .title1)
        
        guard let isNewMovie = state.item?.rankOldAndNew else { return }
        guard let rankIntensity = state.item?.rankIntensity else { return }
                
        if isNewMovie == "NEW" {
            makeOldAndNewMovieCategory(isNewMovie: isNewMovie) { [weak self] oldAndNewMovieTitle in
                self?.rankChangeLabel.attributedText = oldAndNewMovieTitle
            }
        } else if isNewMovie == "OLD" {
            makeRankIntensity(rankIntensityData: rankIntensity) { [weak self] rankIntensity in
                self?.rankChangeLabel.attributedText = rankIntensity
            }
        }
        
        listContentView.configuration = content
    }
}

extension CustomListCell {
    func makeRankIntensity(rankIntensityData: String?, completion: @escaping (NSAttributedString) -> Void) {
        guard let rankIntensityData = rankIntensityData else { return }
        guard let rankIntensity = RankIntensity(fromString: rankIntensityData) else { return }
        let font = UIFont.preferredFont(forTextStyle: .caption1)
        guard let attributedString = rankIntensity.attributedString(withFont: font) else { return }
        completion(attributedString)
    }
}

extension CustomListCell {
    func makeOldAndNewMovieCategory(isNewMovie: String, completion: @escaping (NSAttributedString) -> Void) {
        var oldAndNewMovieCategory: String {
            switch isNewMovie {
            case "NEW":
                return "신작"
            case "OLD":
                return "기존"
            default:
                return "Error"
            }
        }
        
        let font = UIFont.systemFont(ofSize: 17.0)
        
        if oldAndNewMovieCategory == "신작" {
            let attributeOldAndNewMovieCategory = NSMutableAttributedString(string: oldAndNewMovieCategory)
            
            attributeOldAndNewMovieCategory.addAttributes([
                NSMutableAttributedString.Key.foregroundColor: UIColor.red,
                NSMutableAttributedString.Key.font: font as Any
            ], range: (oldAndNewMovieCategory as NSString).range(of: oldAndNewMovieCategory))
            
            completion(attributeOldAndNewMovieCategory)
        }
    }
}


