//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/03.
//

import UIKit

final class CalendarViewController: UIViewController {
    private let calendar = Calendar(identifier: .gregorian)
    private let calendarView = UICalendarView()
    var delegate: CalendarViewControllerDelegate?
    private var currentDate: Date?
    private var yesterday: Date {
        return Date(timeIntervalSinceNow: 3600 * -24)
    }
    
    init(currentDate: Date) {
        self.currentDate = currentDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureCalendarView()
        configureLayout()
    }
    
    private func configureRootView() {
        view.backgroundColor = .white
        view.addSubview(calendarView)
    }
    
    private func configureCalendarView() {
        guard let currentDate = self.currentDate else { return }
        
        let dateComponents = DateFormatter.shared
            .string(from: yesterday, dateFormat: "yyyy-MM-dd")
            .components(separatedBy: "-")
            .compactMap { Int($0) }
        
        let currentDateComponents = DateFormatter.shared
            .string(from: currentDate, dateFormat: "yyyy-MM-dd")
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
        let selectedDateComponent = DateComponents(calendar: calendar,
                                               year: currentDateComponents[0],
                                               month: currentDateComponents[1],
                                               day: currentDateComponents[2])
        guard let fromDate = fromDateComponent.date,
              let toDate = toDateComponent.date else { return }
        
        calendarView.visibleDateComponents = toDateComponent
        calendarView.availableDateRange = DateInterval(start: fromDate, end: toDate)
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        dateSelection.selectedDate = selectedDateComponent
    }
    
    private func configureLayout() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
