//
//  CalendarView.swift
//  BoxOffice
//
//  Created by goat songjun on 2023/04/04.
//

import UIKit

class CalendarView: UICalendarView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.availableDateRange = DateInterval(start: Date(timeIntervalSinceReferenceDate: 0), end: Date(timeIntervalSinceNow: -86400))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
