//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/31.
//
import UIKit

struct MovieInformationDTO: Hashable {
    let rank: String
    let rankInten: String
    let oldAndNew: String
    let movieName: String
    let movieCode: String
    let audienceCount: String
    let audienceAccumulate: String
}

extension MovieInformationDTO {
    func conventedRankIntenSybolAndText() -> NSMutableAttributedString {
        if oldAndNew == "NEW" {
            return addAttributeString(text: "신작", keyword: "신작", color: .red)
        }
        
        if rankInten == "0" {
            return addAttributeString(text: "-", keyword: "-", color: .black)
        } else {
            let isRankUp = Int(rankInten) ?? 0 > 0
            let symbol = isRankUp ? "▲" : "▼"
            let symbolColor: UIColor = isRankUp ? .red : .blue
            let inten = isRankUp == false ? rankInten.replacingOccurrences(of: "-", with: "") : rankInten
            let text = "\(symbol)\(inten)"
            
            return addAttributeString(text: text, keyword: symbol, color: symbolColor)
        }
    }
    
    func convertDecimalFormattedString(text: String) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        let number = numberFormatter.number(from: text) ?? 0
        let result = numberFormatter.string(from: number) ?? ""
        
        return result
    }
    
    private func addAttributeString(text: String, keyword: String, color: UIColor) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        
        attributeString.addAttribute(.foregroundColor, value: color , range: (text as NSString).range(of: keyword))
        return attributeString
    }
}
