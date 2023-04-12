//
//  AlertManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/12.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()
    
    private init() { }
    
    func showAlert(target: UIViewController, alertTitle: String, message: AlertMessage?, style: UIAlertController.Style, okActionTitle: String, cancelActionTitle: String?, okActionHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: alertTitle, message: message?.description, preferredStyle: style)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: okActionHandler)
        alert.addAction(okAction)
        
        if cancelActionTitle != nil {
            let cancleAction = UIAlertAction(title: cancelActionTitle, style: .cancel)
            alert.addAction(cancleAction)
        }
    
        target.present(alert, animated: true)
    }
    
    enum AlertMessage {
        case updating
        
        var description: String {
            switch self {
            case .updating:
                return "오늘 날짜는 집계중입니다.\n다시 선택해주세요."
            }
        }
    }
}
