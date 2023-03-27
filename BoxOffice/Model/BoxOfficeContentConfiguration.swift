//
//  BoxOfficeContentConfiguration.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/27.
//
import UIKit

struct BoxOfficeContentConfiguration: UIContentConfiguration, Hashable {
    var rank: String?
    var title: String?
    var rankColor: UIColor?
    
    func makeContentView() -> UIView & UIContentView {
        return BoxOfficeContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        guard let state = state as? UICellConfigurationState else {
            return self
        }
        
        var updatedConfiguration = self
        if state.isSelected {
            updatedConfiguration.rankColor = .red
        } else {
            updatedConfiguration.rankColor = .blue
        }
        
        return updatedConfiguration
    }
}
