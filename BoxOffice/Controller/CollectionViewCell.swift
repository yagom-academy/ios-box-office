//
//  CollectionViewCell.swift
//  BoxOffice
//
//  Created by redmango1446 on 2023/08/02.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var rankInfoLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var audiNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
