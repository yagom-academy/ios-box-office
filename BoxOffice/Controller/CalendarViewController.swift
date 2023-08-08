//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/08/08.
//

import UIKit

class CalendarViewController: UIViewController {
    var calendarView: UICalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCalendarView()
    }
    
    private func showCalendarView() {
        let currentDate = Date()
        guard let pastDate = Calendar.current.date(byAdding: .year, value: -10, to: currentDate) else { return }
        calendarView = UICalendarView(frame: CGRect(x: 0, y: 0,
                                                    width: view.bounds.width,
                                                    height: view.bounds.height))
        calendarView.availableDateRange = DateInterval(start: pastDate, end: currentDate)
        calendarView.backgroundColor = .white
        view.addSubview(calendarView)
    }
}
