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
    
    func setUpContent(_ movieInformation: MovieInformationDTO) {
        rankLabel.text = movieInformation.rank
        rankIntenLabel.text = movieInformation.OldAndNew == "NEW" ? "신작" : movieInformation.rankInten
        movieNameLabel.text = movieInformation.movieName
        audienceCountLabel.text = movieInformation.audienceCount
    }
}
