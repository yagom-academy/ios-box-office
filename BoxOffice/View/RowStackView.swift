//
//  RowStackView.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

class RowStackView: UIStackView {
    private let titleLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        
        return label
    }()
    
    private let valueLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.alignment = .center
        
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
