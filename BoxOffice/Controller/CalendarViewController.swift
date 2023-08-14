//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/08.
//

import UIKit

protocol CalendarViewControllerDelegate: AnyObject {
    func calendarViewController(_ calendarViewController: UIViewController, didSelectDate dateComponents: DateComponents?)
}

@available(iOS 16.0, *)
final class CalendarViewController: UIViewController {
    weak var delegate: CalendarViewControllerDelegate?
    private let selectedDate: DateComponents?
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarView
    }()
    
    init(selectedDate: DateComponents?) {
        self.selectedDate = selectedDate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComponents()
        configureUI()
        setupConstraint()
    }
}

// MARK: setup Components
@available(iOS 16.0, *)
extension CalendarViewController {
    private func setupComponents() {
        setupView()
        setupCalendarView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupCalendarView() {
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2004, month: 1, day: 1)

        guard let fromDate = fromDateComponents.date else {
            return
        }

        let calendarViewDateRange = DateInterval(start: fromDate, end: Date.yesterday)
        calendarView.availableDateRange = calendarViewDateRange
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.selectedDate = selectedDate
        calendarView.selectionBehavior = dateSelection
    }
}

// MARK: UICalendarSelectionSingleDateDelegate
@available(iOS 16.0, *)
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        delegate?.calendarViewController(self, didSelectDate: dateComponents)
        dismiss(animated: true)
    }
}

// MARK: configure UI
@available(iOS 16.0, *)
extension CalendarViewController {
    private func configureUI() {
        configureView()
    }
    
    private func configureView() {
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
