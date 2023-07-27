//
//  CanShowNetworkFailiAlert.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

import UIKit

protocol CanShowNetworkFailAlert where Self: UIViewController {
    func showNetworkFailAlert(message: String, retryFunction: @escaping () -> Void)
}

extension CanShowNetworkFailAlert {
    func showNetworkFailAlert(message: String, retryFunction: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        let retryAction = UIAlertAction(title: "다시 시도", style: .default) { _ in
            retryFunction()
        }
       
        alert.addAction(retryAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}
