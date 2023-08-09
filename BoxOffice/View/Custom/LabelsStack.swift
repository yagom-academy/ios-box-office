//
//  LabelsStack.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/09.
//

import UIKit

final class LabelsStack: UIStackView {
    convenience init() {
        self.init(frame: CGRectZero)
        
        axis = .horizontal
        spacing = 8
        alignment = .center
        distribution = .equalSpacing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
