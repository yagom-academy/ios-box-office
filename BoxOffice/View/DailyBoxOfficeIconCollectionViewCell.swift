//
//  DailyBoxOfficeIconCollectionViewCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/04.
//

import UIKit

final class DailyBoxOfficeIconCollectionViewCell: UICollectionViewCell, LabelSetter {
    static let reuseIdentifier = "DailyBoxOfficeIconCollectionViewCell"

    private let mainStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureCell() {
        configureContentView()
        configureMainStackView()
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1.0),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 5
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func configureLabels(_ rankLabel: UILabel, _ audienceVarianceLabel: UILabel, _ listLabel: UILabel, and audienceInformationLabel: UILabel) {
        mainStackView.addArrangedSubview(rankLabel)
        mainStackView.addArrangedSubview(listLabel)
        mainStackView.addArrangedSubview(audienceVarianceLabel)
        mainStackView.addArrangedSubview(audienceInformationLabel)
        
        listLabel.textAlignment = .center
    }
}
