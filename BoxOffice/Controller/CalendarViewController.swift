//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/03.
//

import UIKit

class CalendarViewController: UIViewController {
    let calendar = Calendar(identifier: .gregorian)
    let calendarView = UICalendarView()
    
    private var yesterday: Date {
        return Date(timeIntervalSinceNow: 3600 * -24)
    }
    
    func configureCalendarView() {
        let dateComponents = DateFormatter.shared.string(from: yesterday, dateFormat: "yyyy-MM-dd")
            .components(separatedBy: "-")
            .compactMap { Int($0) }
        
        calendarView.calendar = calendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .rounded
        let fromDateComponent = DateComponents(calendar: calendar, year: 2003, month: 11, day: 11)
        let toDateComponent = DateComponents(calendar: calendar,
                                                            year: dateComponents[0],
                                                            month: dateComponents[1],
                                                            day: dateComponents[2])
        
        guard let fromDate = fromDateComponent.date,
              let toDate = toDateComponent.date else { return }
        
        calendarView.visibleDateComponents = toDateComponent
        calendarView.availableDateRange = DateInterval(start: fromDate, end: toDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendarView()
    }
}
