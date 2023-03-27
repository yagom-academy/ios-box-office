//
//  BoxOfficeContentView.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/27.
//

import UIKit

class BoxOfficeContentView: UIView, UIContentView {
    private var currentConfiguration: BoxOfficeContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            return currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? BoxOfficeContentConfiguration else {
                return
            }
            
            apply(configuration: newConfiguration)
        }
    }
    
    let rankLabel = UILabel()
    let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    let rankIncrementSymbol = UIImageView()
    let rankIncrementLabel = UILabel()
    let titleLabel = UILabel()
    let audienceCountLabel = UILabel()
    
    init(configuration: BoxOfficeContentConfiguration) {
        super.init(frame: .zero)
        
        setupAllViews()
        
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BoxOfficeContentView {
    private func setupAllViews() {
        let rankInformationStackView = UIStackView()
        
        rankStackView.addArrangedSubview(rankIncrementSymbol)
        rankStackView.addArrangedSubview(rankIncrementLabel)
        
        rankInformationStackView.addArrangedSubview(rankLabel)
        rankInformationStackView.addArrangedSubview(rankStackView)
        
        let movieInformationStackView = UIStackView()
        
        movieInformationStackView.addArrangedSubview(titleLabel)
        movieInformationStackView.addArrangedSubview(audienceCountLabel)
        
        let movieStackView = UIStackView()
        movieStackView.axis = .horizontal
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        movieStackView.addArrangedSubview(rankInformationStackView)
        movieStackView.addArrangedSubview(movieInformationStackView)

        NSLayoutConstraint.activate([
            movieStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            movieStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func apply(configuration: BoxOfficeContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        
        rankLabel.text = configuration.rank
        
        if configuration.rankOldAndNew == "NEW" {
            rankIncrementLabel.text = "신작"
        } else {
            guard let rankIncrement = configuration.rankIncrement,
                  let rankIncrementNumber = Int(rankIncrement) else {
                return
            }
            
            switch rankIncrementNumber {
            case ..<0:
                rankIncrementSymbol.image = UIImage(systemName: "arrowtriangle.down.fill")
                rankIncrementLabel.text = "\(rankIncrementNumber * -1)"
            case 0:
                rankIncrementLabel.text = "-"
            default:
                rankIncrementSymbol.image = UIImage(systemName: "arrowtriangle.up.fill")
                rankIncrementLabel.text = "\(rankIncrementNumber)"
            }
        }
        
        titleLabel.text = configuration.title
        
        let audienceString = "오늘 \(configuration.audienceCount) / 총: \(configuration.audienceAccumulationCount)"
        audienceCountLabel.text = audienceString
    }
}
