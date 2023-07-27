//
//  CanShowNetworkFailiAlert.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

import UIKit

protocol CanShowNetworkFailAlert where Self: UIViewController {
    func showNetworkFailAlert(message: String)
}

extension CanShowNetworkFailAlert {
    func showNetworkFailAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: "확인", style: .default)
       
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}
