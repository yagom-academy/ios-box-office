//
//  AlertViewData.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

struct AlertViewData {
    let title: String
    let message: String?
    let style: UIAlertController.Style
    let enableOkAction: Bool
    let okActionTitle: String
    let okActionStyle: UIAlertAction.Style
    let enableCancelAction: Bool
    let cancelActionTitle: String?
    let cancelActionStyle: UIAlertAction.Style
    let key: AlertActionKeys
    
    init(title: String,
         message: String?,
         style: UIAlertController.Style,
         enableOkAction: Bool,
         okActionTitle: String,
         okActionStyle: UIAlertAction.Style,
         enableCancelAction: Bool = false,
         cancelActionTitle: String? = "취소",
         cancelActionStyle: UIAlertAction.Style = .cancel,
         key: AlertActionKeys) {
        self.title = title
        self.message = message
        self.style = style
        self.enableOkAction = enableOkAction
        self.okActionTitle = okActionTitle
        self.okActionStyle = okActionStyle
        self.enableCancelAction = enableCancelAction
        self.cancelActionTitle = cancelActionTitle
        self.cancelActionStyle = cancelActionStyle
        self.key = key
    }
}
