//
//  CustomStackView.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/06.
//

import UIKit

final class CustomStackView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let contextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(title: String, frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        super.init(frame: frame)
        
        configureUI()
        configureLayout()
        configureStackView(title: title)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(contextLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.17),
        ])
    }
    
    private func configureStackView(title: String) {
        self.axis = .horizontal
        self.spacing = 10
        self.titleLabel.text = title
    }
    
    func configureContext(context: String?) {
        contextLabel.text = context
    }
}
