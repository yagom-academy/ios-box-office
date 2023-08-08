//
//  MainCollectionViewCell.swift
//  BoxOffice
//
//  Created by 1 on 2023/08/03.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewListCell {
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpAccessory()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContent(_ movieInformation: MovieInformationDTO) {
        rankLabel.text = movieInformation.rank
        rankIntenLabel.attributedText = movieInformation.conventedRankIntenSybolAndText()
        movieNameLabel.text = movieInformation.movieName
        
        let audienceCount = movieInformation.convertDecimalFormattedString(text: movieInformation.audienceCount)
        let audienceAccumulateCount = movieInformation.convertDecimalFormattedString(text: movieInformation.audienceAccumulate)
        
        audienceCountLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulateCount)"
    }
}

// MARK: - Private
extension MainCollectionViewCell {
    private func setUpAccessory() {
        accessories = [.disclosureIndicator()]
    }
    
    private func setUpLayout() {
        setUpRankLabelLayout()
        setUpRankIntenLabelLayout()
        setUpMovieNameLabelLayout()
        setUpAudienceCountLabelLayout()
        setUpRankStackViewLayout()
        setUpMovieDescriptionStackViewLayout()
    }
    
    private func setUpRankLabelLayout() {
        rankStackView.addArrangedSubview(rankLabel)
    }
    
    private func setUpRankIntenLabelLayout() {
        rankStackView.addArrangedSubview(rankIntenLabel)
    }
    
    private func setUpMovieNameLabelLayout() {
        movieDescriptionStackView.addArrangedSubview(movieNameLabel)
    }
    
    private func setUpAudienceCountLabelLayout() {
        movieDescriptionStackView.addArrangedSubview(audienceCountLabel)
    }
    
    private func setUpRankStackViewLayout() {
        addSubview(rankStackView)
        
        NSLayoutConstraint.activate([
            rankStackView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            rankStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setUpMovieDescriptionStackViewLayout() {
        addSubview(movieDescriptionStackView)
        
        NSLayoutConstraint.activate([
            movieDescriptionStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieDescriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            movieDescriptionStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 30),
            movieDescriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
}
