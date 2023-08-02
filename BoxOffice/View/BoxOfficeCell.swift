//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/02.
//

import UIKit

final class BoxOfficeCell: UICollectionViewCell {
    static let identifier = "boxOfficeCell"
    
    private let superStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - InformationStackView
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    // MARK: - RankStackView
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let rankInformationLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Movie Name, Audience Information
    private let detailLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Seperator
    private lazy var seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(displayP3Red: 0.99, green: 0.99, blue: 0.99, alpha: 0.1)
        view.frame.size = CGSize(width: self.superStackView.frame.width, height: 1)
        
        return view
    }()
}

// MARK: - Constraints
extension BoxOfficeCell {
    private func configureUI() {
        addSubview(superStackView)
        
        superStackView.addArrangedSubview(informationStackView)
        superStackView.addArrangedSubview(seperatorLineView)
        
        informationStackView.addArrangedSubview(rankStackView)
        informationStackView.addArrangedSubview(detailLabel)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankInformationLabel)
    }
    
    private func setUpConstraints() {
        setUpSuperStackViewConstraints()
        setUpInformationStackViewConstraints()
        setUpRankStackViewConstraints()
        setUpDetailLabelConstraints()
    }
    
    private func setUpSuperStackViewConstraints() {
        
    }
    
    private func setUpInformationStackViewConstraints() {
        
    }
    
    private func setUpRankStackViewConstraints() {
        
    }
    
    private func setUpDetailLabelConstraints() {
        
    }
}
