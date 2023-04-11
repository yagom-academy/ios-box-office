//
//  CellUIModel.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/31.
//

import UIKit

struct CellUIModel {
    private let data: InfoObject
    
    var rank: String {
        return data.rank
    }
    
    var name: String {
        return data.name
    }
    
    var audienceInfoText: String {
        guard let todayOfAudienceText = data.numberOfAudience.formatDecimal(),
              let totalOfAudienceText = data.totalOfAudience.formatDecimal() else { return "" }
        return "오늘 \(todayOfAudienceText) / 총 \(totalOfAudienceText)"
    }
    
    var rankStatusAttributedText: NSAttributedString {
        let text = self.rankStatusText
        let color = self.rankStatusTextColor
        let attributedText = NSMutableAttributedString(string: text)
        
        if text.contains("▼") {
            let range = (text as NSString).range(of: "▼")
            attributedText.addAttribute(.foregroundColor, value: color, range: range)
            
            return attributedText
        } else if text.contains("▲") {
            let range = (text as NSString).range(of: "▲")
            attributedText.addAttribute(.foregroundColor, value: color, range: range)
            
            return attributedText
        }
        
        let range = NSRange(location: 0, length: text.count)
        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        
        return attributedText
    }
    
    private var rankStatusText: String {
        switch data.rankStatus {
        case .old:
            guard let changedRankValue = Int(data.changedRank) else { return "" }
            
            if changedRankValue > 0 {
                return "▲ \(changedRankValue)"
            } else if changedRankValue == 0 {
                return "-"
            } else {
                return "▼ \(abs(changedRankValue))"
            }
        case .new:
            return "신작"
        }
    }
    
    private var rankStatusTextColor: UIColor {
        switch data.rankStatus {
        case .old:
            guard let changedRankValue = Int(data.changedRank) else { return .black }
            
            if changedRankValue > 0 {
                return .red
            } else if changedRankValue == 0 {
                return .black
            } else {
                return .blue
            }
        case .new:
            return .red
        }
    }
    
    init(data: InfoObject) {
        self.data = data
    }
}
