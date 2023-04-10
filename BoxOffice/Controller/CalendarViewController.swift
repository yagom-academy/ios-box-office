//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/03.
//

import UIKit

final class CalendarViewController: UIViewController {
    private let calendar: Calendar
    private let calendarView = UICalendarView()
    private var targetDate: Date?
    private var yesterday: Date {
        return Date(timeIntervalSinceNow: 3600 * -24)
    }
    
    private weak var delegate: CalendarViewControllerDelegate?
    
    init(targetDate: Date,
         calendar: Calendar = Calendar(identifier: .gregorian),
         delegate: CalendarViewControllerDelegate?) {
        self.targetDate = targetDate
        self.calendar = calendar
        self.delegate = delegate
        
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
        guard let targetDate = self.targetDate else { return }
        
        calendarView.calendar = calendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .rounded
        
        let fromDateComponent = DateComponents(calendar: calendar, year: 2003, month: 11, day: 11)
        let toDateComponent = createDateComponent(with: yesterday)
        let selectedDateComponent = createDateComponent(with: targetDate)
        
        guard let fromDate = fromDateComponent.date,
              let toDate = toDateComponent.date else { return }
        
        calendarView.visibleDateComponents = toDateComponent
        calendarView.availableDateRange = DateInterval(start: fromDate, end: toDate)
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.selectedDate = selectedDateComponent
        
        calendarView.selectionBehavior = dateSelection
    }
    
    private func createDateComponent(with date: Date) -> DateComponents {
        let dateComponents = DateFormatter.shared
            .string(from: date, dateFormat: "yyyy-MM-dd")
            .components(separatedBy: "-")
            .compactMap { Int($0) }
        
        return DateComponents(calendar: calendar,
                              year: dateComponents[safe: 0],
                              month: dateComponents[safe: 1],
                              day: dateComponents[safe: 2])
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
