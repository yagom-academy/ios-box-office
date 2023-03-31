//
//  CategoryStackView.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/31.
//

import UIKit

final class CategoryStackView: UIStackView {
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    init(category: String) {
        super.init(frame: .zero)
        configure(category: category)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(category: String) {
        self.axis = .horizontal
        self.alignment = .center
        self.addArrangedSubview(categoryLabel)
        self.addArrangedSubview(informationLabel)
        
        self.categoryLabel.text = category
    }
    
    func setupInformationLabel(as information: String) {
        self.informationLabel.text = information
    }
}
