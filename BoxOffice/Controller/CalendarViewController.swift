//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/08.
//

import UIKit

@available(iOS 16.0, *)
final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCalendarView()
        
        configureUI()
        setupConstraint()
    }
    
    private func setupCalendarView() {
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2004, month: 1, day: 1)

        guard let fromDate = fromDateComponents.date,
              let toDate = DateFormatter().date(before: 1) else {
            return
        }

        let calendarViewDateRange = DateInterval(start: fromDate, end: toDate)
        calendarView.availableDateRange = calendarViewDateRange
    }
}

// MARK: configure UI
@available(iOS 16.0, *)
extension CalendarViewController {
    private func configureUI() {
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
    }
}

// MARK: setup Constraint
@available(iOS 16.0, *)
extension CalendarViewController {
    private func setupConstraint() {
        setupCalendarConstrait()
    }
    
    private func setupCalendarConstrait() {
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
