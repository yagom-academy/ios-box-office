//
//  UIViewController+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/14.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(error: Error, title: String) {
        let alert = UIAlertController(title: title,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

