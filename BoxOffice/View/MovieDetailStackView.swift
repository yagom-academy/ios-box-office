//
//  MovieDetailStackView.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/08.
//

import UIKit

class MovieDetailStackView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(title: String) {
        self.titleLabel.text = title
        
        super.init(frame: .init())
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(valueLabel)
    }
    
}
