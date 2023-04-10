//
//  ContentStackView.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/03.
//

import UIKit

final class ContentStackView: UIStackView {

    private let categoryLabel = {
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let fontMatrics = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        
        let label = UILabel(fontStyle: fontMatrics)
        
        return label
    }()
    
    private let contentLabel = {
        let font = UIFont.systemFont(ofSize: 12)
        let fontMatrics = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        
        let label = UILabel(fontStyle: fontMatrics)
        
        return label
    }()

    convenience init(categoryText: String) {
        self.init(frame: CGRect.zero)
        configure()
        
        self.categoryLabel.text = categoryText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabelText(_ contentText: String) {
        contentLabel.text = contentText
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(categoryLabel)
        self.addArrangedSubview(contentLabel)
        self.spacing = 5
        
        categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
    }

}
