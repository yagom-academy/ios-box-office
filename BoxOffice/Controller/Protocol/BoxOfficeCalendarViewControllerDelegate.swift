//
//  BoxOfficeCalendarViewControllerDelegate.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/15.
//

import Foundation

protocol BoxOfficeCalendarViewControllerDelegate: AnyObject {
    func didTapSelectedDate(_ date: Date)
}
