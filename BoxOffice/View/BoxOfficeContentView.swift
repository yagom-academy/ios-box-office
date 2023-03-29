//
//  BoxOfficeContentView.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/27.
//

import UIKit

final class BoxOfficeContentView: UIView, UIContentView {
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
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private let rankIncrementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let rankStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let movieInformationStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let movieStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    init(configuration: BoxOfficeContentConfiguration) {
        super.init(frame: .zero)
        
        self.setupAllViews()
        
        self.apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BoxOfficeContentView {
    private func setupAllViews() {
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankIncrementLabel)
        
        movieInformationStackView.addArrangedSubview(titleLabel)
        movieInformationStackView.addArrangedSubview(audienceCountLabel)
        
        movieStackView.addArrangedSubview(rankStackView)
        movieStackView.addArrangedSubview(movieInformationStackView)

        addSubview(movieStackView)
        addSubview(accessoryImageView)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            movieStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            accessoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func apply(configuration: BoxOfficeContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        
        rankIncrementLabel.text = nil
        rankIncrementLabel.textColor = .black
        
        currentConfiguration = configuration
        
        rankLabel.text = configuration.rank
        
        
        if configuration.rankOldAndNew == "NEW" {
            rankIncrementLabel.text = "신작"
            rankIncrementLabel.font = .preferredFont(forTextStyle: .footnote)
            rankIncrementLabel.textColor = .systemRed
        } else {
            guard let rankIncrement = configuration.rankIncrement,
                  let rankIncrementNumber = Int(rankIncrement) else {
                return
            }
            
            switch rankIncrementNumber {
            case ..<0:
                let attributedString = NSMutableAttributedString(string: "▼\(rankIncrementNumber * -1)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 0, length: 1))
                rankIncrementLabel.attributedText = attributedString
            case 0:
                rankIncrementLabel.text = "-"
            default:
                let attributedString = NSMutableAttributedString(string: "▲\(rankIncrementNumber)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: NSRange(location: 0, length: 1))
                rankIncrementLabel.attributedText = attributedString
            }
        }
        
        titleLabel.text = configuration.title
        
        if let todayAudienceCount = configuration.audienceCount?.convertToDecimal(),
           let accumulatedAudienceCount = configuration.audienceAccumulationCount?.convertToDecimal() {
            let audienceString = "오늘 \(todayAudienceCount) / 총: \(accumulatedAudienceCount)"
            audienceCountLabel.text = audienceString
        }
    }
}
