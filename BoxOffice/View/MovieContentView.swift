//
//  MovieContentView.swift
//  BoxOffice
//
//  Created by Kiseok on 12/7/23.
//

import UIKit

class MovieContentView: UIView, UIContentView {
    private var rankLabel = UILabel()
    private var rankFluctuationLabel = UILabel()
    private var rankStackView = UIStackView()
    private var movieNameLabel = UILabel()
    private var audienceCountLabel = UILabel()
    private var movieStackView = UIStackView()
    private var stackView = UIStackView()
    
    var configuration: UIContentConfiguration {
        didSet {
            if let configuration = configuration as? MovieConfiguration {
                apply(configuration)
            }
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func apply(_ configuration: MovieConfiguration) {
        
    }
}

extension MovieContentView {
    private func configureUI() {
        rankLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        rankLabel.adjustsFontForContentSizeCategory = true
        
        rankFluctuationLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        rankFluctuationLabel.adjustsFontForContentSizeCategory = true
        
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.axis = .vertical
        rankStackView.alignment = .center
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankFluctuationLabel)
        
        movieNameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieNameLabel.adjustsFontForContentSizeCategory = true
        
        audienceCountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceCountLabel.adjustsFontForContentSizeCategory = true
        
        movieStackView.axis = .vertical
        movieStackView.alignment = .fill
        movieStackView.addArrangedSubview(movieNameLabel)
        movieStackView.addArrangedSubview(audienceCountLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(movieStackView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -30),
            rankStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
    }
}
