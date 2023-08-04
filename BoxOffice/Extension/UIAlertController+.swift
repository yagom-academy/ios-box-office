//
//  UIAlertController+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/02.
//

import UIKit

extension UIAlertController {
    static func errorAlert(_ alertTitle: String?, _ alertMessage: String?, actionTitle: String?, actionType: UIAlertAction.Style) -> UIAlertController {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionType))
        
        return alert
    }
}
