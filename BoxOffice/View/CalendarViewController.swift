//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/03.
//

import UIKit

protocol UpdateDateDelegate: AnyObject {
    func sendDate(date: Date)
}

final class CalendarViewController: UIViewController {
    private let selectedDate: Date
    weak var delegate: UpdateDateDelegate?
    
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        let yesterday = Date().previousDate()
        
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: yesterday)
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.tintColor = .systemCyan
        
        return calendarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureCalendarView()
    }
    
    init?(date: Date, coder: NSCoder) {
        self.selectedDate = date
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureCalendarView() {
        let selectionSingleDate = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionSingleDate
        selectionSingleDate.selectedDate = selectInitialDate()
    }
    
    private func selectInitialDate() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        
        return components
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        
        delegate?.sendDate(date: date)
        dismiss(animated: true)
    }
}
