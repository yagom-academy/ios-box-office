//
//  CalendarViewControllerDelegate.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/10.
//

import Foundation

protocol CalendarViewControllerDelegate: AnyObject {
    func updateDate(dateComponents: DateComponents?)
}
