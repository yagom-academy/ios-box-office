//
//  UIViewController+AlertController.swift
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
    
    func showIconModeSheet(completion: @escaping (UIAlertAction) -> ()) {
        let actionSheet = UIAlertController(title: "화면모드변경",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "아이콘", style: .default, handler: completion))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    func showListModeSheet(completion: @escaping (UIAlertAction) -> ()) {
        let actionSheet = UIAlertController(title: "화면모드변경",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "리스트", style: .default, handler: completion))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(actionSheet, animated: true)
    }
}
