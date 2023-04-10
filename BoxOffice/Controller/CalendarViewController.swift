//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/04/05.
//

import UIKit

final class CalendarViewController: UIViewController {
    private let calendarView = UICalendarView()
    private let gregorianCalendar = Calendar(identifier: .gregorian)
    weak var delegate: DateUpdatableDelegate?
    let currentDate: String?
    var selectedDate: DateComponents?
    let dateFormatter: DateFormatter
    
    init(currentDate: String? = nil, dateFormatter: DateFormatter) {
        self.currentDate = currentDate
        self.dateFormatter = dateFormatter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
        configureLayout()
        configureDateSelection()
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemBackground
        self.selectedDate = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            year: currentDate?.toDate(formatter: dateFormatter)?.year,
            month: currentDate?.toDate(formatter: dateFormatter)?.month,
            day: currentDate?.toDate(formatter: dateFormatter)?.day
        )
        configureCalendarOption()
    }
    
    private func configureCalendarOption() {
        let startDateComponent = DateComponents(calendar: Calendar(identifier: .gregorian),
                                                year: 2003,
                                                month: 11,
                                                day: 11)
        
        guard let startDate = gregorianCalendar.date(from: startDateComponent) else { return }
        
        let calendarViewDateRange = DateInterval(start: startDate, end: Date().yesterday)
        
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.fontDesign = .default
        calendarView.availableDateRange = calendarViewDateRange
        calendarView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    private func configureDateSelection() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        
        calendarView.selectionBehavior = dateSelection
        dateSelection.selectedDate = selectedDate
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDate = dateComponents,
              let targetDate = gregorianCalendar.date(from: selectedDate) else { return }
        
        delegate?.update(date: targetDate)
        self.dismiss(animated: true)
    }
}
