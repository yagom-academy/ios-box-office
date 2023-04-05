//
//  AlertManager.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/04/03.
//

import UIKit

struct AlertManager {
    static let shared = AlertManager()
    
    private init() { }
    
    func showFailureAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "에러",
            message: "데이터를 불러올 수 없습니다",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        
        return alert
    }
    
    func showScreenMode() -> UIAlertController {
        let actionSheetController = UIAlertController(title: "화면모드 변경", message: nil, preferredStyle: .actionSheet)
        let actionIcon = UIAlertAction(title: "아이콘", style: .default, handler: nil)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheetController.addAction(actionIcon)
        actionSheetController.addAction(actionCancel)
        return actionSheetController
    }
}
