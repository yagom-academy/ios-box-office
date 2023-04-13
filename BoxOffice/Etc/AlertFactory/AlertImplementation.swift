//
//  AlertImplementation.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

final class AlertImplementation: AlertFactoryService {
    
    func makeAlert(alertData: AlertViewData) -> UIAlertController {
        let alertController = UIAlertController(title: alertData.title,
                                                message: alertData.message,
                                                preferredStyle: alertData.style)
        
        if alertData.enableOkAction {
            let okAction = UIAlertAction(
                title: alertData.okActionTitle,
                style: alertData.okActionStyle) { _ in
                    alertData.completion?()
                }
            alertController.addAction(okAction)
        }
        
        if alertData.enableCancelAction {
            let cancelAction = UIAlertAction(
                title: alertData.cancelActionTitle,
                style: alertData.cancelActionStyle) { _ in
                    alertData.completion?()
                }
            alertController.addAction(cancelAction)
        }
        return alertController
    }
}
