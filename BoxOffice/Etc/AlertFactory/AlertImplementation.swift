//
//  AlertImplementation.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

class AlertImplementation: AlertFactoryService {
    weak var delegate: AlertActionDelegate?
    
    func build(alertData: AlertViewData) -> UIViewController {
        let vc = UIAlertController(title: alertData.title,
                                   message: alertData.message,
                                   preferredStyle: alertData.style)
        
        if alertData.enableOkAction {
            let okAction = UIAlertAction(
                           title: alertData.okActionTitle,
                           style: alertData.okActionStyle)
            { [weak self] _ in
               self?.delegate?.okAction()
            }
            vc.addAction(okAction)
        }
        
        if alertData.enableCancelAction {
            let cancelAction = UIAlertAction(
                               title: alertData.cancelActionTitle,
                               style: alertData.cancelActionStyle)
            { [weak self] _ in
               self?.delegate?.cancelAction()
            }
            vc.addAction(cancelAction)
        }
        return vc
    }
}
