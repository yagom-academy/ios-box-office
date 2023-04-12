//
//  AlertFactoryService.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

protocol AlertFactoryService {
    var delegate: AlertActionDelegate? { get set }
    func makeAlert(alertData: AlertViewData) -> UIAlertController
}
