//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/04.
//

import UIKit

final class CalendarViewController: UIViewController {
    private var date: String
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.fontDesign = .rounded
        return calendarView
    }()
    
    init(_ date: String) {
        self.date = date
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
       
        
        configureMainView()
    }
    
    private func configureMainView() {
        view.backgroundColor = .white
        
        configureCalendarView()
    }
    
    private func configureCalendarView() {
        view.addSubview(calendarView)
        
        configureVisibleDate()
        configureCalendarRange()
        configureAutoLayout()
        
    }
    
    private func configureVisibleDate() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        
        calendarView.selectionBehavior = dateSelection
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2022, month: 6, day: 6)
        dateSelection.selectedDate = DateComponents(calendar: Calendar(identifier: .gregorian), year:2022, month: 6, day: 6)
    }
    
    private func configureCalendarRange() {
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2003, month: 11, day: 11)
        let yesterdayDate = Date(timeIntervalSinceNow: -86400)
        
        guard let fromDate = fromDateComponents.date else { return }
        let calendarViewDateRange = DateInterval(start: fromDate, end: yesterdayDate)
        
        calendarView.availableDateRange = calendarViewDateRange
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        let selectedDate = date.convertString()
        print(selectedDate)
    }
}
