//
//  UIAlertController+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/02.
//

import UIKit

extension UIAlertController {
    static func makedBasicAlert(_ alertTitle: String?, _ alertMessage: String?, actionTitle: String?, actionType: UIAlertAction.Style) -> UIAlertController {
        let alertMessage = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: actionTitle ?? "", style: actionType))
        
        return alertMessage
    }
}
