//
//  CalendarViewControllerDelegate.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/08/08.
//

import Foundation

protocol CalendarViewControllerDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}
