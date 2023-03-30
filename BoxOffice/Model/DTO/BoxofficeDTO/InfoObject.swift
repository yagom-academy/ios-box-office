//
//  InfoObject.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import UIKit

struct InfoObject: Decodable, Hashable {
    private let rnum, changedRank: String
    private let rankStatus: RankStatus
    let rank: String
    let code, name: String
    private let openDate: String
    private let salesAmount, salesShare, changedSales, changedSalesRate, totalOfSales: String
    private let numberOfAudience, changedAudience, changedAudienceRate, totalOfAudience: String
    private let numberOfScreen: String
    private let numberOfShowing: String
    
    var audienceInfoText: String {
        guard let todayOfAudienceText = numberOfAudience.formatDecimal(),
              let totalOfAudienceText = totalOfAudience.formatDecimal() else { return "" }
        return "오늘 \(todayOfAudienceText) / 총 \(totalOfAudienceText)"
    }
    
    var rankStatusText: String {
        if self.rankStatus == .old {
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
        if self.rankStatus == .old {
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
    
    enum RankStatus: String, Decodable {
        case old = "OLD"
        case new = "NEW"
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
