//
//  AlertController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/30.
//

import UIKit

enum AlertController {
    static func showAlert(for error: Error, to viewController: UIViewController) {
        let alert = UIAlertController(title: NetworkError.title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .default))
        viewController.present(alert, animated: true)
    }
}
