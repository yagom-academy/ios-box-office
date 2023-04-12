//
//  AlertImplementation.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

final class AlertImplementation: AlertFactoryService {
    weak var delegate: AlertActionDelegate?
    
    func makeAlert(alertData: AlertViewData) -> UIViewController {
        let alertController = UIAlertController(title: alertData.title,
                                   message: alertData.message,
                                   preferredStyle: alertData.style)
        
        if alertData.enableOkAction {
            let okAction = UIAlertAction(
                           title: alertData.okActionTitle,
                           style: alertData.okActionStyle)
            { [weak self] _ in
               self?.delegate?.okAction?()
            }
            alertController.addAction(okAction)
        }
        
        if alertData.enableCancelAction {
            let cancelAction = UIAlertAction(
                               title: alertData.cancelActionTitle,
                               style: alertData.cancelActionStyle)
            { [weak self] _ in
                self?.delegate?.cancelAction?()
            }
            alertController.addAction(cancelAction)
        }
        return alertController
    }
    
    func makeActionSheet(alertData: AlertViewData) -> UIViewController {
        let alertController = UIAlertController(title: alertData.title,
                                   message: alertData.message,
                                   preferredStyle: alertData.style)
        
        if alertData.enableOkAction {
            let okAction = UIAlertAction(
                           title: alertData.okActionTitle,
                           style: alertData.okActionStyle)
            { [weak self] _ in
               self?.delegate?.firstAction?()
            }
            alertController.addAction(okAction)
        }
        
        if alertData.enableCancelAction {
            let cancelAction = UIAlertAction(
                               title: alertData.cancelActionTitle,
                               style: alertData.cancelActionStyle)
            { [weak self] _ in
                self?.delegate?.secondAction?()
            }
            alertController.addAction(cancelAction)
        }
        return alertController
    }
}
