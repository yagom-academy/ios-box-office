//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Kiseok on 12/5/23.
//

import UIKit

@available(iOS 14.0, *)
class MovieListCell: UICollectionViewListCell {
    private var rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private var rankFluctuationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
            
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addSubview(rankLabel)
        stackView.addSubview(rankFluctuationLabel)
        return stackView
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
            
        return label
    }()
    
    private var audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
            
        return label
    }()
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        
        stackView.addSubview(movieNameLabel)
        stackView.addSubview(audienceCountLabel)
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessories = [.disclosureIndicator()]
    }
    
    func configureLabelText(_ movie: DailyBoxOfficeList) {
        rankLabel.text = movie.rank
        rankFluctuationLabel.text = movie.audienceFluctuation
        movieNameLabel.text = movie.movieName
        audienceCountLabel.text = "오늘 \(movie.audienceCount)명 / 총 \(movie.audienceAccumulation)명"
    }
}
