//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/11.
//

import UIKit

final class CalendarViewController: UIViewController {
    weak var delegate: BoxOfficeDelegate?
    
    private let calendarView: UICalendarView = {
        var calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .systemBackground
        
        let endDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        let calendarViewDateRange = DateInterval(start: Date(timeIntervalSince1970: 0), end: endDate)
        calendarView.availableDateRange = calendarViewDateRange
        
        return calendarView
    }()
    
    init(_ date: Date) {
        super.init(nibName: nil, bundle: nil)
        self.setUpCalendarSelection(date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpCalendarSelection(_ date: Date) {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        let components = Calendar.current.dateComponents(in: .current, from: date)
        dateSelection.setSelected(components, animated: false)
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else {
            return
        }
        
        self.delegate?.setUpDate(date)
        self.dismiss(animated: true)
    }
}
