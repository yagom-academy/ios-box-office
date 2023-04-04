//
//  CategoryLabel.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/03.
//

import UIKit

final class CategoryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 12, weight: .bold)
    }
}
