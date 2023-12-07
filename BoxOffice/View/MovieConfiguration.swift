//
//  MovieConfiguration.swift
//  BoxOffice
//
//  Created by Kiseok on 12/7/23.
//

import UIKit

struct MovieConfiguration: UIContentConfiguration, Hashable {
    var rank: String?
    var rankFluctuation: String?
    var movieName: String?
    var audienceCount: String?
    var audienceAccumulation: String?
    
    func makeContentView() -> UIView & UIContentView {
        return MovieContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
