//
//  RankChangeState.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/16.
//

import UIKit

enum RankChangeState {
    case new
    case noChange
    case rising
    case falling
    
    init?(_ amountOfRankChange: String, _ rankOldAndNew: String) {
        if amountOfRankChange == "0" && rankOldAndNew == "NEW" {
            self = .new
        } else if amountOfRankChange == "0" && rankOldAndNew == "OLD" {
            self = .noChange
        } else if amountOfRankChange > "0" {
            self = .rising
        } else if amountOfRankChange < "0" {
            self = .falling
        } else {
            return nil
        }
    }
    
    func getAmountOfRankChangeString(origin: String) -> NSMutableAttributedString {
        switch self {
        case .new:
            let text = "신작"
            let attribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
            
            return NSMutableAttributedString(string: text, attributes: attribute)
        case .noChange:
            return NSMutableAttributedString(string: "-")
        case .rising:
            let text = "▲" + origin
            let string = NSMutableAttributedString(string: text)
            
            string.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 0, length: 1))
            
            return string
        case .falling:
            let text = "▼" + origin.dropFirst()
            let string = NSMutableAttributedString(string: text)
            
            string.addAttributes([.foregroundColor: UIColor.blue], range: NSRange(location: 0, length: 1))
            
            return string
        }
    }
}
