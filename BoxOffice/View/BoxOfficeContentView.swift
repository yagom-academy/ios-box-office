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
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    let rankIncrementSymbol = UIImageView()
    
    let rankIncrementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    let rankIncrementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    let rankStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let movieInformationStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    let movieStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
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
        
        
        rankIncrementStackView.addArrangedSubview(rankIncrementSymbol)
        rankIncrementStackView.addArrangedSubview(rankIncrementLabel)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankIncrementStackView)
        
        movieInformationStackView.addArrangedSubview(titleLabel)
        movieInformationStackView.addArrangedSubview(audienceCountLabel)
        
        movieStackView.addArrangedSubview(rankStackView)
        movieStackView.addArrangedSubview(movieInformationStackView)

        addSubview(movieStackView)
        addSubview(separatorView)
        
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            movieStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
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
            rankIncrementLabel.font = .preferredFont(forTextStyle: .footnote)
            rankIncrementLabel.textColor = .systemRed
        } else {
            NSLayoutConstraint.activate([
                rankIncrementSymbol.widthAnchor.constraint(equalToConstant: 10),
                rankIncrementSymbol.heightAnchor.constraint(equalToConstant: 15),
            ])
            guard let rankIncrement = configuration.rankIncrement,
                  let rankIncrementNumber = Int(rankIncrement) else {
                return
            }
            
            switch rankIncrementNumber {
            case ..<0:
                rankIncrementSymbol.image = UIImage(systemName: "arrowtriangle.down.fill")
                rankIncrementLabel.text = "\(rankIncrementNumber * -1)"
            case 0:
                rankIncrementSymbol.image = UIImage(systemName: "minus",
                                                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))
                rankIncrementSymbol.tintColor = .black
            default:
                rankIncrementSymbol.image = UIImage(systemName: "arrowtriangle.up.fill")
                rankIncrementSymbol.tintColor = .systemRed
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
