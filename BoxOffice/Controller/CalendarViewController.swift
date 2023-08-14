//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/14.
//

import UIKit

final class CalendarViewController: UIViewController {
    private let date: Date
    private let calendarView: UICalendarView = {
        let view: UICalendarView = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let yesterday: Date = DateManager.fetchPastDate(dayAgo: 1)
        var calendarViewDateRange = DateInterval(start: Date(timeIntervalSince1970: 0), end: yesterday)
        view.availableDateRange = calendarViewDateRange
        
        return view
    }()
    weak var delegate: CalendarDelegate?
    
    init(date: Date) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalendar()
        configureView()
        setUpAutoLayout()
    }
    
    private func setCalendar() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        
        dateSelection.selectedDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
        calendarView.selectionBehavior = dateSelection
    }
    
    private func configureView() {
        view.addSubview(calendarView)
        view.backgroundColor = .systemBackground
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        
        delegate?.updateBoxOffice(date: date)
        dismiss(animated: true)
    }
}
