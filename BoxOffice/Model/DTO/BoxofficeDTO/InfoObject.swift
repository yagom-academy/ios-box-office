//
//  InfoObject.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import UIKit

struct InfoObject: Decodable, Hashable {
    let rnum, rank, changedRank, rankStatus: String
    let code, name: String
    let openDate: String
    let salesAmount, salesShare, changedSales, changedSalesRate, totalOfSales: String
    let numberOfAudience, changedAudience, changedAudienceRate, totalOfAudience: String
    let numberOfScreen: String
    let numberOfShowing: String
    
    var audienceInfoText: String {
        let formatNumberOfAudience = numberOfAudience.formatDecimal()
        let formatTotalOfAudience = totalOfAudience.formatDecimal()
        
        guard let todayOfAudienceText = formatNumberOfAudience,
              let totalOfAudienceText = formatTotalOfAudience else { return "" }
        return "오늘 \(todayOfAudienceText) / 총 \(totalOfAudienceText)"
    }
    
    var rankStatusText: String {
        if self.rankStatus == "OLD" {
            guard let changedRankValue = Int(changedRank) else { return "" }
            
            if changedRankValue > 0 {
                return "▲ \(changedRankValue)"
            } else if changedRankValue == 0 {
                return "-"
            } else {
                return "▼ \(abs(changedRankValue))"
            }
        } else {
            return "신작"
        }
    }
    
    var rankStatusTextColor: UIColor {
        if self.rankStatus == "OLD" {
            guard let changedRankValue = Int(changedRank) else { return .black }
            
            if changedRankValue > 0 {
                return .red
            } else if changedRankValue == 0 {
                return .black
            } else {
                return .blue
            }
        } else {
            return .red
        }
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
    
    enum CodingKeys: String, CodingKey {
        case rnum, rank
        case changedRank = "rankInten"
        case rankStatus = "rankOldAndNew"
        case code = "movieCd"
        case name = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case changedSales = "salesInten"
        case changedSalesRate = "salesChange"
        case totalOfSales = "salesAcc"
        case numberOfAudience = "audiCnt"
        case changedAudience = "audiInten"
        case changedAudienceRate = "audiChange"
        case totalOfAudience = "audiAcc"
        case numberOfScreen = "scrnCnt"
        case numberOfShowing = "showCnt"
    }
}
