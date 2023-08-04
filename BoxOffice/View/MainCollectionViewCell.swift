//
//  MainCollectionViewCell.swift
//  BoxOffice
//
//  Created by 1 on 2023/08/03.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(1), for: .vertical)
        return label
    }()
    
    private let rankIntenLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(1), for: .vertical)
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        return stackView
    }()
    
    private let movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContent(_ movieInformation: MovieInformationDTO) {
        rankLabel.text = movieInformation.rank
        rankIntenLabel.attributedText = rankIntenLabelText(movieInformation.OldAndNew, movieInformation.rankInten)
        movieNameLabel.text = movieInformation.movieName
        audienceCountLabel.text = "오늘 \(decimalFormattedNumber(text: movieInformation.audienceCount)) / 총 \(decimalFormattedNumber(text: movieInformation.audienceAccumulate))"
    }
}

// MARK: - Private
extension MainCollectionViewCell {
    private func configureUI() {
        [rankLabel, rankIntenLabel].forEach { rankStackView.addArrangedSubview($0) }
        [movieNameLabel, audienceCountLabel].forEach { movieDescriptionStackView.addArrangedSubview($0) }
        [rankStackView, movieDescriptionStackView].forEach { movieInformationStackView.addArrangedSubview($0) }
        addSubview(movieInformationStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            movieInformationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            movieInformationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            movieInformationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func addAttributeString(text: String, keyword: String, color: UIColor) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        
        attributeString.addAttribute(.foregroundColor, value: color , range: (text as NSString).range(of: keyword))
        return attributeString
    }
    
    private func rankIntenLabelText(_ oldAndNew: String, _ rankInten: String) -> NSMutableAttributedString {
        if oldAndNew == "NEW" {
            return addAttributeString(text: "신작", keyword: "신작", color: .red)
        }
        
        if rankInten == "0" {
            return addAttributeString(text: "-", keyword: "-", color: .black)
        } else {
            let isRankUp = Int(rankInten) ?? 0 > 0
            let symbol = isRankUp ? "▲" : "▼"
            let symbolColor: UIColor = isRankUp ? .red : .blue
            let inten = isRankUp == false ? rankInten.replacingOccurrences(of: "-", with: "") : rankInten
            let text = "\(symbol)\(inten)"
            
            return addAttributeString(text: text, keyword: symbol, color: symbolColor)
        }
    }
    
    private func decimalFormattedNumber(text: String) -> String {
        let numberFormatter = NumberFormatter()
        let numbers = Int(text) ?? 0
        
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: numbers)) ?? ""
        return result
    }
}
