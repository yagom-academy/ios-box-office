//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/23.
//

import UIKit

class BoxOfficeListCell: UICollectionViewCell {
    
    @IBOutlet weak var rankNumberLabel: UILabel!
    
    @IBOutlet weak var rankGapLabel: UILabel!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var audienceCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
