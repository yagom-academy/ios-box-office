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
    var delegate: CalendarViewControllerDelegate?
    
    private var yesterday: Date {
        return Date(timeIntervalSinceNow: 3600 * -24)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureCalendarView()
    }
    
    private func configureRootView() {
        view.backgroundColor = .white
        view.addSubview(calendarView)
    }
    
    func configureCalendarView() {
        let dateComponents = DateFormatter.shared
            .string(from: yesterday, dateFormat: "yyyy-MM-dd")
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
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        dateSelection.selectedDate = toDateComponent
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        delegate?.changeTarget(date: date)
        
        self.dismiss(animated: true)
    }
}

protocol CalendarViewControllerDelegate {
    func changeTarget(date: Date)
}
