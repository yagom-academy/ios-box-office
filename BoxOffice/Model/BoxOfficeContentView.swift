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
        stackView.alignment = .center
        return stackView
    }()
    let rankInformationStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    let rankIncrementSymbol = UIImageView()
    let rankIncrementLabel = UILabel()
    let movieInformationStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    let titleLabel = UILabel()
    let audienceCountLabel = UILabel()
    let movieStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        rankStackView.addArrangedSubview(rankIncrementSymbol)
        rankStackView.addArrangedSubview(rankIncrementLabel)
        
        rankInformationStackView.addArrangedSubview(rankLabel)
        rankInformationStackView.addArrangedSubview(rankStackView)
        
        movieInformationStackView.addArrangedSubview(titleLabel)
        movieInformationStackView.addArrangedSubview(audienceCountLabel)
        
        movieStackView.addArrangedSubview(rankInformationStackView)
        movieStackView.addArrangedSubview(movieInformationStackView)

        addSubview(movieStackView)
        
        NSLayoutConstraint.activate([
//            movieStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            movieStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            movieStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        rankIncrementSymbol.contentMode = .scaleAspectFit
    }
    
    private func apply(configuration: BoxOfficeContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        
        currentConfiguration = configuration
        
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
        
        if let todayAudienceCount = configuration.audienceCount,
           let accumulatedAudienceCount = configuration.audienceAccumulationCount {
            let audienceString = "오늘 \(todayAudienceCount) / 총: \(accumulatedAudienceCount)"
            audienceCountLabel.text = audienceString
        }
    }
}
