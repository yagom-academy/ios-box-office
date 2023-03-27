//
//  BoxOfficeContentView.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/27.
//

import UIKit

class BoxOfficeContentView: UIView, UIContentView {
    private var currentConfiguration: BoxOfficeContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            return currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? BoxOfficeContentConfiguration else {
                return
            }
            
            apply(configuration: newConfiguration)
        }
    }
    
    let rankLabel = UILabel()
    let rankStackView = UIStackView()
    let rankIncrementSymbol = UIImageView()
    let rankIncrementLabel = UILabel()
    let newRankLabel = UILabel()
    let titleLabel = UILabel()
    let audienceCountLabel = UILabel()
    
    init(configuration: BoxOfficeContentConfiguration) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
