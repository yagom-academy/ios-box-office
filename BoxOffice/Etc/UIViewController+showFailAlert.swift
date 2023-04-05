//
//  UIViewController+showFailAlert.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/31.
//

import UIKit

extension UIViewController {
    func showFailAlert(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message:"데이터 로딩 실패 \n \(error.localizedDescription)" ,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
