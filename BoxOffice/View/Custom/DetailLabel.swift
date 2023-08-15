//
//  DetailLabel.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/09.
//

import UIKit

final class DetailLabel: UILabel {
    convenience init(fontStyle: UIFont.TextStyle) {
        self.init(frame: CGRectZero)
        
        numberOfLines = 0
        minimumScaleFactor = 0.3
        font = UIFont.preferredFont(forTextStyle: fontStyle)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
