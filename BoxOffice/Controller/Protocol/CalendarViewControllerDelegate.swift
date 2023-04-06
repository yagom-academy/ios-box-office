//
//  CalendarViewControllerDelegate.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/06.
//

import Foundation

protocol CalendarViewControllerDelegate: AnyObject {
    func changeTarget(date: Date)
}
