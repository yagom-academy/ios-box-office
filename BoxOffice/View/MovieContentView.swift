//
//  MovieContentView.swift
//  BoxOffice
//
//  Created by Kiseok on 12/7/23.
//

import UIKit

class MovieContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func apply(_ configuration: MovieConfiguration) {
        
    }
}
