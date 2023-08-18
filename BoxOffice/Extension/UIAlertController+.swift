//
//  UIAlertController+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/02.
//

import UIKit

extension UIAlertController {    
    static func customAlert(alertTile: String?, alertMessage: String?, preferredStyle: UIAlertController.Style, alertActions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: alertTile, message: alertMessage, preferredStyle: preferredStyle)
        alertActions.forEach {
            alert.addAction($0)
        }
        
        return alert
    }
}
