//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/23.
//

import UIKit

class BoxOfficeListCell: UICollectionViewCell  {
    
    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var rankGapLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var audienceCountLabel: UILabel!
    
    func configureUI() {
        rankNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        rankGapLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .yellow
        self.layer.borderWidth = 2
        
        let rankStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 6
            stackView.distribution = .fillEqually
            stackView.backgroundColor = .red
            return stackView
        }()
     
        
        let titleAndAudienceStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 6
            stackView.distribution = .fillEqually
            stackView.backgroundColor = .blue
            return stackView
        }()
       
        self.addSubview(rankStackView)
        self.addSubview(titleAndAudienceStackView)
                
        rankStackView.addArrangedSubview(rankNumberLabel)
        rankStackView.addArrangedSubview(rankGapLabel)
        
        titleAndAudienceStackView.addArrangedSubview(movieTitleLabel)
        titleAndAudienceStackView.addArrangedSubview(audienceCountLabel)
        
        
        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 6),
            rankStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            rankStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 6),
            
            titleAndAudienceStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 6),
            titleAndAudienceStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor,constant: 20),
            titleAndAudienceStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 6)
        ])
    }
}
