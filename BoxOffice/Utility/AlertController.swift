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
        let icon = UIAlertAction(title: "아이콘", style: .default) { action in
            viewController.changeCollectionViewMode()
        }
        let list = UIAlertAction(title: "리스트", style: .default) { action in
            viewController.changeCollectionViewMode()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        switch mode {
        case .icon:
            actionSheet.addAction(list)
        case .list:
            actionSheet.addAction(icon)
        }
        actionSheet.addAction(cancel)
        
        viewController.present(actionSheet, animated: true)
    }
}
