//
//  CalendarViewControllerDelegate.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/08/08.
//

import Foundation

protocol CalendarViewControllerDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}
