//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/05.
//

import UIKit

class CalendarViewController: UIViewController {
    
    var selectedDate = Date()
    let yesterday = {
        guard let yesterday = Date.yesterday else {
            return Date()
        }
        return yesterday
    }()
    
    private let calendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ko_KR")
        
        return calendarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        restrictDateRange()
    }
    
    private func restrictDateRange() {
        let calendar = Calendar.current
        let yesterdayComponents = calendar.dateComponents([.year, .month, .day], from: yesterday)
        let year = yesterdayComponents.year
        let month = yesterdayComponents.month
        let day = yesterdayComponents.day
        
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2012, month: 1, day: 1)
        let toDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: day)
        
        guard let fromDate = fromDateComponents.date, let toDate = toDateComponents.date else {
            return
        }
        
        let calendarViewDateRange = DateInterval(start: fromDate, end: toDate)
        calendarView.availableDateRange = calendarViewDateRange
    }
    
    private func configureUI() {
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
    }

}
