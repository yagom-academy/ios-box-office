//
//  CollectionViewIconCell.swift
//  BoxOffice
//
//  Created by redmango1446 on 2023/08/15.
//

import UIKit

class CollectionViewIconCell: UICollectionViewCell {
    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var rankInfoLabel: UILabel!
    @IBOutlet weak var audiNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
    }
    
    func configureFont() {
        rankNumberLabel.font = .preferredFont(forTextStyle: .title1)
        rankInfoLabel.font = .preferredFont(forTextStyle: .body)
        audiNumberLabel.font = .preferredFont(forTextStyle: .body)
        audiNumberLabel.adjustsFontSizeToFitWidth = true
        movieNameLabel.font = .preferredFont(forTextStyle: .title3)
        movieNameLabel.allowsDefaultTighteningForTruncation = true
        movieNameLabel.numberOfLines = 2
    }
    
    func configureDynamicType() {
        rankNumberLabel.adjustsFontForContentSizeCategory = true
        rankInfoLabel.adjustsFontForContentSizeCategory = true
        movieNameLabel.adjustsFontForContentSizeCategory = true
        audiNumberLabel.adjustsFontForContentSizeCategory = true
    }
    
    func configureLabels(with dailyBoxOffice: DailyBoxOffice) {
        configureAudiNumberLabel(with: dailyBoxOffice)
        configureRankInfoLabel(with: dailyBoxOffice)
        rankNumberLabel.text = dailyBoxOffice.rank
        movieNameLabel.text = dailyBoxOffice.movieName
    }
    
    func configureAudiNumberLabel(with dailyBoxOffice: DailyBoxOffice) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let audiCnt = Int(dailyBoxOffice.audiCnt),
              let formattedAudiCnt = numberFormatter.string(from: NSNumber(value: audiCnt)) else { return }
        
        guard let audiAcc = Int(dailyBoxOffice.audiAcc),
              let formattedAudiAcc = numberFormatter.string(from: NSNumber(value: audiAcc)) else { return }
        
        audiNumberLabel.text = "오늘 \(formattedAudiCnt) / 총 \(formattedAudiAcc)"
    }
    
    func configureRankInfoLabel(with dailyBoxOffice: DailyBoxOffice) {
        switch dailyBoxOffice.rankOldAndNew {
        case "NEW":
            rankInfoLabel.textColor = .red
            rankInfoLabel.text = "신작"
        case "OLD":
            if dailyBoxOffice.rankInten == "0" {
                rankInfoLabel.text = "-"
                return
            }
            
            if let rankInten = Int(dailyBoxOffice.rankInten),
               let arrow = Arrow(rawValue: rankInten) {
                rankInfoLabel.textColor = .black
                let rankIntenString = "\(arrow.rawValue)\(abs(rankInten))"
                let attributedString = NSMutableAttributedString(string: rankIntenString)
                let range = (rankIntenString as NSString).range(of: arrow.rawValue)
                attributedString.addAttribute(.foregroundColor, value: arrow.color, range: range)
                rankInfoLabel.attributedText = attributedString
            }
        default:
            print("no Data")
        }
    }
}
