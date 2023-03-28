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
    
    func setUpBoxOffcieCellUI(){
        configureUI()
        setUpLabelStyle()
    }
    
    private func configureUI() {
        rankNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        rankGapLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let rankStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            return stackView
        }()
     
        let titleAndAudienceStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            return stackView
        }()
       
        self.addSubview(rankStackView)
        self.addSubview(titleAndAudienceStackView)
                
        rankStackView.addArrangedSubview(rankNumberLabel)
        rankStackView.addArrangedSubview(rankGapLabel)
        
        titleAndAudienceStackView.addArrangedSubview(movieTitleLabel)
        titleAndAudienceStackView.addArrangedSubview(audienceCountLabel)
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            rankStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          
            titleAndAudienceStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor,constant: 20),
            titleAndAudienceStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setUpLabelStyle() {
        rankNumberLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        rankGapLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        audienceCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
}
