//
//  UIView+.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/27.
//

import UIKit

extension UIView {
    
    func setAutoLayout(equalTo view: UILayoutGuide) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

