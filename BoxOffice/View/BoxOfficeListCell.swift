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
    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        configureUI()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func configureUI() {
        rankNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        rankGapLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let movieListStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 20
            stackView.backgroundColor = .green
            return stackView
        }()
       
        let rankStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 6
            stackView.backgroundColor = .red
            return stackView
        }()
     
        
        let titleAndAudienceStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 6
            stackView.backgroundColor = .blue
            return stackView
        }()
        
        self.addSubview(movieListStackView)
        
        movieListStackView.addArrangedSubview(rankStackView)
        movieListStackView.addArrangedSubview(titleAndAudienceStackView)
        
        rankStackView.addArrangedSubview(rankNumberLabel)
        rankStackView.addArrangedSubview(rankGapLabel)
        
        titleAndAudienceStackView.addArrangedSubview(movieTitleLabel)
        titleAndAudienceStackView.addArrangedSubview(audienceCountLabel)
        
        
        NSLayoutConstraint.activate([
            movieListStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 6),
            movieListStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            movieListStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 6),
            
            
            ])
    }
}
