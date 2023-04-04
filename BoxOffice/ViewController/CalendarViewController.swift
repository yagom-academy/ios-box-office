//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/04/04.
//

import UIKit

protocol DateChangeable: AnyObject {
    func updateSelectedDate(selectedDate: Date?)
}

@available(iOS 16.0, *)
final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.fontDesign = .default
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko_KR")
    
        calendarView.calendar = calendar
        let fromDate = Calendar.current.date(from: DateComponents(year: 2004, month: 1, day: 1)) ?? Date()
        let endDate = Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 4)) ?? Date()
        calendarView.availableDateRange = DateInterval(start: fromDate,
                                                       end: endDate)
        
        return calendarView
    }()
    
    private let selectedDate: Date
    
    weak var delegate: DateChangeable?
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupCalendarView()
        configureUI()
    }
    
    private func setupCalendarView() {
        self.calendarView.delegate = self
        let singleDateSelection = UICalendarSelectionSingleDate(delegate: self)
        self.calendarView.selectionBehavior = singleDateSelection
        
        calendarView.visibleDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            year: Calendar.current.component(.year, from: self.selectedDate),
            month: Calendar.current.component(.month, from: self.selectedDate)
        )
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.calendarView)
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.calendarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

@available(iOS 16.0, *)
extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return .none
    }
}

@available(iOS 16.0, *)
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        delegate?.updateSelectedDate(selectedDate: dateComponents?.date)
        self.dismiss(animated: true)
    }
}

