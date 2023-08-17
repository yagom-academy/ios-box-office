//
//  CellUIModel.swift
//  BoxOffice
//
//  Created by karen on 2023/08/15.
//

import UIKit

struct CellUIModel {
    private let data: BoxOfficeMovieInfo
    
    var rank: String {
        return data.rank
    }
    
    var name: String {
        return data.name
    }
    
    var audienceInfoText: NSAttributedString {
        guard let todayOfAudienceText = data.audienceCount.formattedDecimalString(),
              let totalOfAudienceText = data.audienceTotal.formattedDecimalString() else {
            return NSAttributedString(string: DataNamespace.empty)
        }
        
        let attributedText = NSMutableAttributedString()
        
        let todayAttributedString = NSAttributedString(string: "오늘 \(todayOfAudienceText) / ", attributes: [.foregroundColor: UIColor.label])
        let totalAttributedString = NSAttributedString(string: "총 \(totalOfAudienceText)", attributes: [.foregroundColor: UIColor.label])
        
        attributedText.append(todayAttributedString)
        attributedText.append(totalAttributedString)
        
        return attributedText
    }
    
    
    var rankStatusAttributedText: NSAttributedString {
        let text = self.rankStatusText
        let color = self.rankStatusTextColor
        let attributedText = NSMutableAttributedString(string: text)
        
        if text.contains(DataNamespace.down) {
            let range = (text as NSString).range(of: DataNamespace.down)
            attributedText.addAttribute(.foregroundColor, value: color, range: range)
            
            return attributedText
        } else if text.contains(DataNamespace.up) {
            let range = (text as NSString).range(of: DataNamespace.up)
            attributedText.addAttribute(.foregroundColor, value: color, range: range)
            
            return attributedText
        }
        
        let range = NSRange(location: 0, length: text.count)
        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        
        return attributedText
    }
    
    private var rankStatusText: String {
        switch data.rankingStatus {
        case .old:
            guard let changedRankValue = Int(data.changedRank) else { return DataNamespace.empty }
            
            if changedRankValue > 0 {
                return "\(DataNamespace.up) \(changedRankValue)"
            } else if changedRankValue == 0 {
                return DataNamespace.maintenance
            } else {
                return "\(DataNamespace.down) \(abs(changedRankValue))"
            }
        case .new:
            return DataNamespace.new
        }
    }
    
    private var rankStatusTextColor: UIColor {
        switch data.rankingStatus {
        case .old:
            guard let changedRankValue = Int(data.changedRank) else { return .black }
            
            if changedRankValue > 0 {
                return .red
            } else if changedRankValue == 0 {
                return .label
            } else {
                return .blue
            }
        case .new:
            return .red
        }
    }
    
    init(data: BoxOfficeMovieInfo) {
        self.data = data
    }
}
