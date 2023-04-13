//
//  AlertFactoryService.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

protocol AlertFactoryService {
    func makeAlert(alertData: AlertViewData) -> UIAlertController
}
