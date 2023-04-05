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




//    func makeCalendarView() {
//        let calendarView =  UICalendarView()
//        calendarView.translatesAutoresizingMaskIntoConstraints = false
//        calendarView.calendar = .current
//        calendarView.locale = .current
//        calendarView.fontDesign = .rounded
//
//        let safeArea = safeAreaLayoutGuide
//        self.addSubview(calendarView)
//
//        NSLayoutConstraint.activate([
//            calendarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            calendarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            calendarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
//            calendarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
//        ])
//    }
