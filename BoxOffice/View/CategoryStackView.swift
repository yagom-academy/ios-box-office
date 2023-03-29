//
//  CategoryStackView.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/29.
//

import UIKit

final class CategoryStackView: UIStackView {
    var categoryLabel = {
        let label = UILabel()
        if let titleDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withSymbolicTraits(.traitBold) {
            label.font = UIFont(descriptor: titleDescriptor, size: 0.0)
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    var detailLabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setArrangedSubviews() {
        self.addArrangedSubview(categoryLabel)
        self.addArrangedSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
    
    func setAttribute() {
        self.alignment = .center
    }
}
