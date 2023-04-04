//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/04/04.
//

import UIKit

@available(iOS 16.0, *)
final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.fontDesign = .default
        calendarView.visibleDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            year: Calendar.current.component(.year, from: Date()),
            month: Calendar.current.component(.month, from: Date()),
            day: Calendar.current.component(.day, from: Date())
        )
        let fromDate = Calendar.current.date(from: DateComponents(year: 2004, month: 1, day: 1)) ?? Date()
        calendarView.availableDateRange = DateInterval(start: fromDate,
                                                       end: Date())
        
        return calendarView
    }()
    
    override func viewDidLoad() {
        setupCalendarView()
        configureUI()
    }
    
    private func setupCalendarView() {
        self.calendarView.delegate = self
        let singleDateSelection = UICalendarSelectionSingleDate(delegate: self)
        self.calendarView.selectionBehavior = singleDateSelection
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
    }
}

