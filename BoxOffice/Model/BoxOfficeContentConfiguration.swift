//
//  BoxOfficeContentConfiguration.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/03/27.
//
import UIKit

struct BoxOfficeContentConfiguration: UIContentConfiguration, Hashable {
    var rank: String?
    var rankIncrement: String?
    var rankOldAndNew: String?
    var title: String?
    var audienceCount: String?
    var audienceAccumulationCount: String?
    
    
    func makeContentView() -> UIView & UIContentView {
        return BoxOfficeContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        guard let _ = state as? UICellConfigurationState else {
            return self
        }
        
        let updatedConfiguration = self
        
        return updatedConfiguration
    }
}
