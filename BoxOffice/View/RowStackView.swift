//
//  RowStackView.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

final class RowStackView: UIStackView {
    private let titleLabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private let valueLabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, value: String) {
        self.init(frame: .zero)

        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    func configureStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
