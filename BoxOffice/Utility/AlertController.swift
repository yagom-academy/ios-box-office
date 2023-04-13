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
    
    static func showActionSheet(mode: CollectionViewMode, to viewController: DailyBoxOfficeViewController) {
        let actionSheet = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
        
        let alertAction = UIAlertAction(title: mode.oppositeString, style: .default) { action in
            DispatchQueue.main.async {
                viewController.changeCollectionViewMode()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
 
        actionSheet.addAction(alertAction)
        actionSheet.addAction(cancel)
        
        viewController.present(actionSheet, animated: true)
    }
}
