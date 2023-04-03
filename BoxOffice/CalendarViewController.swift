//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/04/03.
//

import UIKit

protocol DateSelectionDelegate: AnyObject {
    func dateSelection(_ date: Date)
}

final class CalendarViewController: UIViewController {
    
    weak var selectionDelegate: DateSelectionDelegate?
    
    private let selectedDate: Date
    private let calendarView = UICalendarView()
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        configureCalendar()
    }
    
    private func setupView() {
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureCalendar() {
        let yesterday: Date = DateManager.createYesterdayDate()
        calendarView.availableDateRange = DateInterval(start:.distantPast, end: yesterday)
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        let selectedDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self.selectedDate)
        dateSelection.selectedDate = selectedDateComponents
        calendarView.selectionBehavior = dateSelection
    }
    
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        selectionDelegate?.dateSelection(date)
        dismiss(animated: true)
    }
    
}
