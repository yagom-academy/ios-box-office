//
//  ContentStackView.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/03.
//

import UIKit

class ContentStackView: UIStackView {

    private let categoryLabel = CategoryLabel()
    private let contentLabel = ContentLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLabelText(_ categoryText: String, _ contentText: String) {
        categoryLabel.text = categoryText
        contentLabel.text = contentText
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(categoryLabel)
        self.addArrangedSubview(contentLabel)
        self.spacing = 5
    }

}
