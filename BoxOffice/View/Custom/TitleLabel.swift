//
//  TitleLabel.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/09.
//

import UIKit

final class TitleLabel: UILabel {
    convenience init(title: String) {
        self.init(frame: CGRectZero)
        
        textAlignment = .center
        text = title
        font = UIFont.preferredFont(for: .title3, weight: .heavy)
        minimumScaleFactor = 0.3
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
