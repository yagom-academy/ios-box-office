//
//  CustomStackView.swift
//  BoxOffice
//
//  Created by Jinah Park on 2023/04/06.
//

import UIKit

class CustomStackView: UIStackView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    let contextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    init(title: String, frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        super.init(frame: frame)
        configureStackView(title: title)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView(title: String) {
        self.axis = .horizontal
        self.spacing = 10
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(contextLabel)
        self.titleLabel.text = title
    }
    
    func configureContext(context: String?) {
        contextLabel.text = context
    }
}
