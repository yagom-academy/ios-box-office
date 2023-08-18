//
//  UserDefaults+.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/16.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case viewMode
    }
    
    var viewMode: String {
        get { string(forKey: UserDefaultsKeys.viewMode.rawValue) ?? ViewMode.list.rawValue }
        set { setValue(newValue, forKey: UserDefaultsKeys.viewMode.rawValue) }
    }
}
