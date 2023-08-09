//
//  DetailLabel.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/09.
//

import UIKit

final class DetailLabel: UILabel {
    convenience init() {
        self.init(frame: CGRectZero)
        
        numberOfLines = 0
        minimumScaleFactor = 0.3
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
